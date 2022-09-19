import datetime
import logging
import rds_config
import sys

from opensearchpy import OpenSearch
from pymysql      import connect, cursors, MySQLError


# config file containing credentials for RDS MySQL instance
DB_ARGS                = rds_config.DB_ARGS
DB_ARGS["cursorclass"] = cursors.DictCursor

# SQL
select_sql = rds_config.select_sql

# Opensearch settings
HOST   = "https://vpc-glaciermelt-opensearch-jnjn5m4vcddhpjwxfivz3vo5iy.ap-northeast-1.es.amazonaws.com"
REGION = "ap-northeast-1"

# Mapping and setting definition
PROPERTIES = rds_config.properties
INDEX      = rds_config.index


logger = logging.getLogger()
logger.setLevel(logging.INFO)

try:
    connection = connect(**DB_ARGS)
except MySQLError as e:
    logger.error("ERROR: Unexpected error: Could not connect to MySQL instance.")
    logger.error(e)
    sys.exit()

logger.info("SUCCESS: Connection to RDS MySQL instance succeeded")

os_client = OpenSearch(
    hosts   = [{'host': HOST, 'port': 443}],
    use_ssl = True,
)


def handler(event, context):
    logger.info("START: handler")

    new_index = create_index()
    bulk_docs = execute_rds(new_index)
    execute_bulk()


def create_index():
    logger.info("START: create index")

    t_delta = datetime.timedelta(hours = 9)
    JST     = datetime.timezone(t_delta, 'JST')
    now     = datetime.datetime.now(JST)
    d       = now.strftime('%Y_%m_%d_%H_%M_%S')

    index_name = f'job_posting_{d}'
    index_body = { 'mappings': PROPERTIES, 'settings': INDEX }

    response = os_client.indices.create(index_name, body = index_body)
    logger.info(f'Creating index: {response}')
    return index_name


def execute_rds(new_index_name):
    logger.info("START: execute_rds")

    temp_doc  = {}
    docs      = []

    with connection.cursor() as cursor:
        logger.info("start cursor")

        cursor.execute(select_sql)
        rows = cursor.fetchall()

    for row in rows:
        index_id = str(row["job_posting_id"])

        temp_doc["job_posting_id"]    = row["job_posting_id"]
        temp_doc["job"]               = row["job"]
        temp_doc["contract"]          = row["contract"]
        temp_doc["join_period"]       = row["join_period"]
        temp_doc["job_category"]      = row["job_category"]
        temp_doc["org_typedef"]       = row["org_typedef"]
        temp_doc["facility_category"] = row["facility_category"]
        temp_doc["facility_tags"]     = row["facility_tags"]

        if row["geo_location1"] == None:
            temp_doc["pref"]   = row["None"]
            temp_doc["city"]   = row["None"]
            temp_doc["ward"]   = row["None"]
            temp_doc["county"] = row["None"]
            temp_doc["town"]   = row["None"]
            doc = temp_doc
        elif has_parent(row["geo_location1"]) == false:
            doc = get_location(row["geo_location1"], temp_doc)
        else:
            if has_parent(row["geo_location2"]) == false:
                doc = get_location(row["geo_location2"], temp_doc)
            else:
                doc = get_location(row["geo_location3"], temp_doc)

        docs.append(doc)
        docs.append({
            "_index":        new_index_name,
            "_id":           index_id,
            "_source":       doc
        })

    connection.close()
    logger.info("after connection close")
    return docs


def has_parent(key):
    with connection.cursor() as cursor:
        cursor.execute(f"""\
            SELECT
              id
            FROM
              agent_one.common_geo_location
            WHERE
              parent = {key};
        """)
        has_rows = cursor.fetchall()
        return len(has_rows) > 0


def get_location(get_key, get_temp_doc):
    with connection.cursor() as cursor:
        cursor.execute(f"""\
            SELECT
              pref,
              city,
              ward,
              county,
              town
            FROM
              agent_one.common_geo_location
            WHERE
              id = {get_key};
        """)
        get_rows = cursor.fetchall()

        for get_row in get_rows:
            get_temp_doc["pref"]   = get_row["pref"]
            get_temp_doc["city"]   = get_row["city"]
            get_temp_doc["ward"]   = get_row["ward"]
            get_temp_doc["county"] = get_row["county"]
            get_temp_doc["town"]   = get_row["town"]

    return get_temp_doc


def execute_bulk(ex_docs):
    BULK_NUMBER = 500
    num         = len(ex_docs) / BULK_NUMBER
    flag        = len(ex_docs) % BULK_NUMBER

    for i in num:
        part_docs = ex_docs[BULK_NUMBER * (i - 1) : BULK_NUMBER * i]
        response = helpers.bulk(os_client, part_docs, max_retries = 3)
        logger.info(f"Adding bulk documents using helper: {response}")

    if flag > 0:
        part_docs = ex_docs[BULK_NUMBER * num : BULK_NUMBER * num + flag]
        response = helpers.bulk(os_client, part_docs, max_retries = 3)
        logger.info(f"Adding bulk documents using helper: {response}")

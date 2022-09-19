# config file containing credentials for RDS MySQL instance
DB_HOST = "main.cluster-ro-caopglrgm7fc.ap-northeast-1.rds.amazonaws.com"
DB_USER = "glaciermelt00"
DB_PASS = "WNHRUEL4QS6D"
DB_NAME = "glaciermelt"

DB_ARGS = {
    "host":            DB_HOST,
    "user":            DB_USER,
    "password":        DB_PASS,
    "database":        DB_NAME,
    "autocommit":      True,
    "connect_timeout": 5,
}

# Elasticsearch setting
ENDPOINT = ""


# SQL
select_sql = """\
    SELECT
      job_posting.id AS job_posting_id,
      facility_location.geo_location1,
      facility_location.geo_location2,
      facility_location.geo_location3,
      job_posting.job,
      job_posting.contract,
      job_posting.join_period,
      job_posting_trait_preschool.category AS job_category,
      organization.typedef AS org_typedef,
      facility.category AS facility_category,
      facility_trait_preschool.tags AS facility_tags
    FROM
      agent_one_customer.facility AS facility
    LEFT JOIN
      agent_one_customer.organization AS organization
    ON
      facility.organization = organization.id
    LEFT JOIN
      agent_one_customer.facility_trait_preschool AS facility_trait_preschool
    ON
      facility.id = facility_trait_preschool.fid
    INNER JOIN
      agent_one_customer.job_posting AS job_posting
    ON
      facility.id = job_posting.fid
    LEFT JOIN
      agent_one_customer.job_posting_trait_preschool AS job_posting_trait_preschool
    ON
      job_posting.id = job_posting_trait_preschool.pid
    LEFT JOIN
      agent_one_customer.facility_location AS facility_location
    ON
      facility.id = facility_location.fid
    ORDER BY job_posting.id;
"""


# Mapping and setting definition
properties = {
  "properties": {
    "job_posting_id":    { "type": "long" },
    "pref":              { "type": "keyword" },
    "city":              { "type": "keyword" },
    "ward":              { "type": "keyword" },
    "county":            { "type": "keyword" },
    "town":              { "type": "keyword" },
    "job":               { "type": "keyword" },
    "contract":          { "type": "keyword" },
    "join_period":       { "type": "keyword" },
    "job_category":      { "type": "keyword" },
    "org_typedef":       { "type": "keyword" },
    "facility_category": { "type": "keyword" },
    "facility_tags":     { "type": "keyword" }
  }
}

index = {
  "index": {
    "number_of_shards" :   1,
    "number_of_replicas" : 0
  }
}

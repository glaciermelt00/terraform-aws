output vpc_ips {
  value = {
    root            = "10.0.0.0/16"
    packages        = "10.1.0.0/16"
    glaciermelt     = "10.16.0.0/16"
    glaciermelt_stg = "10.17.0.0/16"
  }
}

//---[ Root ]-------------------------------------------------------------------
output subnet_ips_root {
  value = {
    c_global  = "10.0.0.0/20"
    a_global  = "10.0.16.0/20"
    d_global  = "10.0.32.0/20"
    c_private = "10.0.128.0/20"
    a_private = "10.0.144.0/20"
    d_private = "10.0.160.0/20"
  }
}

//---[ Packages ]---------------------------------------------------------------
output subnet_ips_packages {
  value = {
    c_global  = "10.1.0.0/20"
    a_global  = "10.1.16.0/20"
    d_global  = "10.1.32.0/20"
    c_private = "10.1.128.0/20"
    a_private = "10.1.144.0/20"
    d_private = "10.1.160.0/20"
  }
}

//---[ Glaciermelt ]------------------------------------------------------------
output subnet_ips_glaciermelt {
  value = {
    c_global  = "10.16.0.0/20"
    a_global  = "10.16.16.0/20"
    d_global  = "10.16.32.0/20"
    c_private = "10.16.128.0/20"
    a_private = "10.16.144.0/20"
    d_private = "10.16.160.0/20"
  }
}

output subnet_ips_glaciermelt_stg {
  value = {
    c_global  = "10.17.0.0/20"
    a_global  = "10.17.16.0/20"
    d_global  = "10.17.32.0/20"
    c_private = "10.17.128.0/20"
    a_private = "10.17.144.0/20"
    d_private = "10.17.160.0/20"
  }
}

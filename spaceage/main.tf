locals {
  main_domain = "spaceage.mp"
}

module "domain" {
  source = "../modules/domain"

  domain = local.main_domain

  cloudns_auth_id  = var.cloudns_auth_id
  cloudns_password = var.cloudns_password

  fastmail      = true
  ses           = true
  root_aname    = "redfox.doridian.net"
  add_www_cname = true
  vanity_nameserver = {
    list = ["ns1.doridian.net", "ns2.doridian.net", "ns3.doridian.net", "ns4.doridian.net"]
    name = "doridian.net"
  }
  registrar = "dotmp"
}

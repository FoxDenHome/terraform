module "domain" {
  source = "../modules/domain"

  domain = "spaceage.mp"

  fastmail       = true
  ses            = true
  root_aname     = "spaceage.mp"
  root_aname_ttl = 300
  add_www_cname  = true

  manual_dnskey_records = []
  manual_ds_records     = []

  vanity_nameserver = {
    list = ["ns1.doridian.net", "ns2.doridian.net", "ns3.doridian.net", "ns4.doridian.net"]
    name = "doridian.net"
  }

  cloudns_auth_id  = var.cloudns_auth_id
  cloudns_password = var.cloudns_password

  additional_statuses = []
  registrar           = "getmp"
}

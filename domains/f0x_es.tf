resource "cloudns_dns_record" "f0x_es_c0de" {
  zone = "f0x.es"

  type  = "CNAME"
  name  = "c0de"
  ttl   = 3600
  value = "c0defox.es"
}

resource "cloudns_dns_record" "f0x_es_vixus" {
  zone = "f0x.es"

  type  = "CNAME"
  name  = "vixus"
  ttl   = 3600
  value = "arcticfox.doridian.net"
}

local {
  xmpp_ports = {
    "_xmpp-client._tcp" = 5222,
    "_xmpp-server._tcp" = 5269,
  }
}

# resource "cloudns_dns_record" "f0x_es_jabber" {
#   for_each = local.xmpp_ports
#   zone     = "f0x.es"

#   type = "SRV"
#   name = each.key
#   port = each.value

#   value    = "redfox.doridian.net"
#   priority = 10
#   weight   = 10

#   ttl = 3600
# }

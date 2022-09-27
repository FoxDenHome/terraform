resource "constellix_vanity_nameserver" "vanity" {
  for_each = { for k, zone in local.domains : try(zone.vanity_nameserver, "doridian.net") => true... if try(zone.vanity_nameserver, "doridian.net") != null }

  name                   = each.key
  nameserver_group       = 1
  nameserver_list_string = "ns1.${each.key},\nns2.${each.key},\nns3.${each.key},\nns4.${each.key},\nns5.${each.key},\nns6.${each.key}"
}

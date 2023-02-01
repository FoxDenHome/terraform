locals {
  domain_contact_full_name = join(" ", compact([var.domain_contact.first_name, var.domain_contact.middle_name, var.domain_contact.last_name]))

  domains = merge({
    "doridian.de"  = {},
    "doridian.net" = {},

    "f0x.es" = {
      vanity_nameserver     = "cloudflare-f0x-es",
      manual_dnskey_records = [
        "257 3 13 mdsswUyr3DPW132mOi8V9xESWE8jTo0dxCjjnopKl+GqJxpVXckHAeF+KkxLbxILfDLUT0rAK9iUzy1L53eKGQ==",
        "256 3 13 oJMRESz5E4gYzS/q6XDrvU1qMPYIjCWzJaOau8XNEZeqCYKD5ar0IRd8KqXXFJkqmVfRvMGPmM1x8fGAa2XhSA==",
      ],
      manual_ds_records = [
        "2371 13 2 2393DC36DF6D524F95D71D403618694EB765B81D558B8B0E8678AD5723CB2F3D"
      ],
    },
    "foxcav.es" = {},

    "foxden.network" = {
      vanity_nameserver     = "foxden.network",
      manual_dnskey_records = [],
      manual_ds_records     = [],
    },
  }, var.domains)

  contacts_map = {
    "hexonet" = [hexonet_contact.main.id],
    "inwx"    = [inwx_domain_contact.main.id],
  }

  default_vanity_nameserver = "doridian.net"

  redfox = {
    ipv4 = "66.42.71.230"
    ipv6 = "2a0e:7d44:f000:0:0:0:0:e621"
  }
}

module "domain" {
  source = "../modules/domain"

  for_each = local.domains

  domain = each.key

  fastmail          = true
  ses               = true
  root_aname        = var.main_domain
  add_www_cname     = true
  vanity_nameserver = local.vanity_nameservers[try(each.value.vanity_nameserver, local.default_vanity_nameserver)]

  manual_dnskey_records = try(each.value.manual_dnskey_records, null)

  cloudns_auth_id  = var.cloudns_auth_id
  cloudns_password = var.cloudns_password

  extra_attributes = {
    "WHOIS-URL" = "https://doridian.net",
    "WHOIS-RSP" = "Doridian",
    "WHOIS-BANNER0" : "Foxes are best animal",
  }

  owner_contacts   = local.contacts_map[try(each.value.registrar, "hexonet")]
  admin_contacts   = local.contacts_map[try(each.value.registrar, "hexonet")]
  tech_contacts    = local.contacts_map[try(each.value.registrar, "hexonet")]
  billing_contacts = local.contacts_map[try(each.value.registrar, "hexonet")]

  registrar = try(each.value.registrar, "hexonet")
}

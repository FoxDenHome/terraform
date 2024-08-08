locals {
  domain_contact_full_name = join(" ", compact([var.domain_contact.first_name, var.domain_contact.middle_name, var.domain_contact.last_name]))

  domains = merge({
    "doridian.de"  = {},
    "doridian.net" = {},

    "f0x.es"    = {},
    "foxcav.es" = {},

    "darksignsonline.com" = {
      root_aname     = "arcticfox.doridian.net",
      root_aname_ttl = 3600,
      add_www_cname  = true,
    },

    "foxden.network" = {
      root_aname            = null,
      vanity_nameserver     = "foxden.network",
      manual_dnskey_records = [],
      manual_ds_records     = [
        "26212 13 2 9C50921B3FDB72B43A78713AF57E66D2BBA87C6CFDEC4FC2EA1320686B31FED4", # ClouDNS
        "56289 13 2 E0198538615845C4226057A4A9D3908FF76A054A49B76E72954D63BFCB88A257", # router + router-backup
      ],
    },
  }, var.domains)

  contacts_map = {
    "hexonet" = [hexonet_contact.main.id],
    "inwx"    = [],
  }

  default_vanity_nameserver = "doridian.net"
}

module "domain" {
  source = "../modules/domain"

  for_each = local.domains

  domain = each.key

  fastmail          = true
  ses               = true
  root_aname        = try(each.value.root_aname, var.main_domain)
  root_aname_ttl    = try(each.value.root_aname_ttl, 300)
  add_www_cname     = try(each.value.add_www_cname, true)
  vanity_nameserver = local.vanity_nameservers[try(each.value.vanity_nameserver, local.default_vanity_nameserver)]

  manual_dnskey_records = try(each.value.manual_dnskey_records, null)
  manual_ds_records     = try(each.value.manual_ds_records, null)

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

  additional_statuses = try(each.value.additional_statuses, [])
  registrar           = try(each.value.registrar, "hexonet")
}

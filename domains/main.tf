locals {
  domain_contact_full_name = join(" ", compact([var.domain_contact.first_name, var.domain_contact.middle_name, var.domain_contact.last_name]))

  domains = merge({
    "doridian.de" = {
      fastmail          = true,
      ses               = true,
      add_root_aname    = true,
      add_www_cname     = true,
      vanity_nameserver = "doridian.net",
      extra_attributes  = {},
    },
    "doridian.net" = {
      fastmail          = true,
      ses               = true,
      add_root_aname    = true,
      add_www_cname     = true,
      vanity_nameserver = "doridian.net",
      extra_attributes  = { "ACCEPT-WHOISTRUSTEE-TAC" = "0" },
    },

    "f0x.es" = {
      fastmail          = true,
      ses               = true,
      add_root_aname    = true,
      add_www_cname     = true,
      vanity_nameserver = "doridian.net",
      extra_attributes  = {},
    },
    "foxcav.es" = {
      fastmail          = true,
      ses               = true,
      add_root_aname    = true,
      add_www_cname     = true,
      vanity_nameserver = "doridian.net",
      extra_attributes  = {},
    },

    "foxden.network" = {
      fastmail          = true,
      ses               = true,
      add_root_aname    = true,
      add_www_cname     = true,
      vanity_nameserver = "foxden.network",
      extra_attributes  = { "ACCEPT-WHOISTRUSTEE-TAC" = "0" },
    },
  }, var.domains)

  contacts_map = {
    "hexonet" = [hexonet_contact.main.id],
    "inwx"    = [inwx_domain_contact.main.id],
  }
}

module "domain" {
  source = "../modules/domain"

  for_each = local.domains

  domain = each.key

  fastmail          = each.value.fastmail
  ses               = each.value.ses
  root_aname        = each.value.add_root_aname ? var.main_domain : null
  add_www_cname     = each.value.add_www_cname
  vanity_nameserver = try(constellix_vanity_nameserver.vanity[each.value.vanity_nameserver], null)

  extra_attributes = merge({
    "WHOIS-URL" = "https://doridian.net",
    "WHOIS-RSP" = "Doridian",
    "WHOIS-BANNER0" : "Foxes are best animal",
  }, try(each.value.extra_attributes, {}))

  owner_contacts   = local.contacts_map[try(each.value.registrar, "hexonet")]
  admin_contacts   = local.contacts_map[try(each.value.registrar, "hexonet")]
  tech_contacts    = local.contacts_map[try(each.value.registrar, "hexonet")]
  billing_contacts = local.contacts_map[try(each.value.registrar, "hexonet")]

  registrar = try(each.value.registrar, "hexonet")
}

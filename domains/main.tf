locals {
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

    "foxden.network" = {
      fastmail          = true,
      ses               = true,
      add_root_aname    = true,
      add_www_cname     = true,
      vanity_nameserver = "foxden.network",
      extra_attributes  = { "ACCEPT-WHOISTRUSTEE-TAC" = "0" },
    },

    "fox.ax" = {
      fastmail          = true,
      ses               = true,
      add_root_aname    = true,
      add_www_cname     = true,
      vanity_nameserver = "doridian.net",
      registrar         = "inwx"
    },
  }, var.domains)
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

  owner_contacts   = [hexonet_contact.main.id]
  admin_contacts   = [hexonet_contact.main.id]
  tech_contacts    = [hexonet_contact.main.id]
  billing_contacts = [hexonet_contact.main.id]

  registrar = try(each.value.registrar, "hexonet")
}

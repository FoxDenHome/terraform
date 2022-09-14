locals {
  extra_attributes_es = {
    "ES-ADMIN-TIPO-IDENTIFICACION"   = 0,
    "ES-TECH-TIPO-IDENTIFICACION"    = 0,
    "ES-BILLING-TIPO-IDENTIFICACION" = 0,

    "ES-ADMIN-IDENTIFICACION"   = var.domain_contact.id_number,
    "ES-TECH-IDENTIFICACION"    = var.domain_contact.id_number,
    "ES-BILLING-IDENTIFICACION" = var.domain_contact.id_number,
  }

  domains = merge({
    "as207618.net" = {
      fastmail          = true,
      ses               = true,
      add_root_aname    = true,
      add_www_cname     = true,
      vanity_nameserver = "doridian.net",
      extra_attributes  = { "ACCEPT-WHOISTRUSTEE-TAC" = "0" },
    },
    "pawnode.com" = {
      fastmail          = true,
      ses               = true,
      add_root_aname    = true,
      add_www_cname     = true,
      vanity_nameserver = "doridian.net",
      extra_attributes  = { "ACCEPT-WHOISTRUSTEE-TAC" = "0" },
    },

    "doridian.com" = {
      fastmail          = true,
      ses               = true,
      add_root_aname    = true,
      add_www_cname     = true,
      vanity_nameserver = "doridian.net",
      extra_attributes  = { "ACCEPT-WHOISTRUSTEE-TAC" = "0" },
    },
    "doridian.de" = {
      fastmail          = true,
      ses               = true,
      add_root_aname    = true,
      add_www_cname     = true,
      vanity_nameserver = "doridian.net",
      extra_attributes  = {},
    },
    "doridian.org" = {
      fastmail          = true,
      ses               = true,
      add_root_aname    = true,
      add_www_cname     = true,
      vanity_nameserver = "doridian.net",
      extra_attributes  = { "ACCEPT-WHOISTRUSTEE-TAC" = "0" },
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
      extra_attributes  = merge(local.extra_attributes_es, { "ACCEPT-WHOISTRUSTEE-TAC" = "0" }),
    },
    "foxcav.es" = {
      fastmail          = true,
      ses               = true,
      add_root_aname    = true,
      add_www_cname     = true,
      vanity_nameserver = "doridian.net",
      extra_attributes  = merge(local.extra_attributes_es, { "ACCEPT-WHOISTRUSTEE-TAC" = "0" }),
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
}

module "domain" {
  source = "../modules/domain"

  for_each = local.domains

  domain = each.key

  fastmail          = each.value.fastmail
  ses               = each.value.ses
  root_aname        = each.value.add_root_aname ? var.main_domain : null
  add_www_cname     = each.value.add_www_cname
  vanity_nameserver = each.value.vanity_nameserver != null ? constellix_vanity_nameserver.vanity[each.value.vanity_nameserver] : null

  extra_attributes = merge({
    "WHOIS-URL" = "https://doridian.net",
    "WHOIS-RSP" = "Doridian",
    "WHOIS-BANNER0" : "Foxes are best animal",
  }, each.value.extra_attributes)

  owner_contacts   = [hexonet_contact.main.id]
  admin_contacts   = [hexonet_contact.main.id]
  tech_contacts    = [hexonet_contact.main.id]
  billing_contacts = [hexonet_contact.main.id]

  hexonet_registrar = each.key != "f0x.es" && each.key != "foxcav.es"
}

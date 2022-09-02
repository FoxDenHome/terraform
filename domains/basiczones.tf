locals {
  basiczones = merge({
    "as207618.net" = {
      fastmail             = true,
      ses                  = false,
      add_root_aname       = true,
      redirect_www_to_root = false,
      add_www_cname        = true,
      vanity_nameserver    = "doridian.net",
      transfer_lock        = true,
    },
    "pawnode.com" = {
      fastmail             = true,
      ses                  = false,
      add_root_aname       = true,
      redirect_www_to_root = false,
      add_www_cname        = true,
      vanity_nameserver    = "doridian.net",
      transfer_lock        = true,
    },

    "doridian.com" = {
      fastmail             = true,
      ses                  = false,
      add_root_aname       = true,
      redirect_www_to_root = false,
      add_www_cname        = true,
      vanity_nameserver    = "doridian.net",
      transfer_lock        = true,
    },
    "doridian.de" = {
      fastmail             = true,
      ses                  = false,
      add_root_aname       = true,
      redirect_www_to_root = false,
      add_www_cname        = true,
      vanity_nameserver    = "doridian.net",
      transfer_lock        = false,
    },
    "doridian.org" = {
      fastmail             = true,
      ses                  = false,
      add_root_aname       = true,
      redirect_www_to_root = false,
      add_www_cname        = true,
      vanity_nameserver    = "doridian.net",
      transfer_lock        = true,
    },

    "doridian.net" = {
      fastmail             = true,
      ses                  = false,
      add_root_aname       = false,
      redirect_www_to_root = true,
      add_www_cname        = true,
      vanity_nameserver    = "doridian.net",
      transfer_lock        = true,
    },

    "f0x.es" = {
      fastmail             = true,
      ses                  = true,
      add_root_aname       = false,
      redirect_www_to_root = true,
      add_www_cname        = true,
      vanity_nameserver    = "doridian.net",
      transfer_lock        = false,
    },
    "foxcav.es" = {
      fastmail             = true,
      ses                  = true,
      add_root_aname       = false,
      redirect_www_to_root = true,
      add_www_cname        = true,
      vanity_nameserver    = "doridian.net",
      transfer_lock        = false,
    },

    "foxden.network" = {
      fastmail             = true,
      ses                  = true,
      add_root_aname       = false,
      redirect_www_to_root = true,
      add_www_cname        = true,
      vanity_nameserver    = "foxden.network",
      transfer_lock        = true,
    },
  }, var.basiczones)
}

module "basiczone" {
  source = "../modules/basiczone"

  for_each = local.basiczones

  main_domain = var.main_domain
  domain      = each.key

  fastmail             = each.value.fastmail
  ses                  = each.value.ses
  add_root_aname       = each.value.add_root_aname
  redirect_www_to_root = each.value.redirect_www_to_root
  add_www_cname        = each.value.add_www_cname
  transfer_lock        = each.value.transfer_lock
  vanity_nameserver    = constellix_vanity_nameserver.vanity[each.value.vanity_nameserver]
}

module "basiczone" {
  source = "../modules/basiczone"

  for_each = var.basiczones

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

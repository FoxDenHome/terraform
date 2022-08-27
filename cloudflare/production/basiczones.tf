module "basiczone" {
  source = "../modules/basiczone"

  for_each = var.basiczones

  account_id  = var.account_id
  main_domain = var.main_domain
  domain      = each.key

  fastmail             = each.value.fastmail
  ses                  = each.value.ses
  redirect_all_to_main = each.value.redirect_all_to_main
  redirect_www_to_root = each.value.redirect_www_to_root
  add_www_cname        = each.value.add_www_cname
}

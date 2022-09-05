locals {
  domains = {
    "candy-girl.net" = {
      fastmail             = false,
      ses                  = true,
      redirect_www_to_root = false,
      add_www_cname        = false,
      transfer_lock        = true,
      contact              = hexonet_contact.personal.id,
      extra_attributes     = { "ACCEPT-WHOISTRUSTEE-TAC" = "0" },
    },
    "zoofaeth.de" = {
      fastmail             = false,
      ses                  = true,
      redirect_www_to_root = false,
      add_www_cname        = false,
      transfer_lock        = false,
      contact              = hexonet_contact.organization.id,
      extra_attributes     = {},
    },
  }
}
module "records" {
  for_each = local.domains
  source   = "./records"

  domain = module.domain[each.key].domain
}

module "domain" {
  source = "../modules/domain"

  for_each = local.domains

  domain = each.key

  root_aname           = var.server_domain
  fastmail             = each.value.fastmail
  ses                  = each.value.ses
  redirect_www_to_root = each.value.redirect_www_to_root
  add_www_cname        = each.value.add_www_cname
  transfer_lock        = each.value.transfer_lock
  extra_attributes     = each.value.extra_attributes

  owner_contacts   = [each.value.contact]
  admin_contacts   = [each.value.contact]
  tech_contacts    = [each.value.contact]
  billing_contacts = [each.value.contact]
}

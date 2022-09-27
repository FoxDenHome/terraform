locals {
  domains = {
    "candy-girl.net" = {
      fastmail         = false,
      ses              = true,
      add_www_cname    = false,
      contact          = hexonet_contact.personal.id,
    },
    "zoofaeth.de" = {
      fastmail         = false,
      ses              = true,
      add_www_cname    = false,
      contact          = hexonet_contact.organization.id,
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

  root_aname       = var.server_domain
  fastmail         = each.value.fastmail
  ses              = each.value.ses
  add_www_cname    = each.value.add_www_cname

  owner_contacts   = [each.value.contact]
  admin_contacts   = [each.value.contact]
  tech_contacts    = [each.value.contact]
  billing_contacts = [each.value.contact]

  registrar = "hexonet"
}

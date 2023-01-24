locals {
  domains = {
    "candy-girl.net" = {
      contact = hexonet_contact.personal.id,
    },
    "zoofaeth.de" = {
      contact = hexonet_contact.organization.id,
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

  root_aname    = var.server_domain
  fastmail      = false
  ses           = true
  add_www_cname = true

  owner_contacts   = [each.value.contact]
  admin_contacts   = [each.value.contact]
  tech_contacts    = [each.value.contact]
  billing_contacts = [each.value.contact]

  registrar = "hexonet"
}

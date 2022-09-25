resource "hexonet_domain" "domain" {
  count  = var.registrar == "hexonet" ? 1 : 0
  domain = var.domain

  name_servers = local.has_vanity_ns ? local.vanity_ns_list : local.constellix_ns_list

  owner_contacts   = var.owner_contacts
  admin_contacts   = var.admin_contacts
  tech_contacts    = var.tech_contacts
  billing_contacts = var.billing_contacts

  extra_attributes = var.extra_attributes
  status = [
    "ACTIVE",
    "clientDeleteProhibited",
    "clientTransferProhibited",
  ]
}

resource "inwx_domain" "domain" {
  count = var.registrar == "inwx" ? 1 : 0
  name  = var.domain

  nameservers = local.has_vanity_ns ? local.vanity_ns_list : local.constellix_ns_list

  contacts {
    registrant = one(var.owner_contacts)
    admin      = one(var.admin_contacts)
    tech       = one(var.tech_contacts)
    billing    = one(var.billing_contacts)
  }

  period       = "1Y"
  renewal_mode = "AUTORENEW"

  transfer_lock = true

  lifecycle {
    ignore_changes = [
      extra_data["IDCARD-OR-PASSPORT-NUMBER"]
    ]
  }
}

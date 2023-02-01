resource "hexonet_domain" "domain" {
  count  = var.registrar == "hexonet" ? 1 : 0
  domain = var.domain

  name_servers = local.has_vanity_ns ? local.vanity_ns_list : local.cloudns_ns_list

  owner_contacts   = var.owner_contacts
  admin_contacts   = var.admin_contacts
  tech_contacts    = var.tech_contacts
  billing_contacts = var.billing_contacts

  # Only provide DS records, otherwise Hexonet yells at us...
  dnssec_ds_records     = local.dnssec_ds_records
  dnssec_dnskey_records = local.dnssec_dnskey_records

  extra_attributes = var.extra_attributes
  status = [
    "ACTIVE",
    "clientDeleteProhibited",
    "clientTransferProhibited",
  ]

  lifecycle {
    ignore_changes = [
      extra_attributes["ES-ADMIN-IDENTIFICACION"],
      extra_attributes["ES-ADMIN-TIPO-IDENTIFICACION"],

      extra_attributes["ES-TECH-IDENTIFICACION"],
      extra_attributes["ES-TECH-TIPO-IDENTIFICACION"],

      extra_attributes["ES-BILLING-IDENTIFICACION"],
      extra_attributes["ES-BILLING-TIPO-IDENTIFICACION"],

      extra_attributes["ES-REGISTRANT-IDENTIFICACION"],
      extra_attributes["ES-REGISTRANT-TIPO-IDENTIFICACION"],
      extra_attributes["ES-REGISTRANT-FORM-JURIDICA"],
      extra_attributes["ES-REGISTRANT"],

      extra_attributes["ES-AUTORENEW"],
      extra_attributes["ES-PETICION"],

      extra_attributes["ACCEPT-WHOISTRUSTEE-TAC"],

      dnssec_ds_records, # Only provide DS records, otherwise Hexonet yells at us...
    ]
  }
}

resource "inwx_domain" "domain" {
  count = var.registrar == "inwx" ? 1 : 0
  name  = var.domain

  nameservers = local.has_vanity_ns ? local.vanity_ns_list : local.cloudns_ns_list

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
      extra_data["IDCARD-OR-PASSPORT-NUMBER"],
    ]
  }
}

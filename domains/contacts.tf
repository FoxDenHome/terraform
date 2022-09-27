resource "hexonet_contact" "main" {
  title       = var.domain_contact.title
  first_name  = var.domain_contact.first_name
  middle_name = var.domain_contact.middle_name
  last_name   = var.domain_contact.last_name

  organization = var.domain_contact.organization

  address_line_1 = var.domain_contact.address_line_1
  address_line_2 = var.domain_contact.address_line_2
  city           = var.domain_contact.city
  zip            = var.domain_contact.zip
  state          = var.domain_contact.state
  country        = var.domain_contact.country

  email = var.domain_contact.email
  phone = var.domain_contact.phone
  fax   = var.domain_contact.fax

  disclose = false
}

resource "inwx_domain_contact" "main" {
  type = "PERSON"

  name = local.domain_contact_full_name

  street_address = var.domain_contact.address_line_1
  city           = var.domain_contact.city
  postal_code    = var.domain_contact.zip
  state_province = var.domain_contact.state
  country_code   = var.domain_contact.country

  phone_number = var.domain_contact.phone

  email = var.domain_contact.email

  whois_protection = true
}

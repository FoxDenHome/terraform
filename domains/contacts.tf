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

  extra_attributes = var.domain_contact.extra_attributes
}

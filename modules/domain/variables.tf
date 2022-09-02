variable "domain" {
  type = string
}

variable "fastmail" {
  type = bool
}

variable "add_root_aname" {
  type = bool
}

variable "redirect_www_to_root" {
  type = bool
}

variable "add_www_cname" {
  type = bool
}

variable "main_domain" {
  type = string
}

variable "ses" {
  type = bool
}

variable "vanity_nameserver" {
  type = object({
    id                     = string
    name                   = string
    nameserver_list_string = string
  })
  default = null
}

variable "transfer_lock" {
  type    = bool
  default = true
}

variable "aws_registrar" {
  type    = bool
  default = true
}

variable "domain_contact" {
  type = object({
    address_line_1    = string
    address_line_2    = string
    city              = string
    contact_type      = string
    country_code      = string
    email             = string
    extra_params      = map(string)
    fax               = string
    first_name        = string
    last_name         = string
    organization_name = string
    phone_number      = string
    state             = string
    zip_code          = string
  })
  default = null
}

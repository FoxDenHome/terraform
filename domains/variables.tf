variable "domains" {
  type = map(object({
    fastmail             = bool
    ses                  = bool
    add_root_aname       = bool
    redirect_www_to_root = bool
    add_www_cname        = bool
    vanity_nameserver    = string
    transfer_lock        = bool
  }))
  default = {}
}

variable "main_domain" {
  type    = string
  default = "redfox.doridian.net"
}

variable "constellix_apikey" {
  type = string
}

variable "constellix_secretkey" {
  type = string
}

/* Unused atm
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
*/

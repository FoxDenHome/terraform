variable "server_domain" {
  type    = string
  default = "arcticfox.doridian.net"
}

variable "constellix_apikey" {
  type = string
}

variable "constellix_secretkey" {
  type = string
}

variable "inwx_username" {
  type = string
}

variable "inwx_password" {
  type = string
}

variable "domain_contact" {
  type = object({
    title       = string
    first_name  = string
    middle_name = string
    last_name   = string

    organization = string

    address_line_1 = string
    address_line_2 = string
    city           = string
    state          = string
    zip            = string
    country        = string

    email = string
    fax   = string
    phone = string

    extra_attributes = map(string)
  })
  default = null
}

variable "domains" {
  type = map(object({
    fastmail = bool
    ses      = bool

    add_root_aname = bool
    add_www_cname  = bool

    vanity_nameserver = string
  }))
  default = {}
}

variable "main_domain" {
  type    = string
  default = "redfox.doridian.net"
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
  })
  default = null
}


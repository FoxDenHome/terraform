variable "domains" {
  type = map(object({
    fastmail = bool
    ses      = bool

    add_root_aname = bool
    add_www_cname  = bool

    vanity_nameserver = string

    extra_attributes = map(string)
  }))
  default = {}
}

variable "constellix_apikey" {
  type = string
}

variable "constellix_secretkey" {
  type = string
}

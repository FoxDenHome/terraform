variable "domain" {
  type = string
}

variable "fastmail" {
  type = bool
}

variable "root_aname" {
  type    = string
  default = null
}

variable "add_www_cname" {
  type = bool
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

variable "registrar" {
  type    = string
  default = ""
}

variable "extra_attributes" {
  type    = map(string)
  default = {}
}

variable "owner_contacts" {
  type    = set(string)
  default = null
}

variable "admin_contacts" {
  type    = set(string)
  default = null
}

variable "tech_contacts" {
  type    = set(string)
  default = null
}

variable "billing_contacts" {
  type    = set(string)
  default = null
}

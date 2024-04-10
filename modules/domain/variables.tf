variable "cloudns_auth_id" {
  type = string
}

variable "cloudns_password" {
  type = string
}

variable "domain" {
  type = string
}

variable "manual_dnskey_records" {
  type    = set(string)
  default = null
}

variable "manual_ds_records" {
  type    = set(string)
  default = null
}

variable "fastmail" {
  type = bool
}

variable "root_aname" {
  type    = string
  default = null
}

variable "root_aname_ttl" {
  type    = number
  default = 300
}

variable "add_www_cname" {
  type = bool
}

variable "ses" {
  type = bool
}

variable "vanity_nameserver" {
  type = object({
    name = string
    list = list(string)
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

variable "additional_statuses" {
  type    = set(string)
  default = []
}

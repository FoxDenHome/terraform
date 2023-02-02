variable "domains" {
  type = map(object({
    vanity_nameserver = string
  }))
  default = {}
}

variable "cloudns_auth_id" {
  type = string
}

variable "cloudns_password" {
  type = string
}

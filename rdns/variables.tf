variable "domains" {
  type = map(object({
    vanity_nameserver = string
  }))
  default = {}
}

variable "inwx_username" {
  type = string
}

variable "inwx_password" {
  type = string
}

variable "cloudns_auth_id" {
  type = string
}

variable "cloudns_password" {
  type = string
}

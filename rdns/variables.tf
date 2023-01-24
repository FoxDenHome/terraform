variable "domains" {
  type = map(object({
    vanity_nameserver = string
  }))
  default = {}
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
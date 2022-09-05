variable "domain" {
  type = object({
    id   = string
    name = string
  })
}

variable "subdomain" {
  type = string
}

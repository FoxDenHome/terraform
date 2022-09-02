variable "domain" {
  type = object({
    id   = string
    name = string
  })
}

variable "server" {
  type    = string
  default = "arcticfox.doridian.net"
}

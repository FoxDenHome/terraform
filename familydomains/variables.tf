variable "basiczones" {
  type = map(object({
    fastmail             = bool
    ses                  = bool
    add_root_aname       = bool
    redirect_www_to_root = bool
    add_www_cname        = bool
    transfer_lock        = bool
  }))
}

variable "server_domain" {
  type    = string
  default = "arcticfox.doridian.net"
}

variable "apikey" {
  type = string
}

variable "secretkey" {
  type = string
}

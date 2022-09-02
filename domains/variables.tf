variable "basiczones" {
  type = map(object({
    fastmail             = bool
    ses                  = bool
    add_root_aname       = bool
    redirect_www_to_root = bool
    add_www_cname        = bool
    vanity_nameserver    = string
    transfer_lock        = bool
  }))
}

variable "main_domain" {
  type    = string
  default = "doridian.net"
}

variable "main_domain_target" {
  type = string
}

variable "apikey" {
  type = string
}

variable "secretkey" {
  type = string
}

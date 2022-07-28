variable "basiczones" {
  type = map(object({
    fastmail             = bool
    ses                  = bool
    redirect_all_to_main = bool
    redirect_www_to_root = bool
    add_www_cname        = bool
  }))
}

variable "account_id" {
  type    = string
  default = "2e8e7eac664f550b078878710b3283d5"
}

variable "main_domain" {
  type    = string
  default = "doridian.net"
}

variable "main_domain_target" {
  type = string
}

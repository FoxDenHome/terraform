variable "domain" {
  type = string
}

variable "fastmail" {
  type = bool
}

variable "add_root_aname" {
  type = bool
}

variable "redirect_www_to_root" {
  type = bool
}

variable "add_www_cname" {
  type = bool
}

variable "main_domain" {
  type = string
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

variable "transfer_lock" {
  type    = bool
  default = true
}

variable "aws_registrar" {
  type    = bool
  default = true
}

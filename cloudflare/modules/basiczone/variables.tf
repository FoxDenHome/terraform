variable "account_id" {
  type = string
}

variable "domain" {
  type = string
}

variable "fastmail" {
  type = bool
}

variable "redirect_all_to_main" {
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

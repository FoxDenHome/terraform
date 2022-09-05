variable "domain" {
  type = object({
    id   = string
    name = string
  })
}

variable "subdomain" {
  type = string
}

variable "mail_from_subdomain" {
  type    = string
  default = "ses-bounce"
}

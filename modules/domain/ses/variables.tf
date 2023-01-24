variable "zone" {
  type = object({
    id   = string
    zone = string
  })
}

variable "subdomain" {
  type = string
}

variable "mail_from_subdomain" {
  type    = string
  default = "ses-bounce"
}

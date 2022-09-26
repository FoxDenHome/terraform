variable "repository" {
  type = object({
    name         = string
    description  = string
    homepage_url = string

    visibility = string

    branch_protection = bool
    required_checks   = set(string)

    pages = object({
      cname = string
    })
  })
}

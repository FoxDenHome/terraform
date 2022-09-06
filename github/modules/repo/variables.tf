variable "repository" {
  type = object({
    name        = string
    description = string

    visibility = string

    branch_protection = bool
    required_checks   = set(string)
  })
}

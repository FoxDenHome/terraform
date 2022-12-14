locals {
  repositores = {
    nodered = {
      branch_protection = false
    }
    homeassistant = {
      branch_protection = false
    }
    NixieClockDori = {}
    LCDify         = {}
    terraform      = {}
    e621dumper     = {}
    redfox         = {}
    docker         = {}
    router = {
      branch_protection = false
    }
    CC1101Duino        = {}
    ntp                = {}
    islandfox          = {}
    nas                = {}
    backup             = {}
    scripts            = {}
    sshkeys            = {}
    sni-vhost-proxy    = {}
    foxdns             = {}
  }

  members = {
    Doridian    = "admin",
    SimonSchick = "admin",
  }
}

module "repo" {
  for_each = local.repositores

  source = "../modules/repo"
  repository = merge({
    name         = each.key
    description  = ""
    homepage_url = ""

    visibility = "public"

    required_checks   = []
    branch_protection = true

    pages = null
  }, each.value)
}

resource "github_membership" "members" {
  for_each = local.members

  username = each.key
  role     = each.value
}

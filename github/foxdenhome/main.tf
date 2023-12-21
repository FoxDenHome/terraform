locals {
  repositores = {
    nodered = {
      branch_protection = false
    }
    homeassistant = {
      branch_protection = false
    }
    NixieClockDori      = {}
    PaperESP32          = {}
    LCDify              = {}
    terraform           = {}
    e621dumper          = {}
    tapemgr             = {}
    docker              = {}
    docker-sriov-plugin = {}
    router = {
      branch_protection = false
    }
    CC1101Duino     = {}
    ntpi            = {}
    islandfox       = {}
    bengalfox       = {}
    backup          = {}
    scripts         = {}
    sshkeys         = {}
    sni-vhost-proxy = {}
    redfox          = {}
    shutdownd       = {}
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

locals {
  repositores = {
    accounts-client        = {}
    config-dependency      = {}
    fox-bukkit-chat        = {}
    fox-bukkit-lua         = {}
    fox-bukkit-lua-modules = {}
    fox-bukkit-permissions = {}
    packages               = {}
    plexus-compiler-luaj   = {}
  }

  members = {
    Doridian   = "admin",
    Crashdoom  = "admin",
    TomyLobo   = "admin",
    Alconchloe = "member",
    mjohnson9  = "member",
  }
}

resource "github_membership" "members" {
  for_each = local.members

  username = each.key
  role     = each.value
}

resource "github_team" "engineers" {
  name    = "Engineers"
  privacy = "closed"
}

resource "github_team_membership" "engineers" {
  for_each = local.members
  team_id  = github_team.engineers.id

  username = each.key
  role     = (each.value == "admin") ? "maintainer" : "member"
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

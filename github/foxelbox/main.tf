locals {
  repositores = {}

  members = {
    Doridian   = "admin",
    Crashdoom  = "admin",
    TomyLobo   = "admin",
    Alconchloe = "member",
    mjohnson9  = "member",
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
  }, each.value)
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

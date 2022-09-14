locals {
  repositores = {
    docker = {}
    StarLord = {
      description = "GMod server manager with updates from git"
    }
    webstatic     = {}
    TTS           = {}
    space_age_api = {}
    spacebuild    = {}
    SpaceAge = {
      visibility        = "private"
      branch_protection = false
    }
    ansible = {
      visibility        = "private"
      branch_protection = false
    }
    SpaceAgeModelPack = {}
    Joystick = {
      description = "A joystick module for GMod, originally by NightEagle."
    }
    Falcos-Prop-protection = {
      description = "Falco's prop protection"
    }
    maps         = {}
    multi-parent = {}
    luacheck = {
      description = "A tool for linting and static analysis of Lua code."
    }
    physgun-build-mode = {}
    sbep = {
      description = "Spacebuild Enhancement Pack."
    }
    spacebuild_colliders = {}
    gmsv_random          = {}
    smartsnap            = {}
    issues               = {}
  }

  members = {
    Doridian    = "admin",
    SimonSchick = "admin",
    TomyLobo    = "member",
    mjohnson9   = "member",
  }
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
  }, each.value)
}

resource "github_membership" "members" {
  for_each = local.members

  username = each.key
  role     = each.value
}

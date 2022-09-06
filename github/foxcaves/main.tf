locals {
  repositores = {
    site = {
      homepage_url = "https://foxcav.es"
    }
    base-image = {

    }
    sharex = {
      description = "ShareX config files"
    }
    raven-lua = {
      description = "A Lua interface to Sentry"
    }
    lua-resty-cookie = {
      description = "Lua library for HTTP cookie manipulations for OpenResty/ngx_lua"
    }
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
  }, each.value)
}

resource "github_membership" "members" {
  for_each = local.members

  username = each.key
  role     = each.value
}

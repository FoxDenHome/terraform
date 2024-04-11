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

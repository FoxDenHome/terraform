locals {
  archived_repositores = {
    lua-resty-auto-ssl    = {},
    base-image            = {},
    FoxScreen             = {},
    LEGACY_foxCavesChrome = {},
    LEGACY_foxScreen      = {},
  }
}

# tfi() { tofu import "module.archived_repo[\"$1\"].github_repository.repo" "$1"; }

module "archived_repo" {
  source = "../modules/repo/archived"

  for_each = local.archived_repositores

  repository = merge({
    name = each.key

    visibility = "public"
  }, each.value)
}

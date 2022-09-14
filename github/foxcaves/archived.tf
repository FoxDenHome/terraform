locals {
  archived_repositores = {
    FoxScreen             = {},
    LEGACY_foxCavesChrome = {},
    LEGACY_foxScreen      = {},
  }
}

# tfi() { terraform import "module.archived_repo[\"$1\"].github_repository.repo" "$1"; }

module "archived_repo" {
  source = "../modules/repo/archived"

  for_each = local.archived_repositores

  repository = merge({
    name = each.key
  }, each.value)
}

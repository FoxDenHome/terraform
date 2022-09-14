locals {
  archived_repositores = {
    opendkame = {},
  }
}

module "archived_repo" {
    source = "../modules/repo/archived"

    for_each = local.archived_repositores

    name = each.key
}

locals {
  archived_repositores = {
    HAMqttDevice        = {},
    docker-sriov-plugin = {},
    tapemgr             = {},
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

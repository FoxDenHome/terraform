resource "github_repository" "repo" {
  name         = var.repository.name
  description  = var.repository.description
  homepage_url = var.repository.homepage_url

  visibility = var.repository.visibility

  allow_auto_merge   = true
  allow_merge_commit = false
  allow_rebase_merge = false
  allow_squash_merge = true

  has_wiki             = true
  has_issues           = true
  vulnerability_alerts = true

  squash_merge_commit_title   = "PR_TITLE"
  squash_merge_commit_message = "BLANK"
  delete_branch_on_merge      = true

  dynamic "pages" {
    for_each = var.repository.pages != null ? [var.repository.pages] : []

    content {
      cname = pages.value.cname
      source {
        branch = "main"
        path   = "/"
      }
    }
  }

  archive_on_destroy = true
}

resource "github_branch_default" "main" {
  repository = github_repository.repo.name
  branch     = "main"
}

resource "github_branch_protection" "main" {
  count         = var.repository.branch_protection ? 1 : 0
  repository_id = github_repository.repo.node_id

  pattern = "main"

  enforce_admins      = true
  allows_deletions    = false
  allows_force_pushes = false

  required_status_checks {
    strict   = true
    contexts = var.repository.required_checks
  }
}

resource "github_repository" "repo" {
  name = var.repository.name

  archive_on_destroy = true
  archived           = true

  lifecycle {
    ignore_changes = [
      allow_merge_commit,
      allow_rebase_merge,
      allow_squash_merge,
      description,
      has_issues,
      has_wiki,
      merge_commit_message,
      merge_commit_title,
      squash_merge_commit_message,
      squash_merge_commit_title,
    ]
  }
}

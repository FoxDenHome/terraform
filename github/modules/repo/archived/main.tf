resource "github_repository" "repo" {
  name = var.repository.name

  archive_on_destroy = true
  archived           = true
}

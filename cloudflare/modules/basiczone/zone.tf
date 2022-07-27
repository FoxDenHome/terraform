resource "cloudflare_zone" "zone" {
  account_id = var.account_id
  zone       = var.domain
  jump_start = false
  plan       = "free"
}

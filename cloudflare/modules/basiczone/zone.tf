resource "cloudflare_zone" "zone" {
  account_id = var.account_id
  zone       = var.domain
  jump_start = false
  plan       = "free"
}

module "aws_sub" {
  count = var.ses ? 1 : 0
  source = "./aws"
  zone = cloudflare_zone.zone
}

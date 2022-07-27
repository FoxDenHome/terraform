module "basiczone" {
  source = "../modules/basiczone"

  for_each = var.basiczones

  domain = each.key
  zone_id = each.value
}

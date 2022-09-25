locals {
  fox_ax_domain = module.domain["fox.ax"].domain.id
}

resource "constellix_cname_record" "fox_ax_cnames" {
  for_each  = toset(["caves", "foxcaves"])
  domain_id = local.fox_ax_domain

  type        = "CNAME"
  name        = each.key
  ttl         = 3600
  source_type = "domains"

  host = "redfox.doridian.net."
}

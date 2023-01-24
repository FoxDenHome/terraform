output "zone" {
  value = cloudflare_zone.zone
}

output "dnssec" {
  value = {
    ds     = [local.dnssec_ds_record]
    dnskey = [local.dnssec_dnskey_record]
  }
}

output "domain" {
  value = constellix_domain.domain
}

output "dnssec" {
  value = {
    ds     = [local.dnssec_ds_record]
    dnskey = [local.dnssec_dnskey_record]
  }
}

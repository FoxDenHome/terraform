output "dnssec" {
  value = [for d in module.domain : {
    domain = d.zone.zone
    ds     = d.dnssec.ds
    dnskey = d.dnssec.dnskey
  }]
}

data "http" "dnssec_records" {
  count = var.disable_dnssec ? 0 : 1

  url = "https://api.cloudns.net/dns/get-dnssec-ds-records.json"
  request_headers = {
    Accept       = "application/json"
    Content-Type = "application/x-www-form-urlencoded"
  }
  method       = "POST"
  request_body = "auth-id=${var.cloudns_auth_id}&auth-password=${var.cloudns_password}&domain-name=${var.domain}"
}

locals {
  dnssec_records_json = var.disable_dnssec ? null : jsondecode(data.http.dnssec_records[0].response_body)

  dnssec_ds_records     = var.disable_dnssec ? [] : [for dsrec in local.dnssec_records_json["ds"] : trimprefix(dsrec, "${var.domain}. 3600 IN DS ")]
  dnssec_dnskey_records = var.disable_dnssec ? [] : [for dsrec in local.dnssec_records_json["dnskey"] : trimprefix(dsrec, "${var.domain}. 3600 IN DNSKEY ")]
}

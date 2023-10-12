data "http" "dnssec_records" {
  count = (var.manual_dnskey_records != null) ? 0 : 1

  url = "https://api.cloudns.net/dns/get-dnssec-ds-records.json"
  request_headers = {
    Accept       = "application/json"
    Content-Type = "application/x-www-form-urlencoded"
  }
  method       = "POST"
  request_body = "auth-id=${var.cloudns_auth_id}&auth-password=${var.cloudns_password}&domain-name=${var.domain}"
}

locals {
  manual_dnssec       = (var.manual_dnskey_records != null) || (var.manual_ds_records != null)
  dnssec_records_json = local.manual_dnssec ? null : jsondecode(data.http.dnssec_records[0].response_body)

  dnssec_type = endswith(var.domain, ".de") ? "dnskey" : "ds"

  # Only provide registry native records, otherwise Hexonet yells at us...
  switched_dnssec_ds_records     = local.manual_dnssec ? var.manual_ds_records : toset([for dsrec in local.dnssec_records_json["ds"] : trimprefix(dsrec, "${var.domain}. 3600 IN DS ")])
  switched_dnssec_dnskey_records = local.manual_dnssec ? var.manual_dnskey_records : toset([for dsrec in local.dnssec_records_json["dnskey"] : trimprefix(dsrec, "${var.domain}. 3600 IN DNSKEY ")])

  dnssec_ds_records     = local.dnssec_type == "ds" ? local.switched_dnssec_ds_records : null
  dnssec_dnskey_records = local.dnssec_type == "dnskey" ? local.switched_dnssec_dnskey_records : null
}

data "http" "dnssec_records" {
  url = "https://api.cloudns.net/dns/get-dnssec-ds-records.json"
  request_headers = {
    Accept       = "application/json"
    Content-Type = "application/x-www-form-urlencoded"
  }
  method       = "POST"
  request_body = "auth-id=${var.cloudns_auth_id}&auth-password=${var.cloudns_password}&domain-name=${var.domain}"
}

locals {
  dnssec_records_json = jsondecode(data.http.dnssec_records.response_body)

  dnssec_ds_records     = [for dsrec in local.dnssec_records_json["ds"] : trimprefix(dsrec, "${var.domain}. 3600 IN DS ")]
  dnssec_dnskey_records = [for dsrec in local.dnssec_records_json["dnskey"] : trimprefix(dsrec, "${var.domain}. 3600 IN DNSKEY ")]
}

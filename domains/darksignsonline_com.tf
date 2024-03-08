resource "cloudns_dns_record" "darksignsonline_com_www" {
  zone = "darksignsonline.com"

  type  = "CNAME"
  name  = "www"
  ttl   = 3600
  value = "doridian.github.io"
}

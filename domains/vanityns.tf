locals {
  vanity_nameservers = {
    "doridian.net" = {
      list = ["ns1.doridian.net", "ns2.doridian.net", "ns3.doridian.net", "ns4.doridian.net"]
      name = "doridian.net"
    }
    "foxden.network" = {
      list = ["ns1.foxden.network", "ns2.foxden.network", "ns3.foxden.network", "ns4.foxden.network"]
      name = "foxden.network"
    }
    "cloudflare-f0x-es" = {
      list = ["anna.ns.cloudflare.com", "eric.ns.cloudflare.com"],
      name = "cloudflare.com"
    }
  }
}

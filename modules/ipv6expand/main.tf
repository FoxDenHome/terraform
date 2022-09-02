// 2600:180c:6001::1 -> 2600:180c:6001:0:0:0:0:1
locals {
  ipv6_has_segments = length(split(":", replace(var.ipv6, "::", ":")))
  ipv6_max_segments = 8
  ipv6_filler = [for _ in range(local.ipv6_max_segments - local.ipv6_has_segments) : "0"]
  ipv6_filler_str = join(":", local.ipv6_filler)
  ipv6_out = replace(var.ipv6, "::", ":${local.ipv6_filler_str}:")
}

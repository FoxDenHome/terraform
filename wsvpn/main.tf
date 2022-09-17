locals {
  npcap_key = "npcap-1.71.exe"
}

resource "aws_s3_bucket" "wsvpn" {
  bucket = "wsvpn"
}

resource "null_resource" "npcap_url" {
  triggers = {
    build_number = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "printf '%s' \"$(aws s3 presign --expires-in=604800 \"s3://${aws_s3_bucket.wsvpn.bucket}/${local.npcap_key}\")\" > \"${path.root}/npcap_url\""
  }
}

data "local_file" "npcap_url" {
  depends_on = [
    null_resource.npcap_url
  ]

  filename = "${path.root}/npcap_url"
}

resource "null_resource" "npcap_url_deletion" {
  depends_on = [
    data.local_file.npcap_url
  ]

  triggers = {
    build_number = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "rm -f \"${path.root}/npcap_url\""
  }
}

resource "github_actions_secret" "npcap_url" {
  repository      = "wsvpn"
  secret_name     = "NPCAP_URL"
  plaintext_value = data.local_file.npcap_url.content
}

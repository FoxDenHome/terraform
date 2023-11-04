locals {
  xmppshare_s3_origin_id  = "xmppshare_origin_id"
  xmppshare_cdn_domain = "xmppshare.f0x.es"
}

resource "aws_cloudfront_origin_access_identity" "xmppshare_oai" {

}

resource "aws_s3_bucket" "xmppshare_bucket" {
  bucket = "f0x-es-xmppshare"
}

resource "aws_s3_bucket_acl" "xmppshare_bucket_acl" {
  bucket = aws_s3_bucket.xmppshare_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_ownership_controls" "xmppshare_bucket_ownwership_controls" {
  bucket = aws_s3_bucket.xmppshare_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

data "aws_iam_policy_document" "xmppshare_bucket_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.xmppshare_bucket.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.xmppshare_oai.iam_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "xmppshare_bucket_policy" {
  bucket = aws_s3_bucket.xmppshare_bucket.id
  policy = data.aws_iam_policy_document.xmppshare_bucket_policy.json
}

resource "aws_s3_bucket_lifecycle_configuration" "xmppshare_bucket_lifecycle" {
  bucket = aws_s3_bucket.xmppshare_bucket.id

  rule {
    id     = "expire-all"
    status = "Enabled"

    abort_incomplete_multipart_upload {
      days_after_initiation = 2
    }

    expiration {
      days                         = 365
      expired_object_delete_marker = false
    }

    noncurrent_version_expiration {
      noncurrent_days = 365
    }
  }
}

resource "aws_acm_certificate" "xmppshare_certificate" {
  domain_name       = local.xmppshare_cdn_domain
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}

resource "cloudns_dns_record" "xmppshare_validation_record" {
  for_each = {
    for dvo in aws_acm_certificate.xmppshare_certificate.domain_validation_options : "${dvo.resource_record_name}@${dvo.resource_record_type}" => {
      name  = dvo.resource_record_name
      value = dvo.resource_record_value
      type  = dvo.resource_record_type
    }
  }

  zone = "f0x.es"

  type  = each.value.type
  name  = trimsuffix(each.value.name, ".f0x.es.")
  ttl   = 3600
  value = trimsuffix(each.value.value, ".")
}

resource "aws_cloudfront_distribution" "xmppshare_distribution" {
  origin {
    domain_name = aws_s3_bucket.xmppshare_bucket.bucket_regional_domain_name
    origin_id   = local.xmppshare_s3_origin_id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.xmppshare_oai.cloudfront_access_identity_path
    }
  }

  enabled         = true
  is_ipv6_enabled = true
  aliases         = [local.xmppshare_cdn_domain]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.xmppshare_s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    ssl_support_method  = "sni-only"
    acm_certificate_arn = aws_acm_certificate.xmppshare_certificate.arn
  }
}

resource "cloudns_dns_record" "xmppshare_cdn" {
  zone = "f0x.es"

  type  = "CNAME"
  name  = "xmppshare"
  ttl   = 3600
  value = aws_cloudfront_distribution.xmppshare_distribution.domain_name
}

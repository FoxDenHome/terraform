locals {
  tts_s3_origin_id = "tts_s3_origin_id"
  tts_cdn_domain   = "tts-cdn.spaceage.mp"
}

resource "aws_cloudfront_origin_access_identity" "tts_oai" {

}

resource "aws_s3_bucket" "tts_bucket" {
  bucket = "spaceage-tts"
}

resource "aws_s3_bucket_acl" "tts_bucket_acl" {
  bucket = aws_s3_bucket.tts_bucket.id
  acl    = "private"
}

data "aws_iam_policy_document" "tts_bucket_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.tts_bucket.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.tts_oai.iam_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "tts_bucket_policy" {
  bucket = aws_s3_bucket.tts_bucket.id
  policy = data.aws_iam_policy_document.tts_bucket_policy.json
}

resource "aws_s3_bucket_lifecycle_configuration" "tts_bucket_lifecycle" {
  bucket = aws_s3_bucket.tts_bucket.id

  rule {
    id     = "expire-all"
    status = "Enabled"

    abort_incomplete_multipart_upload {
      days_after_initiation = 2
    }

    expiration {
      days                         = 7
      expired_object_delete_marker = false
    }

    noncurrent_version_expiration {
      noncurrent_days = 7
    }
  }
}

resource "aws_acm_certificate" "tts_certificate" {
  domain_name       = local.tts_cdn_domain
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}

resource "cloudns_dns_record" "tts_validation_record" {
  for_each = {
    for dvo in aws_acm_certificate.tts_certificate.domain_validation_options : "${dvo.resource_record_name}@${dvo.resource_record_type}" => {
      name  = dvo.resource_record_name
      value = dvo.resource_record_value
      type  = dvo.resource_record_type
    }
  }

  zone = local.main_domain

  type  = each.value.type
  name  = trimsuffix(each.value.name, ".${local.main_domain}.")
  ttl   = 3600
  value = trimsuffix(each.value.value, ".")
}

resource "aws_cloudfront_distribution" "tts_distribution" {
  origin {
    domain_name = aws_s3_bucket.tts_bucket.bucket_regional_domain_name
    origin_id   = local.tts_s3_origin_id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.tts_oai.cloudfront_access_identity_path
    }
  }

  enabled         = true
  is_ipv6_enabled = true
  aliases         = [local.tts_cdn_domain]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.tts_s3_origin_id

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
    acm_certificate_arn = aws_acm_certificate.tts_certificate.arn
  }
}

resource "cloudns_dns_record" "tts_cdn" {
  zone = local.main_domain

  type  = "CNAME"
  name  = "tts-cdn"
  ttl   = 3600
  value = aws_cloudfront_distribution.tts_distribution.domain_name
}

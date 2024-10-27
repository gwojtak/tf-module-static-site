resource "cloudflare_zone" "this" {
  for_each = var.cdn_provider == "CLOUDFLARE" ? toset(["cf"]) : toset([])

  zone = var.domain
}

resource "cloudflare_dns_record" "main" {
  for_each = var.cdn_provider == "CLOUDFLARE" ? toset(["cf"]) : toset([])

  zone_id = cloudflare_zone.this.id
  name    = var.domain
  type    = "CNAME"
  value   = aws_s3_bucket_website_configuration.main.website_endpoint
  ttl     = 120
  tags    = concat(var.dns_record_tags, ["terraform-managed"])
}

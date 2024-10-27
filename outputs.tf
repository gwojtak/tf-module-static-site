output "s3_bucket_id" {
  description = "The ID of the created main website S3 bucket."
  value       = aws_s3_bucket.main.id
}

output "alternate_bucket_ids" {
  description = "The IDs of the created redirect S3 buckets."
  value       = [for bucket in aws_s3_bucket.redirect : bucket.id]
}

output "website_endpoint" {
  description = "The DNS name of the location of the website hosted in S3."
  value       = aws_s3_bucket_website_configuration.main.website_domain
}

output "redirect_website_endpoints" {
  description = "The DNS names of the locations of the redirect buckets."
  value       = [for website in aws_s3_bucket.redirect : website.website_domain]
}

output "cdn_provider" {
  description = "The configured name of the CDN provider."
  value       = var.cdn_provider
}

output "cloudflare_zone_id" {
  description = "The created zone ID in CloudFlare, if that was specified."
  value       = cloudflare_zone.this.id
}

output "cloudflare_name_servers" {
  description = "The name servers that CloudFlare assigned to the created zone."
  value       = cloudflare_zone.this.cloudflare_name_servers
}

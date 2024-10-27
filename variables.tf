variable "cdn_provider" {
  description = "Name of the CDN to use, if any.  Valid values are `CLOUDFLARE` or `NONE`."
  type        = string
  default     = "NONE"
  validation {
    condition     = contains(["CLOUDFLARE", "NONE"], var.cdn_provider)
    error_message = "Valid values for cdn_provider are \"CLOUDFLARE\", and \"NONE\"."
  }
}

variable "dns_record_tags" {
  description = "If CDN is `CLOUDFLARE`, this is a list of strings to tag created DNS records with."
  type        = list(string)
  default     = []
}

variable "domain" {
  description = "The name of the domain the website is to be located at."
  type        = string
}

variable "error_document" {
  description = "Set this to an S3 key that should be used for 4xx status code errors."
  type        = string
  default     = ""
}

variable "index_document" {
  description = "Sets the index document for the site.  Should be a full path within the S3 bucket."
  type        = string
  default     = "index.html"
}

variable "redirect_to_https" {
  description = "Controls whether any redirect buckets should use https or http."
  type        = bool
  default     = true
}

variable "subdomain_redirects" {
  description = "A list of subdomains to set up as redirects to the main domain (e.g., `www`)."
  type        = list(string)
  default     = []
}

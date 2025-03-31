variable "clevercloud_token" {
  description = "Clever Cloud API token"
  type        = string
  sensitive   = true
}

variable "clevercloud_secret" {
  description = "Clever Cloud API secret"
  type        = string
  sensitive   = true
}

variable "clevercloud_organisation" {
  description = "Clever Cloud organisation ID"
  type        = string
}

variable "docker_repository_url" {
  description = "Docker Git repository URL"
  type        = string
  default     = "https://github.com/eclipse-xpanse/xpanse-relops.git"
}

variable "docker_commit" {
  description = "Docker commit/branch"
  type        = string
  default     = "refs/heads/main"
}

variable "is_final_environment" {
  type    = bool
  default = false
}

variable "custom_domain_name" {
  type    = string
  default = ""
}
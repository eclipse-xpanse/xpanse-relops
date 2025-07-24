variable "enterprise_project_name" {
  type        = string
  default     = "default"
  description = "Enterprise project on which the DB must be created and billed"
}

variable "vpc_name" {
  type        = string
  description = "VPC on which the Redis instance must be hosted"
}

variable "subnet_name" {
  type        = string
  description = "subnet on which the Redis instance must be hosted"
}

variable "redis_engine_version" {
  type        = string
  default     = "5.0"
  description = "The version of redis engine"
  validation {
    condition     = contains(["4.0", "5.0", "6.0"], var.redis_engine_version)
    error_message = "Allowed values for redis_engine_version are '4.0','5.0','6.0'."
  }
}

variable "redis_cache_mode" {
  type        = string
  default     = "single"
  description = "The mode of redis cache"
  validation {
    condition     = contains(["single", "ha"], var.redis_cache_mode)
    error_message = "Allowed values for redis_cache_mode are 'single','ha'."
  }
}

variable "redis_memory_capacity" {
  type        = number
  default     = 1
  description = "The total memory of redis cache, in GB. For single and ha mode instance."
  validation {
    condition     = contains([0.125, 0.25, 0.5, 1, 2, 4, 8, 16, 32, 64], var.redis_memory_capacity)
    error_message = "Allowed values for redis_memory_capacity are 0.125, 0.25, 0.5, 1, 2, 4, 8, 16, 32 and 64."
  }
}

variable "redis_instance_name" {
  type        = string
  default     = "xpanse-redis-instance"
  description = "The name of the redis instance"
}

variable "port" {
  type        = number
  default     = 6379
  description = "The port of the redis service"
}


variable "redis_password" {
  type        = string
  description = "The password for the redis instance."

  validation {
    condition = length(var.redis_password) >=8 && length(var.redis_password) <= 32
    error_message = "Password must be between 8 and 32 characters long."
  }

  validation {
    condition = can(regex("[A-Z]", var.redis_password))
    error_message = "Password must contain at least one uppercase letter."
  }

  validation {
    condition = can(regex("[a-z]", var.redis_password))
    error_message = "Password must contain at least one lowercase letter."
  }

  validation {
    condition = can(regex("[^a-zA-Z0-9]", var.redis_password))
    error_message = "Password must contain at least one special character that isn't a letter or a digit."
  }

  validation {
    condition = can(regex("[0-9]", var.redis_password))
    error_message = "Password must contain at least one digit."
  }
}

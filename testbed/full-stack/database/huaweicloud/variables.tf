variable "db_name" {
  type        = string
  description = "name of the db"
}
variable "vpc_name" {
  type        = string
  description = "VPC on which the DB instance must be hosted"
}

variable "subnet_name" {
  type        = string
  description = "subnet on which the DB instance must be hosted"
}

variable "secgroup_name" {
  type        = string
  description = "security group on which the DB instance must be hosted"
}

variable "availability_zone" {
  type        = list(string)
  description = "availability zones on which the DB instance must be hosted"
}

variable "port" {
  type        = number
  description = "The port of the DB service."
  default     = 3306
}

variable "flavor" {
  type        = string
  description = "flavors of DB. List available here  https://support.huaweicloud.com/intl/en-us/productdesc-rds/rds_01_0034.html"
  default     = "rds.mysql.n1.large.2"
}

variable "db_type" {
  type        = string
  default     = "MySQL"
  description = "Database type. Currently xpanse supports only MySQL"
  validation {
    condition     = contains(["MySQL", "PostgreSQL", "SQLServer", "MariaDB"], var.db_type)
    error_message = "Allowed values for input_parameter are \"MySQL\", \"PostgreSQL\", \"MariaDB\" or \"SQLServer\"."
  }
}

variable "db_version" {
  type        = string
  description = "check the available versions in huaweicloud website"
}

variable "root_password" {
  type        = string
  description = "check the available versions in huaweicloud website"
}

variable "application_db_user" {
  type        = string
  description = "check the available versions in huaweicloud website"
}

variable "application_db_password" {
  type        = string
  description = "check the available versions in huaweicloud website"
}

variable "enterprise_project_name" {
  type        = string
  default     = "default"
  description = "Enterprise project on which the DB must be created and billed"
}

variable "disk_type" {
  type        = string
  description = "type of the disk to host the database"
  validation {
    condition     = contains(["ULTRAHIGH", "LOCALSSD", "CLOUDSSD", "ESSD"], var.disk_type)
    error_message = "Allowed values for input_parameter are \"ULTRAHIGH\", \"LOCALSSD\", \"CLOUDSSD\" or \"ESSD\"."
  }
}

variable "disk_size" {
  type        = number
  description = "Database disk size in GB"
}

variable "ssl_enabled" {
  type        = bool
  description = "describes if the DB instance must be SSL enabled."
  default     = false
}

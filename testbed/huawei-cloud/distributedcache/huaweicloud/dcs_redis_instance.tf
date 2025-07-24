data "huaweicloud_vpcs" "existing" {
  name = var.vpc_name
}

data "huaweicloud_vpc_subnets" "existing" {
  name = var.subnet_name
}

data "huaweicloud_enterprise_projects" "projects" {
  name = var.enterprise_project_name
}

data "huaweicloud_dcs_flavors" "flavors" {
  cache_mode = var.redis_cache_mode
  capacity   = var.redis_memory_capacity
}

data "huaweicloud_availability_zones" "available" {
}

locals {
  project_id   = var.enterprise_project_name != null ? data.huaweicloud_enterprise_projects.projects.enterprise_projects[0].id : "0"
  primary_az   = data.huaweicloud_availability_zones.available.names[0]
  secondary_az = data.huaweicloud_availability_zones.available.names[1]
  azs          = var.redis_cache_mode == "single" ? [local.primary_az] : [local.primary_az, local.secondary_az]
}

resource "huaweicloud_dcs_instance" "redis_instance" {
  name               = var.redis_instance_name
  engine             = "Redis"
  engine_version     = var.redis_engine_version
  capacity           = data.huaweicloud_dcs_flavors.flavors.capacity
  flavor             = data.huaweicloud_dcs_flavors.flavors.flavors[0].name
  availability_zones = local.azs
  password           = var.redis_password
  vpc_id             = data.huaweicloud_vpcs.existing.vpcs[0].id
  subnet_id          = data.huaweicloud_vpc_subnets.existing.subnets[0].id
  enterprise_project_id = local.project_id
}

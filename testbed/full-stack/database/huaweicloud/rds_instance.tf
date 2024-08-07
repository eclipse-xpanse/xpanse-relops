data "huaweicloud_vpcs" "existing" {
  name = var.vpc_name
}

data "huaweicloud_vpc_subnets" "existing" {
  name = var.subnet_name
}

data "huaweicloud_networking_secgroups" "existing" {
  name = var.secgroup_name
}

data "huaweicloud_enterprise_projects" "project" {
  name  = var.enterprise_project_name
}

locals {
  project_id = var.enterprise_project_name != null ? data.huaweicloud_enterprise_projects.project.enterprise_projects[0].id : "0"
}

resource "huaweicloud_rds_instance" "instance" {
  name                  = var.db_name
  flavor                = var.flavor
  vpc_id                = data.huaweicloud_vpcs.existing.vpcs[0].id
  subnet_id             = data.huaweicloud_vpc_subnets.existing.subnets[0].id
  security_group_id     = data.huaweicloud_networking_secgroups.existing.security_groups[0].id
  availability_zone     = var.availability_zone
  enterprise_project_id = local.project_id

  db {
    type     = var.db_type
    version  = var.db_version
    password = var.root_password
    port     = var.port
  }

  volume {
    type = var.disk_type
    size = var.disk_size
  }
}
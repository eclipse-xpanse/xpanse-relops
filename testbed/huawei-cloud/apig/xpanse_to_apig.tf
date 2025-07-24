variable "HW_PROJECT_ID" {}

variable "HW_ENTERPRISE_PROJECT_ID" {}

variable "HW_ACCESS_KEY" {}

variable "HW_SECRET_KEY" {}

variable "HW_REGION" {}

variable "XPANSE_DOMAIN" {}

variable "availability_zone" {
  type        = string
  default     = ""
  description = "The availability zone of the apig instance."
}

variable "vpc_name" {
  type        = string
  default     = "xpanse_apig_vpc"
  description = "The vpc name of the apig instance."
}

variable "subnet_name" {
  type        = string
  default     = "xpanse_apig_subnet"
  description = "The subnet name of the apig instance."
}

variable "secgroup_name" {
  type        = string
  default     = "xpanse_apig_secgroup"
  description = "The security group name of the apig instance."
}

variable "apig_instance_name" {
  type        = string
  default     = "Xpanse"
  description = "The security group name of the apig instance."
}

variable "apig_group_name" {
  type        = string
  default     = "XpanseAPI"
  description = "The security group name of the apig instance."
}

variable "apig_environment_name" {
  type        = string
  default     = "Test"
  description = "The environment of the apig instance."
}

terraform {
  required_providers {
    huaweicloud = {
      source  = "huaweicloud/huaweicloud"
      version = "~> 1.61.0"
    }
  }
}

provider "huaweicloud" {
  region = var.HW_REGION
  access_key = var.HW_ACCESS_KEY
  secret_key = var.HW_SECRET_KEY
}

data "huaweicloud_availability_zones" "existing" {
  region = var.HW_REGION
}

data "huaweicloud_vpcs" "existing" {
  name = var.vpc_name
}

data "huaweicloud_vpc_subnets" "existing" {
  name = var.subnet_name
}

data "huaweicloud_networking_secgroups" "existing" {
  name = var.secgroup_name
}

locals {
  availability_zone = var.availability_zone == "" ? data.huaweicloud_availability_zones.existing.names[0] : var.availability_zone
  vpc_id            = length(data.huaweicloud_vpcs.existing.vpcs) > 0 ? data.huaweicloud_vpcs.existing.vpcs[0].id : huaweicloud_vpc.apig_vpc[0].id
  subnet_id         = length(data.huaweicloud_vpc_subnets.existing.subnets)> 0 ? data.huaweicloud_vpc_subnets.existing.subnets[0].id : huaweicloud_vpc_subnet.apig_subnet[0].id
  secgroup_id       = length(data.huaweicloud_networking_secgroups.existing.security_groups) > 0 ? data.huaweicloud_networking_secgroups.existing.security_groups[0].id : huaweicloud_networking_secgroup.apig_secgroup[0].id
}

resource "huaweicloud_vpc" "apig_vpc" {
  count = length(data.huaweicloud_vpcs.existing.vpcs) == 0 ? 1 : 0
  name = var.vpc_name
  cidr = "192.168.0.0/16"
}

resource "huaweicloud_vpc_subnet" "apig_subnet" {
  count             = length(data.huaweicloud_vpcs.existing.vpcs) == 0 ? 1 : 0
  name              = var.subnet_name
  cidr              = "192.168.0.0/24"
  gateway_ip        = "192.168.0.1"
  vpc_id            = local.vpc_id
  availability_zone = local.availability_zone
}

resource "huaweicloud_networking_secgroup" "apig_secgroup" {
  count       = length(data.huaweicloud_networking_secgroups.existing.security_groups) == 0 ? 1 : 0
  name        = var.secgroup_name
  description = "Security group for the apig instance"
}

resource "huaweicloud_networking_secgroup_rule" "secgroup_rule_0" {
  count             = length(data.huaweicloud_networking_secgroups.existing.security_groups) == 0 ? 1 : 0
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "121.37.117.211/32"
  security_group_id = local.secgroup_id
}

resource "huaweicloud_networking_secgroup_rule" "secgroup_rule_1" {
  count             = length(data.huaweicloud_networking_secgroups.existing.security_groups) == 0 ? 1 : 0
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 8080
  port_range_max    = 8088
  remote_ip_prefix  = "121.37.117.211/32"
  security_group_id = local.secgroup_id
}

resource "huaweicloud_networking_secgroup_rule" "secgroup_rule_2" {
  count             = length(data.huaweicloud_networking_secgroups.existing.security_groups) == 0 ? 1 : 0
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 9090
  port_range_max    = 9099
  remote_ip_prefix  = "121.37.117.211/32"
  security_group_id = local.secgroup_id
}

resource "huaweicloud_apig_instance" "apig_instance" {
  edition               = "BASIC"
  name                  = var.apig_instance_name
  security_group_id     = local.secgroup_id
  subnet_id             = local.subnet_id
  vpc_id                = local.vpc_id
  enterprise_project_id = var.HW_ENTERPRISE_PROJECT_ID
  availability_zones    = [local.availability_zone]
}

resource "huaweicloud_apig_environment" "apig_environment" {
  instance_id = huaweicloud_apig_instance.apig_instance.id
  name        = var.apig_environment_name
  description = "apig environment name"
}

resource "huaweicloud_apig_group" "apig_group" {
  instance_id = huaweicloud_apig_instance.apig_instance.id
  name        = var.apig_group_name
  description = "apig api group name"

  environment {
    variable {
      name  = "TERRAFORM"
      value = "/stage/terraform"
    }
    environment_id = huaweicloud_apig_environment.apig_environment.id
  }
}

resource "local_file" "create_xpanse_api_json" {
  filename = "create_xpanse_api_json.sh"
  content  = <<-EOF
#!/bin/bash
apt install jq
curl -s "${var.XPANSE_DOMAIN}/v3/api-docs" > xpanse_api.json
jq '.' xpanse_api.json > temp.json
mv temp.json xpanse_api.json
  EOF
  file_permission = "0777"
  directory_permission = "0777"
}

resource "null_resource" "exec_create_xpanse_api" {
  provisioner "local-exec" {
    command = "/bin/bash create_xpanse_api_json.sh"
  }
  depends_on = [
    local_file.create_xpanse_api_json
  ]
}

resource "local_file" "install_hcloud" {
  filename = "install_hcloud.sh"
  content = <<-EOF
#!/bin/bash
curl -sSL https://cn-north-4-hdn-koocli.obs.cn-north-4.myhuaweicloud.com/cli/latest/hcloud_install.sh -o ./hcloud_install.sh && bash ./hcloud_install.sh -y
hcloud configure set --cli-profile=default --cli-region="${var.HW_REGION}" --cli-access-key="${var.HW_ACCESS_KEY}" --cli-secret-key="${var.HW_SECRET_KEY}"
  EOF
  file_permission = "0777"
  directory_permission = "0777"
}

resource "null_resource" "exec_install_hcloud" {
  provisioner "local-exec" {
    command = "/bin/bash install_hcloud.sh"
  }
  depends_on = [
    local_file.install_hcloud
  ]
}

resource "null_resource" "import_xpanse_api" {
  provisioner "local-exec" {
    command = "yes | hcloud APIG ImportApiDefinitionsV2 --project_id='${var.HW_PROJECT_ID}' --cli-region='${var.HW_REGION}' --instance_id='${huaweicloud_apig_instance.apig_instance.id}' --group_id='${huaweicloud_apig_group.apig_group.id}' --simple_mode=true --file_name='${path.root}/xpanse_api.json'"
  }
  depends_on = [
    huaweicloud_apig_instance.apig_instance,
    huaweicloud_apig_group.apig_group,
    local_file.create_xpanse_api_json,
    local_file.install_hcloud
  ]
}

resource "null_resource" "publish_xpanse_api" {
  provisioner "local-exec" {
    command = "yes | hcloud APIG BatchPublishOrOfflineApiV2 --project_id='${var.HW_PROJECT_ID}' --cli-region='${var.HW_REGION}' --instance_id='${huaweicloud_apig_instance.apig_instance.id}' --env_id='${huaweicloud_apig_environment.apig_environment.id}'  --group_id='${huaweicloud_apig_group.apig_group.id}' --action='online'"
  }
  depends_on = [
    huaweicloud_apig_instance.apig_instance,
    huaweicloud_apig_environment.apig_environment,
    huaweicloud_apig_group.apig_group,
    local_file.install_hcloud
  ]
}


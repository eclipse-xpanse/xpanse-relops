resource "huaweicloud_networking_secgroup_rule" "xpanse" {
  security_group_id = data.huaweicloud_networking_secgroups.existing.security_groups[0].id
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = var.port
  port_range_max    = var.port
  remote_ip_prefix  = data.huaweicloud_vpc_subnets.existing.subnets[0].cidr
  description       = "rule to allow database connections within the subnet"
}
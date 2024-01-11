resource "huaweicloud_rds_mysql_database" "xpanse" {
  instance_id   = huaweicloud_rds_instance.instance.id
  name          = var.db_name
  character_set = "utf8"
  description   = format("%s %s", var.db_name, "database")
}
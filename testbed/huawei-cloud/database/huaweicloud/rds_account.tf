resource "huaweicloud_rds_mysql_account" "xpanse" {
  instance_id = huaweicloud_rds_instance.instance.id
  name        = var.application_db_user
  password    = var.application_db_password
  hosts       = ["%"]
}

resource "huaweicloud_rds_mysql_database_privilege" "test" {
  instance_id = huaweicloud_rds_instance.instance.id
  db_name     = var.db_name

  users {
    name     = var.application_db_user
    readonly = false
  }
}
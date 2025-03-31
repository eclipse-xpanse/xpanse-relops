resource "clevercloud_addon" "xpanse_db" {
  name                 = "db"
  region               = "par"
  plan                 = "dev"
  third_party_provider = "mysql-addon"
}

resource "clevercloud_docker" "xpanse" {
  name               = "xpanse"
  region             = "par"
  min_instance_count = 1
  max_instance_count = 1
  smallest_flavor    = "M"
  biggest_flavor     = "M"

  deployment {
    repository = var.docker_repository_url
    commit     = var.docker_commit
  }

  dockerfile = "testbed/clever-cloud/Dockerfile"

  environment = {
    CC_DOCKERFILE                       = "testbed/clever-cloud/Dockerfile"
    SPRING_PROFILES_ACTIVE              = "dev,noauth,mysql,terra-boot,tofu-maker"
    SPRING_DATASOURCE_DRIVER_CLASS_NAME = "com.mysql.cj.jdbc.Driver"
    SPRING_DATASOURCE_USERNAME          = clevercloud_addon.xpanse_db.configurations["MYSQL_ADDON_USER"]
    SPRING_DATASOURCE_PASSWORD          = clevercloud_addon.xpanse_db.configurations["MYSQL_ADDON_PASSWORD"]
    SPRING_DATASOURCE_URL               = "jdbc:mysql://${clevercloud_addon.xpanse_db.configurations["MYSQL_ADDON_HOST"]}:${clevercloud_addon.xpanse_db.configurations["MYSQL_ADDON_PORT"]}/${clevercloud_addon.xpanse_db.configurations["MYSQL_ADDON_DB"]}"
    SPRING_JPA_DATABASE_PLATFORM        = "org.hibernate.dialect.MySQLDialect"
    SPRING_JPA_HIBERNATE_DDL_AUTO       = "update"
    
    POLICY_MAN_ENDPOINT  = var.is_final_environment ? "https://policy-man.${var.custom_domain_name}" : "https://${clevercloud_docker.policy_man.name}.cleverapps.io"
    TERRA_BOOT_ENDPOINT  = var.is_final_environment ? "https://terra-boot.${var.custom_domain_name}" : "https://${clevercloud_docker.terraboot.name}.cleverapps.io"
    TOFU_MAKER_ENDPOINT  = var.is_final_environment ? "https://tofu-maker.${var.custom_domain_name}" : "https://${clevercloud_docker.tofu_maker.name}.cleverapps.io"
    UI_ENDPOINT          = var.is_final_environment ? "https://ui.${var.custom_domain_name}" : "https://ui.cleverapps.io"
  }

  additional_vhosts = var.is_final_environment ? ["xpanse.${var.custom_domain_name}"] : []

  dependencies = [
    clevercloud_addon.xpanse_db.id,
    clevercloud_docker.policy_man.id,
    clevercloud_docker.terraboot.id,
    clevercloud_docker.tofu_maker.id,
    clevercloud_docker.xpanse_ui.id
  ]
}
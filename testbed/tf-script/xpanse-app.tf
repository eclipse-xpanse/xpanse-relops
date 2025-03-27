terraform {
  required_providers {
    clevercloud = {
      source  = "CleverCloud/clevercloud"
      version = "0.7.0"
    }
  }
}

provider "clevercloud" {
  token        = "5a6a9d9b30984f3a8070acbef3caef00"
  secret       = "rnREaIe1M.Y7sYDWjEexmzNLaAewq3Dv"
  organisation = "user_8701f014-a86a-4587-a317-7e062eb347b9"
}

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
    repository = "https://github.com/damiano000/xpanse-relops.git"
    commit     = "refs/heads/main"
  }

  dockerfile = "testbed/clever-cloud/Dockerfile"

  environment = {
    CC_DOCKERFILE                       = "testbed/clever-cloud/Dockerfile"
    SPRING_PROFILES_ACTIVE              = "dev,noauth,mysql,terra-boot,tofu-maker"
    POLICY_MAN_ENDPOINT                 = "https://app-726ffe59-3913-4ce7-ac53-97d7b3751579.cleverapps.io"
    SPRING_DATASOURCE_DRIVER_CLASS_NAME = "com.mysql.cj.jdbc.Driver"
    SPRING_DATASOURCE_USERNAME          = clevercloud_addon.xpanse_db.configurations["MYSQL_ADDON_USER"]
    SPRING_DATASOURCE_PASSWORD          = clevercloud_addon.xpanse_db.configurations["MYSQL_ADDON_PASSWORD"]
    SPRING_DATASOURCE_URL               = "jdbc:mysql://${clevercloud_addon.xpanse_db.configurations["MYSQL_ADDON_HOST"]}:${clevercloud_addon.xpanse_db.configurations["MYSQL_ADDON_PORT"]}/${clevercloud_addon.xpanse_db.configurations["MYSQL_ADDON_DB"]}"
    SPRING_JPA_DATABASE_PLATFORM        = "org.hibernate.dialect.MySQLDialect"
    SPRING_JPA_HIBERNATE_DDL_AUTO       = "update"
    TERRA_BOOT_ENDPOINT                 = "https://app-4343b688-b31f-4a4e-alf9-fd04b6ad93fe.cleverapps.io"
    TOFU_MAKER_ENDPOINT                 = "https://app-3b2a6007-le21-468a-997b-0b6a57202809.cleverapps.io"
    UI_ENDPOINT                         = "https://app-cb3edd4b-7a9c-4e26-9694-b3ef8863066a.cleverapps.io"
  }

  dependencies = [
    clevercloud_addon.xpanse_db.id
  ]
}
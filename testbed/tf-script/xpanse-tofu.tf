resource "clevercloud_docker" "tofu_maker" {
  name               = "tofu-maker"
  region             = "par"
  min_instance_count = 1
  max_instance_count = 1
  smallest_flavor    = "M"
  biggest_flavor     = "M"

  deployment {
    repository = var.docker_repository_url
    commit     = var.docker_commit
  }

  dockerfile = "testbed/clever-cloud/tofu-maker/Dockerfile"

  environment = {
    CC_DOCKER_EXPOSED_HTTP_PORT = "9092"
    CC_DOCKERFILE               = "testbed/clever-cloud/tofu-maker/Dockerfile"
    SPRING_PROFILES_ACTIVE      = "dev,noauth"
  }

  additional_vhosts = var.is_final_environment ? ["tofu-maker.${var.custom_domain_name}"] : []
}
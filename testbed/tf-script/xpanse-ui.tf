resource "clevercloud_docker" "xpanse_ui" {
  name               = "ui"
  region             = "par"
  min_instance_count = 1
  max_instance_count = 1
  smallest_flavor    = "M"
  biggest_flavor     = "M"

  deployment {
    repository = var.docker_repository_url
    commit     = var.docker_commit
  }

  dockerfile = "testbed/clever-cloud/xpanse-ui/Dockerfile"

  environment = {
    CC_DOCKER_EXPOSED_HTTP_PORT = "3000"
    CC_DOCKERFILE               = "testbed/clever-cloud/xpanse-ui/Dockerfile"
    SPRING_PROFILES_ACTIVE      = "dev,noauth"
  }
}
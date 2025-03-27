resource "clevercloud_docker" "tofu_maker" {
  name               = "tofu-maker"
  region             = "par"
  min_instance_count = 1
  max_instance_count = 1
  smallest_flavor    = "M"
  biggest_flavor     = "M"

  deployment {
    repository = "https://github.com/damiano000/xpanse-relops.git"
    commit     = "refs/heads/main"
  }

  dockerfile = "testbed/clever-cloud/tofu-maker/Dockerfile"

  environment = {
    CC_DOCKER_EXPOSED_HTTP_PORT = "9092"
    CC_DOCKERFILE               = "testbed/clever-cloud/tofu-maker/Dockerfile"
    SPRING_PROFILES_ACTIVE      = "dev,noauth"
  }
}
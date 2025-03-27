resource "clevercloud_docker" "terraboot" {
  name               = "terraboot"
  region             = "par"
  min_instance_count = 1
  max_instance_count = 1
  smallest_flavor    = "M"
  biggest_flavor     = "M"

  deployment {
    repository = "https://github.com/damiano000/xpanse-relops.git"
    commit     = "refs/heads/main"
  }

  dockerfile = "testbed/clever-cloud/terra-boot/Dockerfile"

  environment = {
    CC_DOCKER_EXPOSED_HTTP_PORT = "9090"
    CC_DOCKERFILE               = "testbed/clever-cloud/terra-boot/Dockerfile"
    SPRING_PROFILES_ACTIVE      = "dev,noauth"
  }
}
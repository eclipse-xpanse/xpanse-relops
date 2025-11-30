resource "clevercloud_docker" "policy_man" {
  name               = "policy-man"
  region             = "par"
  min_instance_count = 1
  max_instance_count = 1
  smallest_flavor    = "M"
  biggest_flavor     = "M"

  deployment {
    repository = var.docker_repository_url
    commit     = var.docker_commit
  }

  dockerfile = "testbed/clever-cloud/policy-man/Dockerfile"

  environment = {
    CC_DOCKER_EXPOSED_HTTP_PORT = "8090"
    CC_DOCKERFILE               = "testbed/clever-cloud/policy-man/Dockerfile"
    SERVER_ADDRESS              = "0.0.0.0"
  }

  additional_vhosts = var.is_final_environment ? ["policy-man.${var.custom_domain_name}"] : []
}
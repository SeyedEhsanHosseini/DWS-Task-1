provider "docker" {
  host = "tcp://${var.INSTANCE_IP_ADDRESS}:2375"

  registry_auth {
    address       = "http://${var.INSTANCE_IP_ADDRESS}:${var.LOCAL_REGISTRY_PORT}"
    auth_disabled = true
  }
}

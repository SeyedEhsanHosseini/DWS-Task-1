resource "docker_image" "registry" {
  name = "registry:2"
}

resource "docker_container" "localRegistry" {
  name    = "localRegistry"
  image   = docker_image.registry.name
  restart = "unless-stopped"


  volumes {
    container_path = "/var/lib/data"
    volume_name    = "docker_registry_data"
  }


  env = toset(["REGISTRY_HTTP_ADDR=0.0.0.0:${var.LOCAL_REGISTRY_PORT}"])

  ports {
    internal = var.LOCAL_REGISTRY_PORT
    external = var.LOCAL_REGISTRY_PORT
  }
}

resource "docker_image" "flaskapp" {
  name = "${var.INSTANCE_IP_ADDRESS}:${var.LOCAL_REGISTRY_PORT}/flaskapp:latest"
  build {
    context = "../app/"
  }

}

resource "docker_registry_image" "localregistry" {
  name                 = docker_image.flaskapp.name
  keep_remotely        = true
  insecure_skip_verify = true


  depends_on = [
    docker_container.localRegistry,
    docker_image.flaskapp
  ]
}

resource "docker_container" "myapp" {
  name         = "myapp"
  image        = docker_image.flaskapp.name
  restart      = "unless-stopped"
  network_mode = "host"
  ports {
    internal = var.APPLICATION_PUBLISH_PORT
    external = var.APPLICATION_PUBLISH_PORT
  }
}





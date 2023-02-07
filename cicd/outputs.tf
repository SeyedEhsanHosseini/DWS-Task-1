output "Application_Address" {
  value = "http://${var.INSTANCE_IP_ADDRESS}:${var.APPLICATION_PUBLISH_PORT}"
}
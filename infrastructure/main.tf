resource "maas_instance" "maas_instance" {
  count               = 1
  release_erase       = false
  release_erase_quick = true
}

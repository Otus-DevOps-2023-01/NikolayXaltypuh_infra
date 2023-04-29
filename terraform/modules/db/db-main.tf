
resource "yandex_compute_instance" "db" {

  network_interface {
    # Указан id подсети default-ru-central1-a
    subnet_id = var.subnet_id
    nat       = true
  }

  timeouts {
    create = "1h30m"
    update = "2h"
    delete = "20m"
  }
  name = "reddit-db"

  labels = {
     tags = "reddit-db"
  }

  metadata = {
  ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }

  resources {
    core_fraction = 20
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      # Указать id образа созданного в предыдущем домашем задании
      image_id = var.db_disk_image
    }
  }


  connection {
    type = "ssh"
    host = yandex_compute_instance.db.network_interface.0.nat_ip_address
    user = "ubuntu"
    agent = false
    # путь до приватного ключа
#    private_key = file("~/.ssh/appuser")
    private_key = file("appuser")
  }

#  provisioner "file" {
#    source = "files/puma.service"
#    destination = "/tmp/puma.service"
#  }

#  provisioner "remote-exec" {
#    script = "files/deploy.sh"
#  }

}


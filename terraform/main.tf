provider "yandex" {
  token = "y0_AgAAAAAN0hW5AATuwQAAAADd8a2B1z3fBsabSg6pVKkw8SCSlFPcFqA"
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}

resource "yandex_compute_instance" "app" {
  timeouts {
    create = "1h30m"
    update = "2h"
    delete = "20m"
  }
  name = "reddit-app"
  metadata = {
  ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }
  resources {
    core_fraction = 100
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      # Указать id образа созданного в предыдущем домашем задании
      image_id = var.image_id
    }
  }

  network_interface {
    # Указан id подсети default-ru-central1-a
    subnet_id = var.subnet_id
    nat       = true
  }
  connection {
    type = "ssh"
    host = yandex_compute_instance.app.network_interface.0.nat_ip_address
    user = "ubuntu"
    agent = false
    # путь до приватного ключа
    private_key = file("~/.ssh/appuser")
  }

  provisioner "file" {
    source = "files/puma.service"
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }

}


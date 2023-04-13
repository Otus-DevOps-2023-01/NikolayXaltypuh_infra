provider "yandex" {
token = "y0_AgAAAAAN0hW5AATuwQAAAADd8a2B1z3fBsabSg6pVKkw8SCSlFPcFqA"
cloud_id = "b1ghhvgt38tridqj20lc"
folder_id = "b1gorlhceujso72eqd4g"
zone = "ru-central1-a"
}


resource "yandex_compute_instance" "app" {
  timeouts {
    create = "1h30m"
    update = "2h"
    delete = "20m"
  }
  name = "reddit-app"
  metadata = {
  ssh-keys = "ubuntu:${file("~/.ssh/appuser.pub")}"
  }
  resources {
    core_fraction = 5
    cores  = 2
    memory = 1
  }

  boot_disk {
    initialize_params {
      # Указать id образа созданного в предыдущем домашем задании
      image_id = "fd8651iib8j0j6hlc8cl"
    }
  }

  network_interface {
    # Указан id подсети default-ru-central1-a
    subnet_id = "e9bq99lcjluu8j5g5sgg"
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



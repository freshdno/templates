terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.177.0"
    }
  }
}

provider "yandex" {
  zone = "ru-central1-a"
}

resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

resource "yandex_compute_disk" "boot_disk" {
  count    = var.vm_count
  name     = "boot-disk-${count.index + 1}"
  type     = "network-hdd"
  zone     = "ru-central1-a"
  size     = var.disk_size
  image_id = fd861t36p9dqjfrqm0g4
}

resource "yandex_compute_instance" "vm" {
  count = var.vm_count
  name  = "terraform-${count.index + 1}"

  resources {
    cores  = var.vm_cores
    memory = var.vm_memory
  }

  boot_disk {
    disk_id = yandex_compute_disk.boot_disk[count.index].id
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    user-data = file("$/home/serega/templates/meta.txt")
  }
}

output "internal_ips" {
  value = yandex_compute_instance.vm[*].network_interface[0].ip_address
}

output "external_ips" {
  value = yandex_compute_instance.vm[*].network_interface[0].nat_ip_address
}

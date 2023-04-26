variable zone {
  description = "Zone"
  # Значение по умолчанию
  default = "ru-central1-a"
}
variable public_key_path {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}
variable subnet_id{
  description = "Subnet"
}

variable "instances_count" {
  description = "Count instances"
  default     = 1
}
variable "region_id" {
  description = "Region"
  default     = "ru-central1"
}

variable db_disk_image {
  description = "Disk image for reddit db"
  default = "fd8fkrbk70vmcmut1fic"
}

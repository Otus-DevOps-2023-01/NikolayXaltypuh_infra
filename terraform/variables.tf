variable cloud_id{
  description = "Cloud"
}
variable folder_id {
  description = "Folder"
}
variable zone {
  description = "Zone"
  # Значение по умолчанию
  default = "ru-central1-a"
}
variable public_key_path {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}

variable service_account_key_file{
  description = "key .json"
}
variable "instances_count" {
  description = "Count instances"
  default     = 1
}
variable "region_id" {
  description = "Region"
  default     = "ru-central1"
}

variable subnet_id{
  description = "Subnet"
}

variable  access_key  {
description  =  "Key id"
}
variable  secret_key  {
description  =  "Secret key"
}
variable  bucket_name  {
description  =  "Bucket name"
}

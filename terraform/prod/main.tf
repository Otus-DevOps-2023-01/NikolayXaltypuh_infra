provider "yandex" {
  token = "y0_AgAAAAAN0hW5AATuwQAAAADd8a2B1z3fBsabSg6pVKkw8SCSlFPcFqA"
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}

module "app" {
  source = "../modules/app"
  public_key_path = var.public_key_path
  subnet_id = var.subnet_id
}

module "db" {
  source = "../modules/db"
  public_key_path = var.public_key_path
  subnet_id = var.subnet_id
}

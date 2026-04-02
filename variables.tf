variable "project" {
  description = "Nom du projet"
  type        = string
  default     = "demo"
}

variable "env" {
  description = "Environnement de déploiement"
  type        = string
  default     = "dev"
}

variable "location" {
  description = "Région Azure pour le déploiement"
  type        = string
  default     = "germanywestcentral"
}

variable "subscription_id" {
  description = "Identifiant de l'abonnement Azure"
  type        = string
}

variable "asp_sku_name" {
  description = "SKU du Service Plan App Service"
  type        = string
  default     = "S1"
}

variable "vnet_address_space" {
  description = "Plage d'adresses du VNet"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_address_prefixes" {
  description = "Plage d'adresses du subnet dédié à la WebApp"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "php_version" {
  description = "Version PHP utilisée par la WebApp"
  type        = string
  default     = "8.2"
}

locals {
  rg_name     = "${var.project}-${upper(var.env)}-RG"
  asp_name    = "${var.project}-${var.env}-ASP"
  webapp_name = lower("${var.project}-${var.env}-WEBAPP")
  vnet_name = "${var.project}-${var.env}-VNET"
  subnet_name = "${var.project}-${var.env}-SUBNET"
}
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
  default     = "westeurope"
}

locals {
  rg_name  = "${var.project}-${upper(var.env)}-RG"
  sta_name = lower("${var.project}${var.env}sta")
  vnet_name = "${var.project}-${var.env}-VNET"
}
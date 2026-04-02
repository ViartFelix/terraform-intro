variable "resource_group_name" {
  type = string
}

variable "storageaccountname" {
  type = string
  default = "terraform"
}

variable "location" {
  type = string
}

variable "virtual_network_name" {
  type = string
}

variable "project" {
  type = string
}

variable "env" {
  type = string
}

variable "spname" {
  type = string
}

variable "webappname" {
  type = string
}

locals {
 rgname = upper(var.resource_group_name)
 appname = lower(var.webappname)
 spnom = "${var.project}-${var.env}-SP-${var.spname}"
 vnetname = var.virtual_network_name 
}
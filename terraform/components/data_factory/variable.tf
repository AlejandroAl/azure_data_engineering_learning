variable "ENV" {
  type        = string
  description = "Environment where the resource will be created"
  default     = "dev"
}

variable "RESOURCE_GROUP_NAME" {
  type        = string
  description = "resource group where the data factory will be created"
}


variable "LOCATION" {
  type        = string
  description = "The Azure Region in which all resources in this example should be created."
  default     = "westeurope"
}

variable "SUBFFIX_NAME_ADF" {
  type        = string
  description = "subffix name used to create data factory name, it will be created with the following structure adf-<<ENV>>>-<<SUBFFIX_NAME_ADF>>-<<location>>"
}


locals {
  adf_name = "adf${var.ENV}${var.SUBFFIX_NAME_ADF}${var.LOCATION}"
}
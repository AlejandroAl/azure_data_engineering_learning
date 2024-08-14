variable "ENV" {
  type        = string
  description = "Environment where the resource will be created"
  default     = "dev"
}

variable "REGION" {
  type        = string
  description = "The Region for billing."
  default     = "global"
}



variable "STORAGE_ACCOUNT_REPLICATION_TYPE" {
  type        = string
  description = "Storage Account replication type."
  default     = "LRS"
}


variable "LOCATION" {
  type        = string
  description = "The Azure Region in which all resources in this example should be created."
  default     = "westeurope"
}

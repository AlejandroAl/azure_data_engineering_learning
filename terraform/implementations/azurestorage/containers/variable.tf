variable "ENV" {
  type        = string
  description = "Environment where the resource will be created"
  default     = "dev"
}

variable "storage_account_name" {
  type        = string
  description = "Storage account where the azure table will be created"
}

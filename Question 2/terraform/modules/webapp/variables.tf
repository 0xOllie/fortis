variable "name" {
  type        = string
  default     = "fortis"
  description = "The name of the application, used for naming other resources."
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC to deploy resources into."
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "A list of public subnet IDs, used by the bastion host."
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "A list of private subnet IDs, used by the application host."
}

variable "database_subnet_ids" {
  type        = list(string)
  description = "A list of database subnet IDs, used by RDS."
}

variable "key_name" {
  type        = string
  default     = "fortis"
  description = "The SSH key to install on the servers, defaults to `fortis`."
}

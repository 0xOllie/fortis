variable "aws_profile" {
  type        = string
  default     = "default"
  description = "The AWS profile to use for the AWS provider."
}

variable "aws_default_region" {
  type        = string
  default     = "us-east-1"
  description = "The AWS region to deploy resources into."
}

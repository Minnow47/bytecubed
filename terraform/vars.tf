terraform {
  backend "s3" {
    bucket = "sd-tfstate" # ! REPLACE WITH YOUR TERRAFORM BACKEND BUCKET
    key    = "terraform.tfstate"
    region = "us-west-2"
  }
}
variable "S3_BACKEND_BUCKET" {
  default = "sd-tfstate" # ! REPLACE WITH YOUR TERRAFORM BACKEND BUCKET
}

variable "S3_BUCKET_REGION" {
  type    = "string"
  default = "us-west-2"
}

variable "AWS_PROFILE" {
  type    = "string"
  default = "terraform"
}

variable "AWS_REGION" {
  type    = "string"
  default = "us-east-1"
}

variable "TAG_ENV" {
  default = "dev"
}

variable "ENV" {
  default = "DEV"
}

variable "CIDR_PRIVATE" {
  default = "10.0.1.0/24,10.0.2.0/24"
}

variable "CIDR_PUBLIC" {
  default = "10.0.101.0/24,10.0.102.0/24"
}

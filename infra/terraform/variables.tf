variable "aws_region" {
  default = "us-east-1"
}

variable "availability_zone_1" {
  default = "us-east-1a"
}

variable "availability_zone_2" {
  default = "us-east-1b"
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  default     = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI (x86_64) in us-east-1
}

variable "key_name" {
  default = "Baffoe6"
}

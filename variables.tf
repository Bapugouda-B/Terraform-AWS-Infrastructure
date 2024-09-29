variable "region" {
  description = "AWS region to create resources"
  default     = "us-east-1"
}

variable "ami_id" {
  description = "AMI ID for Ubuntu 24.04"
  default     = "ami-0e86e20dae9224db8"
}
					
variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}
			
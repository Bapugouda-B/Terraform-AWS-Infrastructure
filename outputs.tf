output "instance_1_public_ip" {
  description = "Public IP of the first EC2 instance"
  value       = aws_instance.web1.public_ip
}

output "instance_2_public_ip" {
  description = "Public IP of the second EC2 instance"
  value       = aws_instance.web2.public_ip
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main_vpc.id
}

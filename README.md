# Terraform AWS Project

## Project Overview
This project demonstrates how to use Terraform to create a simple infrastructure on AWS. The architecture consists of a VPC, two subnets, and two EC2 instances with Apache2 installed. The EC2 instances are distributed across different subnets for high availability.

## Prerequisites
- AWS Account
- Terraform installed on your local system( VM Server)
- IAM user with permissions to create AWS resources
- SSH key pair for connecting to the EC2 instances

## How to Run the Project

### Step 1: Clone the Repository
```bash 
https://github.com/Bapugouda-B/Terraform-AWS-Infrastructure
cd Terraform-AWS-Infrastructure
```

### Step 2: Initialize Terraform
```bash 
terraform init
```


### Step 3: Review the Plan
```bash 
terraform plan
```


### Step 4: Apply the Configuration
```bash
terraform apply
```


Type `yes` when prompted to confirm the infrastructure creation.

### Step 5: Access the EC2 Instances
Once the resources are created, go to the AWS Console and navigate to the EC2 Dashboard. Copy the public IP addresses and access the Apache2 server using:


### Step 6: Destroy the Infrastructure
To clean up resources:
```bash
terraform destroy
```

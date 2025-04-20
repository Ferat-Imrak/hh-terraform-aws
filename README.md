# Secure & Highly Available AWS Infrastructure with Terraform

This project provisions a secure, highly available AWS environment using Terraform with a modular structure. It includes:

- **VPC**: Configured with public and private subnets for network segmentation.
- **EC2 Instances**: Deployed behind an Application Load Balancer (ALB) and managed by an Auto Scaling Group (ASG) for high availability and scalability.
- **MySQL RDS Instance**: Multi-AZ deployment for database redundancy and reliability.
- **Private S3 Bucket**: Used for secure document storage.
- **Monitoring**: Integrated with CloudWatch and CloudTrail for logging, monitoring, and auditing.
- **Basic Web App**: Displays the public IP address of the application.

## Requirements

- **Terraform**: v1.0+
- **AWS CLI**: Configured with proper credentials.
- **IAM Permissions**: Required for creating the following resources:
  - EC2
  - RDS
  - ALB
  - S3
  - CloudWatch
  - CloudTrail


  ## Usage

1. **Clone the Repository**
   git clone https://github.com/your-repo/aws-ha-terraform.git
   cd aws-ha-terraform

2. **Set Your Variables**

   Edit the `terraform.tfvars` file with your desired configuration:

   aws_region    = "us-east-1"
   vpc_cidr      = "10.0.0.0/16"
   ami_id        = "ami-0c55b159cbfafe1f0" # Amazon Linux 2
   instance_type = "t3.micro"
   bucket_name   = "private-documents-bucket"

   user_data = <<-EOF
     #!/bin/bash
     yum update -y
     yum install -y httpd
     systemctl start httpd
     systemctl enable httpd
     PUBLIC_IP=$(curl http://169.254.169.254/latest/meta-data/public-ipv4)
     echo "<html><h1>Hello, World!</h1><p>Public IP: $PUBLIC_IP</p></html>" > /var/www/html/index.html
   EOF

3. **Initialize Terraform**

   terraform init

4. **Validate and Plan**

   terraform validate
   terraform plan

5. **Apply the Configuration**

   terraform apply -auto-approve 


## Accessing the App

Once the infrastructure is up, Terraform will output the ALB DNS name.

Open it in your browser:

http://<alb_dns_name>


## Destroying Resources

When you're done testing, clean up everything:

```bash
terraform destroy


## Notes

- Ensure your AWS user has proper permissions.
- RDS will take a few minutes to become available.
- S3 bucket names must be globally unique.
- You can reuse modules in other projects or environments.
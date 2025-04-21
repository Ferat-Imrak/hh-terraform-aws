# Allows HTTP (port 80) access from anywhere and SSH (port 22) access from a specific IP.
resource "aws_security_group" "ec2_sg" {
  name        = "ec2-sg"
  description = "Allow HTTP and SSH access"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["73.36.37.1/32"]
}

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Launches an EC2 instance using the specified AMI, instance type, and user data script.
resource "aws_instance" "web" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = element(var.public_subnet_ids, 0)
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  user_data                   = var.user_data

  root_block_device {
    encrypted = true
  }

  tags = {
    Name = "web-server"
  }
}

# Define an AWS Launch Template resource
resource "aws_launch_template" "web" {
  name                   = "web-launch-template"
  image_id               = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  user_data              = base64encode(var.user_data)
}

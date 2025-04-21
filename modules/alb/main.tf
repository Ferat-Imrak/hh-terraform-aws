# Security group for the Application Load Balancer
resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "Security group for ALB"
  vpc_id      = var.vpc_id
  # Ingress rule: Allow HTTP traffic from a specific IP range
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["73.36.37.1/32"] # Allows traffic from all IPs (can be restricted further if needed)
  }

  # Egress rule: Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allows traffic to all destinations
  }
}

# This resource creates an ALB to distribute incoming traffic across backend resources.
resource "aws_lb" "main" {
  name               = "main-alb"
  load_balancer_type = "application"
  subnets            = var.subnet_ids
  security_groups    = [aws_security_group.alb_sg.id]
}

# Defines the backend resources (e.g., EC2 instances) that the ALB will route traffic to.
resource "aws_lb_target_group" "main" {
  name     = "main-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "instance"
}

# Configures the ALB to listen for incoming traffic on a specific port and protocol.
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}

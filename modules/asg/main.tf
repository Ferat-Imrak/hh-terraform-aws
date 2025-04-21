# This resource manages a group of EC2 instances, ensuring the desired number of instances are running.
resource "aws_autoscaling_group" "web" {
  desired_capacity     = 2
  max_size             = 3
  min_size             = 1
  vpc_zone_identifier  = var.subnet_ids
  # Launch template for EC2 instance configuration
  launch_template {
    id = var.launch_template_id
  }

  # Associates the Auto Scaling Group with a load balancer to distribute traffic
  target_group_arns = [var.target_group_arn]

  tag {
    key                 = "Name"
    value               = "web-instance"
    propagate_at_launch = true
  }
}

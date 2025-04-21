resource "aws_autoscaling_group" "web" {
  desired_capacity     = 2
  max_size             = 3
  min_size             = 1
  vpc_zone_identifier  = var.subnet_ids
  launch_template {
    id = var.launch_template_id
  }

  target_group_arns = [var.target_group_arn]

  tag {
    key                 = "Name"
    value               = "web-instance"
    propagate_at_launch = true
  }
}

resource "aws_lb" "load_balancer" {
  name               = var.lb_name
  internal           = var.internal
  load_balancer_type = var.lb_type
}

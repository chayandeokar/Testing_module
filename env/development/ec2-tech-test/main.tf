module "ec2_instance" {
  source     = "../../modules/VirtualMachine"
  ami        = "ami-12345678"
  instance_type = "t2.micro"
}

module "load_balancer" {
  source   = "../../modules/LoadBalancer"
  lb_name  = "my-load-balancer"
  internal = false
  lb_type  = "application"
}

resource "aws_instance" "ec2_instance" {
  ami           = module.ec2_instance.ami
  instance_type = module.ec2_instance.instance_type

  # Add EC2 instance to the Load Balancer target group
  lifecycle {
    create_before_destroy = true
  }

  depends_on = [module.load_balancer]

  provisioner "local-exec" {
    command = <<-EOT
      aws elbv2 register-targets --target-group-arn ${module.load_balancer.lb_target_group_arn} --targets Id=${aws_instance.ec2_instance.id}
    EOT
  }
}

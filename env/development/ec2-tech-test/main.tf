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

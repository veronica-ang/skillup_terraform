#Input Region 
region = "ap-southeast-1"

#Enter VPC Details
vpc = {
  #CIDR and internet gateway
  cidr_block = "11.0.0.0/16"
  vpc_name   = "skillup-malcedo-vpc"
  igw_name   = "skillup-malcedo-igw"

  #VPC subnets
  subnet_public_name = ["skillup-malcedo-public-1", "skillup-malcedo-public-2"]
  public_av_zone     = ["ap-southeast-1a", "ap-southeast-1c"]
  public_cidr        = ["11.0.1.0/24", "11.0.2.0/24"]

  subnet_private_name = ["skillup-malcedo-private-1", "skillup-malcedo-private-2"]
  private_av_zone     = ["ap-southeast-1a", "ap-southeast-1c"]
  private_cidr        = ["11.0.3.0/24", "11.0.4.0/24"]

  subnet_db_name = ["skillup-malcedo-db-1", "skillup-malcedo-db-2"]
  db_av_zone     = ["ap-southeast-1a", "ap-southeast-1c"]
  db_cidr        = ["11.0.5.0/24", "11.0.6.0/24"]

  #NAT gateway
  nat_name = "skillup-malcedo-nat"

  #elastic_ip is just a reference 
  elastic_ip_allocation_id = "eipalloc-0a367f676eb040dc9"

  #Route table details and endpoint
  public_rt_name   = "skillup-malcedo-public-rt"
  private_rt_name  = "skillup-malcedo-private-rt"
  s3_endpoint_name = "skillup-malcedo-s3-endpoint"
}

#Enter Bastion Details
bastion = {
  #Security group details
  bastion_sg_name        = "skillup-malcedo-bastion-sg"
  bastion_sg_description = "security group for skillup-malcedo bastion access"

  #Input Bastion details and specs
  bastion_name      = "skillup-malcedo-bastion"
  ami_id            = "ami-05c8486d62efc5d07"
  ec2_instance_type = "t2.micro"
  ec2_az            = "ap-southeast-1c"
  key_name          = "skillup-malcedo"
  iam_user          = "skillup-malcedo-1b-IAM-S3ReadOnly"
}

#Bastion SG rule
bastion_sg_rule_tcp_6522 = {
  from_port     = "6522"
  to_port       = "6522"
  protocol_type = "tcp"
  inbound_ip    = ["203.126.64.69/32"]
}


#Enter Load Balancer Details
alb = {
  #Security group details
  alb_sg_name        = "skillup-malcedo-alb-sg"
  alb_sg_description = "security group for malcedo alb"

  #Applciation Load Balancer
  alb_name = "skillup-malcedo-alb"
  alb_type = "application"

  #Target Group
  tg_name     = "skillup-malcedo-tg"
  target_type = "instance"
  tg_port     = "80"
  tg_protocol = "HTTP"
  #Health Check
  hc_path                = "/"
  hc_port                = "80"
  hc_protocol            = "HTTP"
  hc_timeout             = "5"
  hc_healthy_threshold   = "3"
  hc_unhealthy_threshold = "3"
  hc_interval            = "200"
  hc_matcher             = "200-499"
  #Listener
  listener_port     = "80"
  listener_protocol = "HTTP"
  listener_type     = "forward"
}
#Input ALB SG rule
alb_sg_rule_tcp_80 = {
  from_port     = "80"
  to_port       = "80"
  protocol_type = "tcp"
  inbound_ip    = ["203.126.64.69/32"]
}

#Active Scaling Group
asg = {
  #Security group details
  asg_sg_name        = "skillup-malcedo-asg-sg"
  asg_sg_description = "security group for malcedo asg"

  #Launch configuration details
  launchconfig_name          = "skillup-malcedo-lc"
  launchconfig_ami_id        = "ami-05c8486d62efc5d07"
  launchconfig_instance_type = "t2.micro"
  launchconfig_iam_user      = "skillup-malcedo-1b-IAM-S3ReadOnly"
  launchconfig_key_name      = "skillup-malcedo"

  #Auto Scaling Group details
  asg_name                      = "skillup-malcedo-asg"
  asg_max_size                  = "2"
  asg_min_size                  = "2"
  asg_health_check_grace_period = "200"
  asg_health_check_type         = "ELB"
  asg_desired_capacity          = "2"

}

#Input WEB Server SG rule
webserver_sg_rule_http_80 = {
  from_port = "80"
  to_port   = "80"
  protocol  = "tcp"
}

webserver_sg_rule_ssh_6522 = {
  from_port = "6522"
  to_port   = "6522"
  protocol  = "tcp"
}

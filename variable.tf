variable "region" {
  type = string
}

#vpc variables
variable "vpc" {
  type = object({
    cidr_block               = string
    vpc_name                 = string
    igw_name                 = string
    public_av_zone           = list(string)
    private_av_zone          = list(string)
    db_av_zone               = list(string)
    public_cidr              = list(string)
    private_cidr             = list(string)
    db_cidr                  = list(string)
    subnet_public_name       = list(string)
    subnet_private_name      = list(string)
    subnet_db_name           = list(string)
    nat_name                 = string
    elastic_ip_allocation_id = string
    public_rt_name           = string
    private_rt_name          = string
    s3_endpoint_name         = string
  })
}

#bastion variable
variable "bastion" {
  type = object({
    bastion_sg_name        = string
    bastion_sg_description = string
    bastion_name           = string
    ami_id                 = string
    ec2_instance_type      = string
    ec2_az                 = string
    key_name               = string
    iam_user               = string
  })
}

variable "bastion_sg_rule_tcp_6522" {
  type = object({
    from_port     = string
    to_port       = string
    protocol_type = string
    inbound_ip    = list(string)
  })
}

#alb variable
variable "alb" {
  type = object({
    alb_sg_name            = string
    alb_sg_description     = string
    alb_name               = string
    alb_type               = string
    tg_name                = string
    target_type            = string
    tg_port                = string
    tg_protocol            = string
    hc_path                = string
    hc_port                = string
    hc_protocol            = string
    hc_timeout             = string
    hc_healthy_threshold   = string
    hc_unhealthy_threshold = string
    hc_interval            = string
    hc_matcher             = string
    listener_port          = string
    listener_protocol      = string
    listener_type          = string
  })
}

#asgvariable
variable "alb_sg_rule_tcp_80" {
  type = object({
    from_port     = string
    to_port       = string
    protocol_type = string
    inbound_ip    = list(string)
  })
}

variable "asg" {
  type = object({
    asg_sg_name                   = string
    asg_sg_description            = string
    launchconfig_name             = string
    launchconfig_ami_id           = string
    launchconfig_instance_type    = string
    launchconfig_iam_user         = string
    launchconfig_key_name         = string
    asg_name                      = string
    asg_max_size                  = string
    asg_min_size                  = string
    asg_health_check_grace_period = string
    asg_health_check_type         = string
    asg_desired_capacity          = string
  })
}

variable "webserver_sg_rule_http_80" {
  type = object({
    from_port = string
    to_port   = string
    protocol  = string
  })
}

variable "webserver_sg_rule_ssh_6522" {
  type = object({
    from_port = string
    to_port   = string
    protocol  = string
  })
}

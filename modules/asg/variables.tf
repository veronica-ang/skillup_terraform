variable "asg" {
  type = object({
  asg_sg_name = string
  asg_sg_description = string
  launchconfig_name = string
  launchconfig_ami_id = string
  launchconfig_instance_type = string
  launchconfig_iam_user = string
  launchconfig_key_name = string
  asg_name  = string
  asg_max_size  = string
  asg_min_size  = string
  asg_health_check_grace_period  = string
  asg_health_check_type  = string
  asg_desired_capacity  = string
  })
}


variable "vpc_id_all" {
 type = string
}

variable "alb_sg_id_all" {
 type = string
}

variable "bastion_sg_id_all" {
 type = string
}

variable "all_private_subnet" {
 type= list(string)
}

variable "target_group_arns" {
 type= string
}


variable "skillup_required_tags" {
  description = "Skillup required tags"
  type        = map(string)
  default = {
    "GBL_CLASS_0" = "SERVICE"
    "GBL_CLASS_1" = "TEST"
  }
}

variable "webserver_http_rule" {
  type = object({
  from_port = string
  to_port = string
  protocol = string
  })
}

variable "webserver_ssh_rule" {
  type = object({
  from_port = string
  to_port = string
  protocol = string
  })
}

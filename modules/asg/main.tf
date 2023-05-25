resource "aws_security_group" "create_webserver_sg" {

  name        = var.asg.asg_sg_name
  description = var.asg.asg_sg_description
  vpc_id      = var.vpc_id_all

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.skillup_required_tags, {
    Name = var.asg.asg_sg_name
    }
  )
}

#security group web server rule
resource "aws_security_group_rule" "create_webserver_rule_http" {
  type                     = "ingress"
  from_port                = var.webserver_http_rule.from_port
  to_port                  = var.webserver_http_rule.to_port
  protocol                 = var.webserver_http_rule.protocol
  source_security_group_id = var.alb_sg_id_all
  security_group_id        = aws_security_group.create_webserver_sg.id
}

resource "aws_security_group_rule" "create_webserver_rule_ssh" {
  type                     = "ingress"
  from_port                = var.webserver_ssh_rule.from_port
  to_port                  = var.webserver_ssh_rule.to_port
  protocol                 = var.webserver_ssh_rule.protocol
  source_security_group_id = var.bastion_sg_id_all
  security_group_id        = aws_security_group.create_webserver_sg.id
}


#launch configuration
resource "aws_launch_configuration" "create_launchconfig" {
  name                        = var.asg.launchconfig_name
  image_id                    = var.asg.launchconfig_ami_id
  instance_type               = var.asg.launchconfig_instance_type
  iam_instance_profile        = var.asg.launchconfig_iam_user
  key_name                    = var.asg.launchconfig_key_name
  associate_public_ip_address = false
  security_groups             = [aws_security_group.create_webserver_sg.id]
  user_data                   = file("./modules/asg/userdata.tpl")
}

#auto scaling group
resource "aws_autoscaling_group" "create_asg" {
  name                      = var.asg.asg_name
  max_size                  = var.asg.asg_max_size
  min_size                  = var.asg.asg_min_size
  health_check_grace_period = var.asg.asg_health_check_grace_period
  health_check_type         = var.asg.asg_health_check_type
  desired_capacity          = var.asg.asg_desired_capacity 
  force_delete              = true
  target_group_arns         = [var.target_group_arns]
  launch_configuration      = aws_launch_configuration.create_launchconfig.name
  vpc_zone_identifier       = var.all_private_subnet

  tag {
    key                 = "Name"
    value               = var.asg.asg_name
    propagate_at_launch = true
  }

  }


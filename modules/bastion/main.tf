#bastion security group
resource "aws_security_group" "create_bastion_sg" {

  name        = var.bastion.bastion_sg_name
  description = var.bastion.bastion_sg_description
  vpc_id      = var.vpc_id_all

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.skillup_required_tags, {
    Name = var.bastion.bastion_sg_name
    }
  )
}

#sg inbound rule
resource "aws_security_group_rule" "create_sg_rule" {
  count             = "${length(var.sg_rule.inbound_ip)}"
  type              = "ingress"
  from_port         = var.sg_rule.from_port
  to_port           = var.sg_rule.to_port
  protocol          = var.sg_rule.protocol_type
  cidr_blocks       = var.sg_rule.inbound_ip
  security_group_id = aws_security_group.create_bastion_sg.id
}

#ec2 bastion instance
resource "aws_instance" "create_ec2_bastion" {
  ami                         = var.bastion.ami_id
  subnet_id                   = var.subnet_id_all
  instance_type               = var.bastion.ec2_instance_type
  availability_zone           = var.bastion.ec2_az
  associate_public_ip_address = true
  key_name                    = var.bastion.key_name
  vpc_security_group_ids      = [aws_security_group.create_bastion_sg.id]
  iam_instance_profile        = var.bastion.iam_user
  user_data                   = file("./modules/bastion/userdata.tpl")


  tags = merge(var.skillup_required_tags, {
    Name = var.bastion.bastion_name
    }
  )
}

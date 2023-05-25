output "alb_sg_id" {
value = aws_security_group.create_alb_sg.id
}

output "tg_arns" {
value = aws_lb_target_group.create_tg.arn
}

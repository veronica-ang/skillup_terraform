output "vpc_id" {
value = aws_vpc.create_vpc.id
}

output "subnet_id_all" {
value = aws_subnet.create_public_sub[1].id
}

output "all_public_subnet" {
value = aws_subnet.create_public_sub[*].id
}

output "all_private_subnet" {
value = aws_subnet.create_private_sub[*].id
}

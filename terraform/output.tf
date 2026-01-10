# output "alb_dns" {
#   value = aws_lb.web.dns_name
# }

output "web-server_ip" {
  value = aws_instance.web-server.public_ip
}

output "backend-server_ip" {
  value = aws_instance.backend-server.private_ip
}

output "db_ip" {
  value = aws_instance.db.private_ip
}
output "vpc_id" {
  value = aws_vpc.grace.id
}
output "public_subnet_id" {
  value = aws_subnet.public.id
}
output "private_subnet_id" {
  value = aws_subnet.private.id
}
output "security_group_web_id" {
  value = aws_security_group.web.id
}
output "security_group_backend_id" {
  value = aws_security_group.backend.id
}
output "security_group_db_id" {
  value = aws_security_group.db.id
}

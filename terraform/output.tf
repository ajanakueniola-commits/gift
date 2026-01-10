# outputs.tf

output "web_server_ips" {
  value = [aws_instance.web.public_ip]
}

output "backend_server_ips" {
  value = [aws_instance.backend.public_ip]
}

output "db_server_ips" {
  value = [aws_instance.db.private_ip]
}

# Remove or comment out ALB outputs if no ALB is created
# output "alb_dns" {
#   value = aws_lb.web.dns_name
# }

# outputs.tf

output "web_server_ips" {
  value = [aws_instance.web.public_ip]
}

# output "backend_server_ips" {
#   value = [aws_instance.backend.public_ip]
# }

output "db_server_ips" {
  value = [aws_instance.postgres.private_ip]
}

output "backend_public_ips" {
  value = aws_instance.backend[*].public_ip
}
output "rds_endpoint" {
  value = aws_db_instance.postgres.endpoint
}
output "postgres_server_ips" {
  value = [aws_instance.postgres.public_ip]
}




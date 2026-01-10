output "alb_dns" {
  value = aws_lb.web.dns_name
}

output "web_ip" {
  value = aws_instance.web.public_ip
}

output "app_ip" {
  value = aws_instance.app.private_ip
}

output "db_ip" {
  value = aws_instance.db.private_ip
}

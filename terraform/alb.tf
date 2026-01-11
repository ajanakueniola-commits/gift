# resource "aws_lb" "web" {
#   name               = "grace-web-alb"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = [aws_security_group.web.id]
#   subnets            = [aws_subnet.public.id]
# }

# resource "aws_lb_target_group" "web" {
#   name     = "grace-web-tg"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = aws_vpc.grace.id
# }

# resource "aws_lb_target_group_attachment" "web" {
#   target_group_arn = aws_lb_target_group.web.arn
#   target_id        = aws_instance.web.id
#   port             = 80
# }

# resource "aws_lb_listener" "web" {
#   load_balancer_arn = aws_lb.web.arn
#   port              = 80
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.web.arn
#   }
# }

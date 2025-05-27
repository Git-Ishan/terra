resource "aws_lb" "web" {
  name               = "web-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.web_sg]
  subnets            = var.public_subnets
  tags               = var.tags
}
resource "aws_lb" "app" {
  name               = "app-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [var.app_sg]
  subnets            = var.private_subnets
  tags               = var.tags
}

resource "aws_lb_listener" "web_http" {
  load_balancer_arn = aws_lb.web.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = var.web_target_arn
  }
}

resource "aws_lb_listener" "web_https" {
  count             = var.enable_https ? 1 : 0
  load_balancer_arn = aws_lb.web.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = var.web_target_arn
  }
}

resource "aws_lb_listener" "app_http" {
  load_balancer_arn = aws_lb.app.arn
  port              = var.app_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = var.app_target_arn
  }
}

resource "aws_lb_listener" "app_https" {
  count             = var.enable_https ? 1 : 0
  load_balancer_arn = aws_lb.app.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = var.app_target_arn
  }
}

resource "aws_lb_listener_rule" "web_http_rule" {
  listener_arn = aws_lb_listener.web_http.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = var.web_target_arn
  }

  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}

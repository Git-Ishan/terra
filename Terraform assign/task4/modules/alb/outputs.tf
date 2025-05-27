output "web_alb_dns_name" {
  value       = aws_lb.web.dns_name
}

output "app_alb_dns_name" {
  value       = aws_lb.app.dns_name
}

output "web_alb_arn" {
  value       = aws_lb.web.arn
}

output "app_alb_arn" {
  value       = aws_lb.app.arn
}

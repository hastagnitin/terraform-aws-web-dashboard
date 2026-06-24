output "web_server_url" {
  description = "Click this URL to access your website live"
  value       = "http://${aws_instance.web_server.public_ip}"
}
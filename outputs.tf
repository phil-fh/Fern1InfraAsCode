output "your-url" {
  value = "http://${aws_instance.FooService-front.public_ip}:8080"
}
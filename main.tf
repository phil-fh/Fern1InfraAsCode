# Data Source for getting Amazon Linux AMI
data "aws_ami" "amazon-2" {
  most_recent = true
  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
  owners = ["amazon"]
}

resource "aws_security_group" "ingress-all-http" {
  name = "allow-all-http"
  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
  }
  // Terraform removes the default rule
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ingress-all-3000" {
  name = "allow-all-3000"
  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 3000
    to_port = 3000
    protocol = "tcp"
  }
  // Terraform removes the default rule
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
# Resource for FooService-left
resource "aws_instance" "FooService-left" {
  ami = data.aws_ami.amazon-2.id
  instance_type = "t3.micro"
  user_data = templatefile("${path.module}/templates/init_node.tpl", { container_image = "phil4fh/leftservice", container_version = var.container_version} )
  vpc_security_group_ids = [aws_security_group.ingress-all-3000.id]
  tags = {
    Name = "FooService-left"
  }
}

# Resource for FooService-right
resource "aws_instance" "FooService-right" {
  ami = data.aws_ami.amazon-2.id
  instance_type = "t3.micro"
  user_data = templatefile("${path.module}/templates/init_node.tpl", { container_image = "phil4fh/rightservice", container_version = var.container_version} )
  vpc_security_group_ids = [aws_security_group.ingress-all-3000.id]
  tags = {
    Name = "FooService-right"
  }
}

# Resource for FooService-front
resource "aws_instance" "FooService-front" {
  ami = data.aws_ami.amazon-2.id
  instance_type = "t3.micro"
  user_data = templatefile("${path.module}/templates/init_front.tpl", { container_image = "phil4fh/frontservice", container_version = var.container_version, left_host = aws_instance.FooService-left.private_ip, right_host = aws_instance.FooService-right.private_ip } )
  vpc_security_group_ids = [aws_security_group.ingress-all-http.id]
  tags = {
    Name = "FooService-front"
  }
}
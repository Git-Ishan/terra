resource "aws_instance" "instance1" {
  ami = var.ami_id
  instance_type = var.instance_type
  tags = var.tags
}
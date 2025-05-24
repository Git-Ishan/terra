resource "aws_instance" "ins1" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  associate_public_ip_address = var.associate_public_ip


  tags = {
    Name = var.instance_name
  }
}
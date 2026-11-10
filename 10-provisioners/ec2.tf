resource "aws_instance" "provisioners" {
  instance_type = "t3.micro"
  ami = "ami-0055977a6e828a4f4"
  vpc_security_group_ids = [aws_security_group.provisioners.id]

  provisioner "local-exec" {
    command = "echo ${self.private_ip} > inventory.ini"
  }

   provisioner "local-exec" {
    command = "echo Instance created"
  }

  provisioner "local-exec" {
    when = destroy
    command = "echo 'instance is going to be destroyed' "
  }

  connection {
    type = "ssh"
    user = "ec2-user"
    password = "DevOps321"
    host = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
        "sudo dnf install nginx -y",
        "sudo systemctl start nginx",
        "sudo systemctl enable nginx"
    ]
  }

  tags = {
    Name = "roboshop-provisioners"
  }
}

resource "aws_security_group" "provisioners" {
  name        = "provisioners"
  description = "Allow TLS inbound traffic and all outbound traffic"

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "roboshop-provisioners"
  }
}
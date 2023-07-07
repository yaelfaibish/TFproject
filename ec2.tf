resource "aws_instance" "ec2_demo" {
  ami               = "ami-024e6efaf93d85776"
  instance_type     = var.ec2_instance_type
  availability_zone = var.availability_zone.a
  subnet_id         = aws_subnet.main.id
  key_name          = local.key_name
  vpc_security_group_ids = [aws_security_group.main.id]

  tags = {
    Name = "Demo"
  }

  provisioner "remote-exec" {
    inline = ["echo 'Wait until SSH is ready'"]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = local_file.ssh_key.content
      host        = aws_instance.ec2_demo.public_ip
    }
  }

  provisioner "local-exec" {
    command = "ansible-playbook -i ${aws_instance.ec2_demo.public_ip}, --private-key ${local.private_key_path} jenkins.yaml"
  }

  depends_on = [aws_instance.ec2_demo]
}

output "public_ip" {
  value = aws_instance.ec2_demo.public_ip
}

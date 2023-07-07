locals {
  vpc_id = aws_vpc.main.id
  subnet_id = aws_subnet.main.id
  ssh_user = "ubuntu"
  key_name= aws_key_pair.generated_key.key_name
  private_key_path = "./yael-key.pem"
}

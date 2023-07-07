resource "aws_security_group" "main" {
  name        = "terraform-main"
  vpc_id      = aws_vpc.main.id
   depends_on = [
    aws_vpc.main
  ]

   ingress {

        description = "Allow Port 22"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }

      
      ingress {
     
        description = "Allow Port 8080"
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
       ingress {
     
        description = "Allow Port 80"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
      

      egress {
        description = "Allow all IP and Ports Outbound"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
}
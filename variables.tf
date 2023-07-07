variable "ec2_instance_type" {
  description = "The type of the instance"
  type        = string
  default     = "t2.micro"
}

variable "availability_zone" {
  description = "The  availability_zone i want to create ec2 for "
  type        = map(string)
  default = {
    a = "us-east-2a"
    b = "us-east-2b"
    c = "us-east-2c"
  }
}


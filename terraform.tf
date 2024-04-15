#data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name = "name"
    values = [ "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server*" ]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}

resource "aws_instance" "server_mse" {
  ami = data.aws_ami.ubuntu.id
  #ami ="" no
  instance_type = "t2.micro"
  vpc_security_group_ids = [ aws_security_group.mse_vpc.id ]
  key_name = "mse_keypair"

  tags = {
    name ="mse-server"
  }

}
output "public_ip" {
  value = aws_instance.server_mse.public_ip
}


resource "aws_security_group" "mse_vpc" {
  name = "VPC mse"
  description = "Allow inbound traffic"
  tags = {
    name = "Mse security group"
  }
  
}

# user_data = ec2.user_data cambios locos 

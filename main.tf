provider "aws" {
  region  =  var.aws_region
  profile =  var.aws_profile
}

resource "aws_instance" "linux-node" {
  private_ip             = "172.31.54.130"
  instance_type          = var.aws_instance_type
  ami                    = var.aws_ami_id
  key_name               = var.aws_key_pair_name
  subnet_id              = aws_subnet.apprentice_subnet_a.id
  vpc_security_group_ids = [aws_security_group.apprentice.id]
  ebs_optimized          = true
  associate_public_ip_address = true

  tags = {
      "Name" = "linux-node1"
  }
}

resource "null_resource" "configure-app" {
  depends_on = [aws_instance.linux-node]

  triggers = {
    build_number = timestamp()
  }

  provisioner "file" {
    source     = "files/nginx.tar.gz"
    destination = "/home/ec2-user/nginx.tar.gz"
  }

  provisioner "remote-exec" {
    inline = [
      "cd /home/ec2-user", 
      "tar -xzvf nginx.tar.gz",
      "cd nginx",
      "sudo ./install.sh"
    ]
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    #private_key = file(var.aws_key_pair_file)
    private_key = tls_private_key.apprentice.private_key_pem
    host        = aws_instance.linux-node.public_ip
  }
}


resource "tls_private_key" "apprentice" {
  algorithm = "RSA"
}

locals {
  private_key_filename = "${random_id.app-server-id.dec}-ssh-key.pem"
}

resource "aws_key_pair" "apprentice" {
  key_name   = local.private_key_filename
  public_key = tls_private_key.apprentice.public_key_openssh
}

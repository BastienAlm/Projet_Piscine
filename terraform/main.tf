
resource "aws_instance" "gotham_backend" {
  ami           = data.aws_ami.amzn-linux-2023-ami.id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  key_name = aws_key_pair.gotham_key.name

  vpc_security_group_ids = var.security_group_ids


  cpu_options {
    core_count       = 1
    threads_per_core = 1
  }

  user_data = <<EOF
 #!/bin/bash
sudo yum update -y
sudo yum install docker
sudo systemctl start docker
sudo usermod -a -G docker ec2-user
sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
EOF

  tags = {
    Name = "Gotham city api instance"
  }
}

resource "aws_key_pair" "gotham_key" {
  key_name   = "gotham_key"
  public_key = var.public_key
}
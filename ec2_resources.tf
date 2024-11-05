# Create EC2 Instances
resource "aws_instance" "web1" {
  ami           = "ami-005fc0f236362e99f"  # Ubuntu Server 20.04 LTS AMI ID for us-east-1
  instance_type = "t2.micro"
  key_name      = "demo" 
  availability_zone = "us-east-1a"
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  subnet_id     = aws_subnet.public_1.id
  associate_public_ip_address = true
  user_data     = data.template_file.user_data_instance_1.rendered

  tags = {
    Name = "web1_instance"
  }
}

resource "aws_instance" "web2" {
  ami           = "ami-005fc0f236362e99f"
  instance_type = "t2.micro"
  key_name      = "demo"
  availability_zone = "us-east-1b"
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  subnet_id = aws_subnet.public_2.id
  associate_public_ip_address = true
  user_data     = data.template_file.user_data_instance_2.rendered

  tags = {
    Name = "web2_instance"
  }
}

# User Data script to configure Nginx and HTML page on Instance 1
data "template_file" "user_data_instance_1" {
  template = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y nginx
              echo "<html><body><h1>Instance Number One</h1></body></html>" | sudo tee /var/www/html/index.html
              sudo systemctl restart nginx
              EOF
}

# User Data script to configure Nginx and HTML page on Instance 2
data "template_file" "user_data_instance_2" {
  template = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y nginx
              echo "<html><body><h1>Instance Number Two</h1></body></html>" | sudo tee /var/www/html/index.html
              sudo systemctl restart nginx
              EOF
}              
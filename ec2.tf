# ./ec2.tf

# EC2インスタンスを2つ作成
resource "aws_instance" "ec2_instance" {
  for_each = {
    "instance1" = {
      name = "${var.ec2_instance_name}-1"
      subnet_id = aws_subnet.public_subnets[0].id
    }
    "instance2" = {
      name = "${var.ec2_instance_name}-2"
      subnet_id = aws_subnet.public_subnets[1].id
    }
  }

  ami             = var.ec2_ami
  instance_type   = var.ec2_instance_type
  key_name        = var.ec2_key_pair
  subnet_id       = each.value.subnet_id
  security_groups = [aws_security_group.ec2_sg.id]
  
  associate_public_ip_address = true

  user_data = templatefile("${path.module}/scripts/wordpress_user_data.sh", {
    rds_db_name   = var.rds_db_name,
    rds_username  = var.rds_username,
    rds_password  = var.rds_password,
    rds_endpoint  = aws_db_instance.rds_instance.endpoint
  }) 

  tags = {
    Name = each.value.name
  }
}

# ./outputs.tf

#------------------------
# VPC
output "vpc_info" {
  value = {
    vpc_id              = aws_vpc.vpc03.id
    public_subnets_ids  = aws_subnet.public_subnets[*].id
    private_subnets_ids = aws_subnet.private_subnets[*].id
  }
}

#------------------------
# SecurityGroup
output "security_group_info" {
  value = {
    alb_sg = {
      id          = aws_security_group.alb_sg.id
      name        = aws_security_group.alb_sg.name
      description = aws_security_group.alb_sg.description
    }
    ec2_sg = {
      id          = aws_security_group.ec2_sg.id
      name        = aws_security_group.ec2_sg.name
      description = aws_security_group.ec2_sg.description
    }
    rds_sg = {
      id          = aws_security_group.rds_sg.id
      name        = aws_security_group.rds_sg.name
      description = aws_security_group.rds_sg.description
    }
  }
}


#------------------------
# ALB
output "alb_info" {
  value = {
    dns_name          = aws_lb.my_alb.dns_name
    alb_arn           = aws_lb.my_alb.arn
    target_group_arn  = aws_lb_target_group.my_target_group.arn
    listener_arn      = aws_lb_listener.my_listener.arn
    security_group_id = aws_security_group.alb_sg.id
  }
}

#------------------------
# EC2 Instance
output "ec2_instance_info" {
  value = {
    instance1 = {
      instance_id  = aws_instance.ec2_instance["instance1"].id
      public_ip    = aws_instance.ec2_instance["instance1"].public_ip
      private_ip   = aws_instance.ec2_instance["instance1"].private_ip
      public_dns   = aws_instance.ec2_instance["instance1"].public_dns
      subnet_id    = aws_instance.ec2_instance["instance1"].subnet_id
    }
    instance2 = {
      instance_id  = aws_instance.ec2_instance["instance2"].id
      public_ip    = aws_instance.ec2_instance["instance2"].public_ip
      private_ip   = aws_instance.ec2_instance["instance2"].private_ip
      public_dns   = aws_instance.ec2_instance["instance2"].public_dns
      subnet_id    = aws_instance.ec2_instance["instance2"].subnet_id
    }
  }
}

#------------------------
# RDS Instance
output "rds_info" {
  value = {
    db_instance_identifier  = aws_db_instance.rds_instance.id
    db_instance_endpoint    = aws_db_instance.rds_instance.endpoint
    db_instance_port        = aws_db_instance.rds_instance.port
    db_name                 = aws_db_instance.rds_instance.db_name
    multi_az                = aws_db_instance.rds_instance.multi_az
    # Primary AZ:
    availability_zones      = aws_db_instance.rds_instance.availability_zone
  }
}

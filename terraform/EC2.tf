resource "aws_security_group" "Ec2_Security_Group" {
    name        = "Ec2_Security_Group"
    description = "Ec2 Security_Group"
    vpc_id      = aws_vpc.prod_VPC.id
    egress {
        description = "All to All"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "TCP/22 from All"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "TCP/80 from All"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "TCP/2377 from swarm network"
        from_port   = 2377
        to_port     = 2377
        protocol    = "tcp"
        cidr_blocks = [aws_subnet.Prod_Public_Subnet.cidr_block]
    }
    ingress {
        description = "UDP/4789 from swarm network"
        from_port   = 4789
        to_port     = 4789
        protocol    = "udp"
        cidr_blocks = [aws_subnet.Prod_Public_Subnet.cidr_block]
    }
    ingress {
        description = "UDP/7946 from swarm network"
        from_port   = 7946
        to_port     = 7946
        protocol    = "udp"
        cidr_blocks = [aws_subnet.Prod_Public_Subnet.cidr_block]
    }
    ingress {
        description = "TCP/7946 from swarm network"
        from_port   = 7946
        to_port     = 7946
        protocol    = "tcp"
        cidr_blocks = [aws_subnet.Prod_Public_Subnet.cidr_block]
    }
    ingress {
        description = "TCP/9000 from Portainer"
        from_port   = 9000
        to_port     = 9000
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "Work Security Group"
    }
}

data "template_file" "user_data" {
    template = "${file("./scripts/user_data.sh")}"
}

resource "aws_instance" "manager" {
    ami                    = "ami-084568db4383264d4"
    instance_type          = "t2.micro"
    key_name                = aws_key_pair.key_pair.key_name
    subnet_id              = aws_subnet.Prod_Public_Subnet.id
    vpc_security_group_ids = [aws_security_group.Ec2_Security_Group.id]
    user_data              = "${base64encode(data.template_file.user_data.rendered)}"
    tags = {
        Name = "manager"
    }
}

resource "aws_instance" "worker1" {
    ami                    = "ami-084568db4383264d4"
    instance_type          = "t2.micro"
    key_name                = aws_key_pair.key_pair.key_name
    subnet_id              = aws_subnet.Prod_Public_Subnet.id
    vpc_security_group_ids = [aws_security_group.Ec2_Security_Group.id]
    user_data              = "${base64encode(data.template_file.user_data.rendered)}"
    tags = {
        Name = "worker 1"
    }
}

resource "aws_instance" "worker2" {
    ami                    = "ami-084568db4383264d4"
    instance_type          = "t2.micro"
    key_name                = aws_key_pair.key_pair.key_name
    subnet_id              = aws_subnet.Prod_Public_Subnet.id
    vpc_security_group_ids = [aws_security_group.Ec2_Security_Group.id]
    user_data              = "${base64encode(data.template_file.user_data.rendered)}"
    tags = {
        Name = "worker 2"
    }
}
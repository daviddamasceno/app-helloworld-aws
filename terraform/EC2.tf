resource "aws_security_group" "Hello_Security_Group" {
    name        = "Hello_Security_Group"
    description = "Hello Security Group"
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
    tags = {
        Name = "Work Security Group"
    }
}

data "template_file" "user_data" {
    template = "${file("./scripts/user_data.sh")}"
}

resource "aws_instance" "hello-instance" {
    ami                    = "ami-084568db4383264d4"
    instance_type          = "t2.micro"
    key_name                = aws_key_pair.key_pair.key_name
    subnet_id              = aws_subnet.Prod_Public_Subnet.id
    vpc_security_group_ids = [aws_security_group.Hello_Security_Group.id]
    user_data              = "${base64encode(data.template_file.user_data.rendered)}"
    tags = {
        Name = "hello-instance"
    }
}


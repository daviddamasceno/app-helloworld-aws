resource "aws_subnet" "Prod_Public_Subnet" {
    vpc_id                  = aws_vpc.prod_VPC.id
    cidr_block              = "10.0.0.0/24"
    map_public_ip_on_launch = "true"
    availability_zone       = "us-east-1a"
    tags = {
        Name = "Prod Public Subnet"
    }
}
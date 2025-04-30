resource "aws_internet_gateway" "Prod_IGW" {
    vpc_id = aws_vpc.prod_VPC.id
    tags = {
        Name = "Prod IGW"
    }
}
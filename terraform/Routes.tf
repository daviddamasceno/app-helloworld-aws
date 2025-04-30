resource "aws_route_table" "Prod_Public_Route_Table" {
    vpc_id = aws_vpc.prod_VPC.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.Prod_IGW.id
    }
    tags = {
        Name = "Prod Public Route Table"
    }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.Prod_Public_Subnet.id
  route_table_id = aws_route_table.Prod_Public_Route_Table.id
}
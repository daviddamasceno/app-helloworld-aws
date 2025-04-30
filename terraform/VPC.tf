resource "aws_vpc" "prod_VPC" {
    cidr_block           = "10.0.0.0/16"
    
    enable_dns_support   = true
    enable_dns_hostnames = true
    
    tags = {
        Name = "prod_VPC"  
    }
}

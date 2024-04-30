provider "aws" {
region = "eu-north-1"
}

resource "aws_vpc" "lokeshvpc-1" {
cidr_block = "10.0.0.0/16"
tags = {
Name = "lokesh-vpc"
}
}

resource "aws_subnet" "lokesh-sub1" {
vpc_id = aws_vpc.lokeshvpc-1.id
cidr_block = "10.0.0.0/24"
tags = {
Name = "public-1"
}
}

resource "aws_subnet" "lokesh-sub2" { 
vpc_id = aws_vpc.lokeshvpc-1.id
cidr_block = "10.0.1.0/24"
tags = {
Name = "private-1"
}
}

resource "aws_subnet" "lokesh-sub2" { 
vpc_id = aws_vpc.lokeshvpc-1.id
cidr_block = "10.0.1.0/24"
tags = {
Name = "private-1"
}
}
resource "aws_subnet" "lokesh-sub2" { 
vpc_id = aws_vpc.lokeshvpc-1.id
cidr_block = "10.0.1.0/24"
tags = {
Name = "private-1"
}
}

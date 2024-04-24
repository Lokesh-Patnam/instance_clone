provider "aws" {
region = "eu-north-1"
}

resource "aws_vpc" "lokeshvpc-2" {
cidr_block = "10.0.0.0/16"
tags = {
Name = "lokesh-vpc"
}
}

resource "aws_subnet" "lokesh-sub1" {
vpc_id = aws_vpc.lokeshvpc-2.id
cidr_block = "10.0.0.0/24"
tags = {
Name = "public-1"
}
}

resource "aws_subnet" "lokesh-sub2" {
vpc_id = aws_vpc.lokeshvpc-2.id
cidr_block = "10.0.1.0/24"
tags = {
Name = "private-1"
}

}

resource "aws_internet_gateway" "gw" {
vpc_id = aws_vpc.lokeshvpc-2.id
tags = {
Name = "internet_gateway-1"
}
}

resource "aws_route_table" "route-1" {
vpc_id = aws_vpc.lokeshvpc-2.id
route {
cidr_block = "0.0.0.0/0"
gateway_id = aws_internet_gateway.gw.id
}
tags = {
Name = "public-route"
}
}


resource "aws_route_table" "route-2" {
vpc_id = aws_vpc.lokeshvpc-2.id
route {
cidr_block = "0.0.0.0/0"
nat_gateway_id = aws_nat_gateway.nat_gateway-1.id
}
tags = {
Name = "private-route"
}
}

resource "aws_route_table_association" "ass-1" {
subnet_id = aws_subnet.lokesh-sub1.id
route_table_id = aws_route_table.route-1.id
}

resource "aws_route_table_association" "ass-2" {
subnet_id = aws_subnet.lokesh-sub2.id
route_table_id = aws_route_table.route-2.id
}

resource "aws_eip" "nat_eip" {
depends_on = [aws_internet_gateway.gw]
tags = {
Name = "Nat gateway EIP"
}
}

resource "aws_nat_gateway" "nat_gateway-1" {
allocation_id = aws_eip.nat_eip.id
subnet_id = aws_subnet.lokesh-sub1.id
tags = {
Name = "NAT 1"
}
depends_on = [aws_internet_gateway.gw]
}


resource "aws_security_group" "security_group" {
vpc_id = aws_vpc.lokeshvpc-2.id
name   = "security_group1"

ingress {
protocol    = "tcp"
cidr_blocks = ["0.0.0.0/0"]
from_port   = 22
to_port     = 22
}

tags = {
Name = "sg-1"
}
}


resource "aws_instance" "instance" {
ami           = "ami-0684f3b195c7387ad"
instance_type = "t3.micro"
subnet_id     = aws_subnet.lokesh-sub1.id
count         = 2
tags  = {
Name  = "Lokesh"
}
}


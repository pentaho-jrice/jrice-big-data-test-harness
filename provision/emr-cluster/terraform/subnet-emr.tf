# ---------------------------------------------------------------------------
# EMR Subnets
#  - public subnets
#  - route table for subnets
#  - route table associations to all public subnets
# ---------------------------------------------------------------------------
resource "aws_subnet" "az-1-public" {
	vpc_id = "${aws_vpc.bdth_emr_vpc.id}"

	cidr_block = "10.0.0.0/24"
	availability_zone = "${lookup(var.availability_zone, "${var.region}.az-1")}"
	map_public_ip_on_launch = "true"

	tags {
        Name = "bdth-emr.${var.environment}.subnet.${lookup(var.availability_zone, "${var.region}.az-1")}-public",
        bdth.environment = "${var.environment}",
        bdth.environment-instance-id = "${random_id.env-instance.b64}"
    	bdth.failure-zone = "${var.region}-az-1"
    }
}


# Associate public subnets to Internet Gateway routing table

resource "aws_route_table_association" "az-1-public" {
	subnet_id = "${aws_subnet.az-1-public.id}"
	route_table_id = "${aws_route_table.public.id}"
}


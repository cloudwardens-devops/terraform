data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

#standard cluster buildout

resource "aws_instance" "splunk1" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
  root_block_device {
    
    volume_type ="standard"
    volume_size ="30"
}

  tags {
    SPN = "SplunkNode1"
    Name = "Liscense Master"

  }
}

resource "aws_instance" "splunk2" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"

  tags {
    SPN = "SplunkNode2"
    Name = "Search Head"
  }
}

resource "aws_instance" "splunk3" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"

  tags {
    Name = "Indexer One"
  }
}

resource "aws_instance" "splunk4" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"

  tags {
    Name = "Indexer Two"
  }
}

resource "aws_instance" "splunk5" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"

  tags {
    Name = "Heavy Forwarder"
  }
}

// resource "aws_security_group" "license_master_SG" {
//   name        = "license_master_SG"
//   description = "Allow TLS inbound traffic"
//   vpc_id      = "${aws_vpc.main.id}"

//   ingress {
//     # TLS (change to whatever ports you need)
//     from_port   = 443
//     to_port     = 443
//     protocol    = "-1"
//     # Please restrict your ingress to only necessary IPs and ports.
//     # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
//     cidr_blocks = # add a CIDR block here
//   }

//   egress {
//     from_port       = 0
//     to_port         = 0
//     protocol        = "-1"
//     cidr_blocks     = ["0.0.0.0/0"]
//     prefix_list_ids = ["pl-12c4e678"]
//   }
// }
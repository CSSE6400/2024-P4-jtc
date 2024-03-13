terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 5.0"
        }
    }
}

provider "aws" {
    region = "us-east-1"
    shared_credentials_files = ["./credentials"]
    default_tags {
        tags = {
            Environment = "Dev"
            Course = "CSSE6400"
            StudentID = "44791405"
        }
    }
}

resource "aws_instance" "hextris-server" {
    ami = "ami-0e731c8a588258d0d"
    instance_type = "t2.micro"
    key_name = "vockey"

    tags = {
        Name = "hextris"
    }

    user_data = file("./serve-hextris.sh")
}

output "hextris-url" {
    value = aws_instance.hextris-server.public_ip
}

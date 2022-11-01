
locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

source "amazon-ebs" "Linux" {
  ami_name      = "packer${local.timestamp}"
  instance_type = "t2.micro"
  region        = "ap-south-1"
  source_ami    = "ami-01216e7612243e0ef"
  ssh_username  = "ec2-user"
}

build {
  sources = ["source.amazon-ebs.Linux"]
}

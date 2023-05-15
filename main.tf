provider "aws" {
  region = "us-east-1" 
}
resource "aws_instance" "example" {
  ami           = "ami-0889a44b331db0194" 
  instance_type = "t2.micro" 
  key_name      = "mykey"
}
variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "instance_id" {
  type    = string
  default = ""
}
resource "null_resource" "destroy" {
  provisioner "local-exec" {
    command = "terraform destroy -auto-approve -var aws_region=${var.aws_region} -var instance_id=${var.instance_id}"
  }
  depends_on = [aws_instance.example]
}

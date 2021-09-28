////////////////////////////////
// AWS Connection

////////////////////////////////
// AWS

variable "aws_region" { default = "us-west-1" }
variable "aws_profile" { default = "yentio" }
variable "aws_key_pair_name" { default = "yentio-northcal1" }
variable "aws_key_pair_file" { default = "~/.ssh/yentio-northcal1.pem" }

variable "aws_ami_id"   { default = "ami-0930799ecc6029c1c"}
variable "ami_name"     { default = "RHEL-7.7_HVM_GA-*" } # Base RHEL name
variable "ami_owner"    { default = "309956199498" } # Base RHEL owner


////////////////////////////////
// Nodes

variable "aws_instance_type" { default = "t3.micro" }
variable "v_ipaddress" { }
variable "v_hostname" {  }


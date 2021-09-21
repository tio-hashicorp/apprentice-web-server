output "linux_node_ip" {
  value = "http://${aws_instance.linux-node.public_ip}"
}


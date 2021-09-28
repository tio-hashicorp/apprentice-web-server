output "linux_node_ip" {
  value = "http://${aws_instance.linux-node.public_ip}"
}
output "linux_node_ip1" {
  value = "http://${aws_instance.linux-node.private_ip}"
}
output "linux_node_ip2" {
  value = "${aws_instance.linux-node.metadata_options}"
}
output "linux_node_ip3" {
  value = "${aws_instance.linux-node.root_block_device}"
}


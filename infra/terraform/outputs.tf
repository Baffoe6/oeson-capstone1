output "jenkins_public_ip" {
  value = aws_instance.jenkins_host.public_ip
}

output "k8s_node_1_ip" {
  value = aws_instance.k8s_node_1.public_ip
}

output "k8s_node_2_ip" {
  value = aws_instance.k8s_node_2.public_ip
}

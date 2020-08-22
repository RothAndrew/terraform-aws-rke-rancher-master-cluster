data "template_file" "cloud_config" {
  template = <<EOF
#cloud-config
runcmd:
  - apt-get update
  - apt-get install -y apt-transport-https jq software-properties-common
  - curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  - add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
  - apt-get update
  - apt-get -y install docker-ce docker-ce-cli containerd.io
  - usermod -G docker -a ubuntu
  - echo '{"log-driver":"json-file","log-opts":{"max-size":"10m","max-file":"6"}}' | jq . > /etc/docker/daemon.json
  - systemctl restart docker && systemctl enable docker
EOF
}

resource "aws_instance" "node_group_1" {
  count                       = local.node_group_1_count
  ami                         = local.node_group_1_ami
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.ssh.id
  user_data                   = data.template_file.cloud_config.rendered
  vpc_security_group_ids      = [aws_security_group.nodes.id]
  subnet_id                   = var.node_group_1_subnet_id
  associate_public_ip_address = true #tfsec:ignore:AWS012
  ebs_optimized               = true
  root_block_device {
    volume_type = "gp2"
    volume_size = var.node_volume_size
  }
  tags = merge(module.label.tags,
    {
      "Name" = "${module.label.id}-1.${count.index}"
  })
  provisioner "remote-exec" {
    inline = [
      "cloud-init status --wait"
    ]
  }
}

resource "aws_instance" "node_group_2" {
  count                       = local.node_group_2_count
  ami                         = local.node_group_2_ami
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.ssh.id
  user_data                   = data.template_file.cloud_config.rendered
  vpc_security_group_ids      = [aws_security_group.nodes.id]
  subnet_id                   = var.node_group_2_subnet_id
  associate_public_ip_address = true #tfsec:ignore:AWS012
  ebs_optimized               = true
  root_block_device {
    volume_type = "gp2"
    volume_size = var.node_volume_size
  }
  tags = merge(module.label.tags,
    {
      "Name" = "${module.label.id}-2.${count.index}"
  })
  provisioner "remote-exec" {
    inline = [
      "cloud-init status --wait"
    ]
  }
}

resource "aws_instance" "node_group_3" {
  count                       = local.node_group_3_count
  ami                         = local.node_group_3_ami
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.ssh.id
  user_data                   = data.template_file.cloud_config.rendered
  vpc_security_group_ids      = [aws_security_group.nodes.id]
  subnet_id                   = var.node_group_3_subnet_id
  associate_public_ip_address = true #tfsec:ignore:AWS012
  ebs_optimized               = true
  root_block_device {
    volume_type = "gp2"
    volume_size = var.node_volume_size
  }
  tags = merge(module.label.tags,
    {
      "Name" = "${module.label.id}-3.${count.index}"
  })
  provisioner "remote-exec" {
    inline = [
      "cloud-init status --wait"
    ]
  }
}

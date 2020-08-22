resource "aws_elb" "ingress" { #tfsec:ignore:AWS005
  name_prefix     = module.label.id
  subnets         = distinct([var.node_group_1_subnet_id, var.node_group_2_subnet_id, var.node_group_3_subnet_id])
  security_groups = [aws_security_group.ingress_elb.id]
  listener {
    instance_port     = 80
    instance_protocol = "tcp"
    lb_port           = 80
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 443
    instance_protocol = "tcp"
    lb_port           = 443
    lb_protocol       = "tcp"
  }
  health_check {
    healthy_threshold   = 2
    interval            = 5
    target              = "HTTP:80/healthz"
    timeout             = 2
    unhealthy_threshold = 2
  }
  instances    = [aws_instance.node_group_1.*.id, aws_instance.node_group_2.*.id, aws_instance.node_group_3.*.id]
  idle_timeout = 1800
}

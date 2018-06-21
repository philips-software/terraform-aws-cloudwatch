resource "aws_cloudwatch_log_group" "log_group" {
  count = "${var.create_log_group ? 1 : 0}"

  name = "${var.environment}-${var.name_suffix}"

  tags = "${merge(map("Name", format("%s", "${var.name_suffix}")),
              map("Environment", format("%s", var.environment)),
              var.tags)}"
}

data "template_file" "cloudinit_ec2_part" {
  template = "${file("${path.module}/ec2/user_data_ec2.tpl")}"

  vars {
    log_group_name = "${var.environment}-${var.name_suffix}"
  }
}

data "template_file" "cloudinit_ecs_part" {
  template = "${file("${path.module}/ecs/user_data_ecs.tpl")}"

  vars {
    log_group_name = "${var.environment}-${var.name_suffix}"
  }
}

data "template_file" "cloudinit_ecs_upstart_part" {
  template = "${file("${path.module}/ecs/user_data_ecs_upstart.tpl")}"
}

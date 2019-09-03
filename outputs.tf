output "amazon_linux_cloudinit_ecs_part" {
  description = "Cloud init part to install awslogs and configure logging for ECS."

  value = {
    content_type = "text/x-shellscript"
    content      = data.template_file.cloudinit_ecs_part.rendered
  }
}

output "amazon_linux_cloudinit_ecs_upstart_part" {
  description = "Cloud init part to update the upstart job to be aware of the ECS cluster."

  value = {
    content_type = "text/upstart-job"
    content      = data.template_file.cloudinit_ecs_upstart_part.rendered
  }
}

output "amazon_linux_cloudinit_ec2_part" {
  description = "Cloud init part to install awslogs and configure logging for EC2."

  value = {
    content_type = "text/x-shellscript"
    content      = data.template_file.cloudinit_ec2_part.rendered
  }
}

output "log_group_name" {
  description = "Name of the created log group. If not created an empty string is returned."
  value       = element(concat(aws_cloudwatch_log_group.log_group.*.name, [""]), 0)
}

output "log_group_arn" {
  description = "Arn of the created log group. If not created an empty string is returned."
  value       = element(concat(aws_cloudwatch_log_group.log_group.*.arn, [""]), 0)
}


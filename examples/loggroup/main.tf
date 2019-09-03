module "cloudwatch" {
  source = "../../"

  environment = "forest-test"
  name_suffix = "ecs"

  #optional
  create_log_group = true

  tags = {
    Project = "test"
  }
}

data "template_cloudinit_config" "config" {
  gzip          = false # set to false for testing purpuse
  base64_encode = false # set to false for testing purpuse

  part {
    content_type = module.cloudwatch.amazon_linux_cloudinit_ecs_part["content_type"]
    content      = module.cloudwatch.amazon_linux_cloudinit_ecs_part["content"]
  }

  part {
    content_type = module.cloudwatch.amazon_linux_cloudinit_ecs_upstart_part["content_type"]
    content      = module.cloudwatch.amazon_linux_cloudinit_ecs_upstart_part["content"]
  }
}

output "template" {
  description = "Log config user_data template"

  value = data.template_cloudinit_config.config.rendered
}


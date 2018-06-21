# Terraform module for creating CloudWatch logging templates.

This module creates optional a log_group and for that log_group cloud init scripts.

## Usage

### Example usages
```

module "cloudwatch" {
  source = "git::https://gitlab.ta.philips.com/forest.terraform/terraform-aws-cloudwatch.git"

  source = "philips-software/cloudwatch/aws"
  version = "1.0.0"

  # Or via github
  # source = "github.com/philips-software/terraform-aws-cloudwatch?ref=1.0.0"

  environment = "${var.environment}"
  name_suffix = "ecs"

  #optional
  create_log_group = true
}

# Assemble cloud init config.
data "template_cloudinit_config" "config" {

  part {
    content_type = "${module.cloudwatch.amazon_linux_cloudinit_ecs_part["content_type"]}"
    content      = "${module.cloudwatch.amazon_linux_cloudinit_ecs_part["content"]}"
  }

  part {
    content_type = "${module.cloudwatch.amazon_linux_cloudinit_ecs_upstart_part["content_type"]}"
    content      = "${module.cloudwatch.amazon_linux_cloudinit_ecs_upstart_part["content"]}"
  }

  ... some other parts ...
  part {
    ...
  }
  ... some other parts ...

}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| create_log_group | Indicates if the log group needs to be created by the module. | string | `true` | no |
| environment | Logical name of the environment, will be used as prefix and for tagging. | string | - | yes |
| name_suffix | Logical name to append to the log group name. | string | - | yes |
| tags | A map of tags to add to the resources | map | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| amazon_linux_cloudinit_ec2_part | Cloud init part to install awslogs and configure logging for EC2. |
| amazon_linux_cloudinit_ecs_part | Cloud init part to install awslogs and configure logging for ECS. |
| amazon_linux_cloudinit_ecs_upstart_part | Cloud init part to update the upstart job to be aware of the ECS cluster. |
| log_group_arn | Arn of the created log group. If not created an empty string is returned. |
| log_group_name | Name of the created log group. If not created an empty string is returned. |


## Philips Forest

This module is part of the Philips Forest.

```
                                                     ___                   _
                                                    / __\__  _ __ ___  ___| |_
                                                   / _\/ _ \| '__/ _ \/ __| __|
                                                  / / | (_) | | |  __/\__ \ |_
                                                  \/   \___/|_|  \___||___/\__|  

                                                                 Infrastructure
```

Talk to the forestkeepers in the `forest`-channel on Slack.

[![Slack](https://philips-software-slackin.now.sh/badge.svg)](https://philips-software-slackin.now.sh)

# Terraform module for creating CloudWatch logging templates.

This module creates optional a log_group and for that log_group cloud init scripts.

## Terraform version

- Terraform 0.12: Pin module to `~> 2+`, submit pull request to branch `terrafomr012`
- Terraform 0.11: Pin module to `~> 1.x`, submit pull request to branch `develop`

## Usage

### Example usages

See also the [full examples](./examples).

```
module "cloudwatch" {
  source = "github.com/philips-software/terraform-aws-cloudwatch?ref=terrafomr012"

  environment = var.environment
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
| create\_log\_group | Indicates if the log group needs to be created by the module. | bool | `"true"` | no |
| environment | Logical name of the environment, will be used as prefix and for tagging. | string | n/a | yes |
| name\_suffix | Logical name to append to the log group name. | string | n/a | yes |
| tags | A map of tags to add to the resources | map(string) | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| amazon\_linux\_cloudinit\_ec2\_part | Cloud init part to install awslogs and configure logging for EC2. |
| amazon\_linux\_cloudinit\_ecs\_part | Cloud init part to install awslogs and configure logging for ECS. |
| amazon\_linux\_cloudinit\_ecs\_upstart\_part | Cloud init part to update the upstart job to be aware of the ECS cluster. |
| log\_group\_arn | Arn of the created log group. If not created an empty string is returned. |
| log\_group\_name | Name of the created log group. If not created an empty string is returned. |

## Automated checks
Currently the automated checks are limited. In CI the following checks are done for the root and each example.
- lint: `terraform validate` and `terraform fmt`
- basic init / get check: `terraform init -get -backend=false -input=false`

## Generation variable documentation
A markdown table for variables can be generated as follow. Generation requires awk and terraform-docs installed.

```
 .ci/bin/terraform-docs.sh markdown
```

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

#!/bin/bash -ex
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

echo 'installing additional software'
# installing in a loop to ensure the cli is intalled.
for i in {1..5}
do
  yum install -y aws-cli awslogs jq && break || sleep 60
done


# Inject the CloudWatch Logs configuration file contents
cat > /etc/awslogs/awslogs.conf <<- EOF
[general]
state_file = /var/lib/awslogs/agent-state

[/var/log/dmesg]
file = /var/log/dmesg
log_group_name = ${log_group_name}
log_stream_name = {cluster}/var/log/dmesg/{container_instance_id}
initial_position = start_of_file

[/var/log/messages]
file = /var/log/messages
log_group_name = ${log_group_name}
log_stream_name = {cluster}/var/log/messages/{container_instance_id}
datetime_format = %b %d %H:%M:%S
initial_position = start_of_file

[/var/log/docker]
file = /var/log/docker
log_group_name = ${log_group_name}
log_stream_name = {cluster}/var/log/docker/{container_instance_id}
datetime_format = %Y-%m-%dT%H:%M:%S.%f
initial_position = start_of_file

[/var/log/ecs/ecs-init.log]
file = /var/log/ecs/ecs-init.log.*
log_group_name = ${log_group_name}
log_stream_name = {cluster}/var/log/ecs/ecs-init.log/{container_instance_id}
datetime_format = %Y-%m-%dT%H:%M:%SZ
initial_position = start_of_file

[/var/log/ecs/ecs-agent.log]
file = /var/log/ecs/ecs-agent.log.*
log_group_name = ${log_group_name}
log_stream_name = {cluster}/var/log/ecs/ecs-agent.log/{container_instance_id}
datetime_format = %Y-%m-%dT%H:%M:%SZ
initial_position = start_of_file

[/var/log/ecs/audit.log]
file = /var/log/ecs/audit.log.*
log_group_name = ${log_group_name}
log_stream_name = {cluster}/var/log/ecs/audit.log/{container_instance_id}
datetime_format = %Y-%m-%dT%H:%M:%SZ
initial_position = start_of_file

EOF

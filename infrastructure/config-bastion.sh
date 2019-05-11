# Inject kubeconfig
env > /tmp/env
apt-get install sshpass > /tmp/install_log 2>&1
bastion_ip=$(aws ec2 describe-instances --region us-west-2 --filters "Name=tag:Name,Values=bastion*" "Name=instance-state-name,Values=pending,running" --query "Reservations[0].Instances[0].PrivateIpAddress" --output text)
echo $bastion_ip > /tmp/bastion_ip
echo ~/.ssh/known_hosts > /tmp/known_hosts_path
ssh-keyscan $bastion_ip >> ~/.ssh/known_hosts 2> /tmp/known_hosts_log
echo "put -P /home/ubuntu/.kube/config /home/ubuntu/.kube/config" > /tmp/batch
sshpass -p '-veryV3RY53CuRePazWurd!_' sftp -oBatchMode=no -b /tmp/batch ubuntu@$bastion_ip > /tmp/sftp_log 2>&1
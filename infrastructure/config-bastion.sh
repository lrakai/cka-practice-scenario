# Inject kubeconfig
env > /tmp/env
apt-get install sshpass > /tmp/install_log 2>&1
bastion_ip=$(aws ec2 describe-instances --region us-west-2 --filters "Name=tag:Name,Values=bastion*" "Name=instance-state-name,Values=pending,running" --query "Reservations[0].Instances[0].PrivateIpAddress" --output text)
echo $bastion_ip > /tmp/bastion_ip
echo "put -P /home/ubuntu/.kube/config /home/ubuntu/.kube/config" > /tmp/batch
sed -i "s/kubernetes-admin@kubernetes/challenge-context/g" /home/ubuntu/.kube/config
sshpass -p '-veryV3RY53CuRePazWurd!_' sftp -oBatchMode=no -oStrictHostKeyChecking=no -b /tmp/batch ubuntu@$bastion_ip > /tmp/sftp_log 2>&1
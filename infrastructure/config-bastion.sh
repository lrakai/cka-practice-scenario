# Inject kubeconfig
apt install sshpass
bastion_ip=$(aws ec2 describe-instances --region us-west-2 --filters "Name=tag:Name,Values=bastion*" --query "Reservations[0].Instances[0].PrivateIpAddress" --output text)
ssh-keyscan $bastion_ip >> ~/.ssh/known_hosts
echo "put -P /home/ubuntu/.kube/config /home/ubuntu/.kube/config" > batch
sshpass -p '-veryV3RY53CuRePazWurd!_' sftp -oBatchMode=no -b batch ubuntu@$bastion_ip
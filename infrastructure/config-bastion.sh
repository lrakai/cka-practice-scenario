#!/bin/bash

# Inject kubeconfig
env > /tmp/env

# stop any auto-update that can block apt install
systemctl stop apt-daily.service
systemctl kill --kill-who=all apt-daily.service

# wait until `apt-get updated` has been killed
while ! (systemctl list-units --all apt-daily.service | egrep -q '(dead|failed)')
do
  sleep 1;
done
pkill /usr/lib/apt/apt.systemd.daily

sudo apt update
apt-get install sshpass > /tmp/install_log 2>&1
bastion_ip=$(aws ec2 describe-instances --region us-west-2 --filters 'Name=tag:Name,Values=bastion*' 'Name=instance-state-name,Values=running,pending' --query "Reservations[0].Instances[0].PrivateIpAddress" --output text)
echo $bastion_ip > /tmp/bastion_ip
ssh-keyscan $bastion_ip >> ~/.ssh/known_hosts
echo "put -P /home/ubuntu/.kube/config /home/ubuntu/.kube/config" > /tmp/batch
sed -i "s/kubernetes-admin@kubernetes/challenge-context/g" /home/ubuntu/.kube/config
sshpass -p '-veryV3RY53CuRePazWurd!_' sftp -oBatchMode=no -oStrictHostKeyChecking=no -b /tmp/batch ubuntu@$bastion_ip > /tmp/sftp_log 2>&1
sudo -i -u ubuntu
log_file=/tmp/vxioprep

# Check 2 - Repair service
kubectl --kubeconfig=/home/ubuntu/.kube/config create namespace pwn >> $log_file 2>&1
kubectl --kubeconfig=/home/ubuntu/.kube/config create -n pwn deployment --image=httpd:2.4.39-alpine site >> $log_file 2>&1
kubectl --kubeconfig=/home/ubuntu/.kube/config scale -n pwn deployment --replicas=2 site >> $log_file 2>&1
kubectl --kubeconfig=/home/ubuntu/.kube/config create service loadbalancer -n pwn --tcp=80 sitelb >> $log_file 2>&1

# Check 1 - Create specified deployment
kubectl --kubeconfig=/home/ubuntu/.kube/config create namespace cal >> $log_file 2>&1

# Check 3 - Highest CPU pod in namespace


# Check 4 - Secret
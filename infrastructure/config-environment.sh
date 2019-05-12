sudo -i -u ubuntu
log_file=/tmp/vxioprep

# Check 1 - Create specified deployment
kubectl create namespace cal >> $log_file 2>&1

# Check 2 - Repair service
kubectl create namespace pwn >> $log_file 2>&1

# Check 3 - Highest CPU pod in namespace


# Check 4 - Secret
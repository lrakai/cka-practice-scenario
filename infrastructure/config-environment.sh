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
wget -qO /tmp/metrics-server.zip https://github.com/cloudacademy/metrics-server/archive/master.zip >> $log_file 2>&1
sudo apt install unzip && \
  unzip -q -d /tmp /tmp/metrics-server.zip && \
  kubectl --kubeconfig=/home/ubuntu/.kube/config create -f /tmp/metrics-server-master/deploy/1.8+/ >> $log_file 2>&1

cat <<'EOF' > /tmp/stng
apiVersion: v1
kind: Pod
metadata:
  name: {{name}}
  namespace: zz8
spec:
  containers:
  - image: lorel/docker-stress-ng:0.03.16
    name: {{name}}
    command: ["stress-ng", "-c 1 -l {{load}}"]
    resources:
      limits:
        cpu: {{cpu}}
  restartPolicy: Always
EOF

kubectl --kubeconfig=/home/ubuntu/.kube/config create namespace zz8 >> $log_file 2>&1
name=fnsoe-ah3na38s-zy3kx ; load=50 ; cpu=100m
sed "s/{{name}}/$name/g;s/{{load}}/$load/g;s/{{cpu}}/$cpu/g" /tmp/stng | kubectl --kubeconfig=/home/ubuntu/.kube/config create -f - >> $log_file 2>&1
name=h9sxb-sye3ne1d-3vso9 ; load=50 ; cpu=40m
sed "s/{{name}}/$name/g;s/{{load}}/$load/g;s/{{cpu}}/$cpu/g" /tmp/stng | kubectl --kubeconfig=/home/ubuntu/.kube/config create -f - >> $log_file 2>&1
name=sg831-fnba993o-r73x3 ; load=50 ; cpu=30m
sed "s/{{name}}/$name/g;s/{{load}}/$load/g;s/{{cpu}}/$cpu/g" /tmp/stng | kubectl --kubeconfig=/home/ubuntu/.kube/config create -f - >> $log_file 2>&1
name=uf2od-afn33i81-bas73 ; load=50 ; cpu=20m
sed "s/{{name}}/$name/g;s/{{load}}/$load/g;s/{{cpu}}/$cpu/g" /tmp/stng | kubectl --kubeconfig=/home/ubuntu/.kube/config create -f - >> $log_file 2>&1
name=g8wu1-ld9bm820-lr8jh ; load=50 ; cpu=15m
sed "s/{{name}}/$name/g;s/{{load}}/$load/g;s/{{cpu}}/$cpu/g" /tmp/stng | kubectl --kubeconfig=/home/ubuntu/.kube/config create -f - >> $log_file 2>&1
kubectl --kubeconfig=/home/ubuntu/.kube/config run -n zz8 --generator=run-pod/v1 --image=lrakai/tetris:1.0.0 afn8s-sh7ez70b-uy6eb >> $log_file 2>&1

# Check 4 - Secret
kubectl --kubeconfig=/home/ubuntu/.kube/config create namespace sjq >> $log_file 2>&1
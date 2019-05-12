# task 1
kubectl create deployment --image=nginx:1.15.12-alpine --namespace=cal chk1
kubectl scale -n cal deployment --replicas=3 chk1
kubectl patch deployment -n cal chk1 --patch=$'spec:\n revisionHistoryLimit: 50'

# task 2
kubectl patch -n pwn service sitelb --patch=$'spec:\n selector:\n  app: site'

# task 3
kubectl top pods -n zz8 | tail -n +2 | sort -n -k 2 -r | head -1 | cut -f 1 -d ' ' > /home/ubuntu/hcp001

# task 4
kubectl create secret generic -n sjq xh8jqk7z --from-literal=tkn=hy8szK2iu
cat <<'EOF' | kubectl create -f -
apiVersion: v1
kind: Pod
metadata:
  name: server
  namespace: sjq
spec:
  containers:
  - image: httpd:2.4.39-alpine
    name: server
    env:
      - name: SECRET_TKN
        valueFrom:
          secretKeyRef:
            name: xh8jqk7z
            key: tkn
EOF
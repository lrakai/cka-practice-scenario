# check 1
kubectl create deployment --image=nginx:1.15.12-alpine --namespace=cal chk1
kubectl scale -n cal deployment --replicas=3 chk1
kubectl patch deployment -n cal chk1 --patch=$'spec:\n revisionHistoryLimit: 50'

# check 2
kubectl patch -n pwn service sitelb --patch=$'spec:\n selector:\n  app: site'
# Check deployment
kubectl --kubeconfig=/home/ubuntu/.kube/config get -n cal deployments chk1 -o yaml --export > /tmp/check_deployment ;
replicas=$(grep "replicas: 3$" /tmp/check_deployment | wc -l) ;
image=$(grep "image: nginx:1.15.12-alpine$" /tmp/check_deployment | wc -l) ;
revisionHistory=$(grep "revisionHistoryLimit: 50$" /tmp/check_deployment | wc -l) ;
if [ $replicas -gt 0 -a $image -gt 0 -a $revisionHistory -gt 0 ]; then echo -n True; else echo -n False; fi ;

# Check service
svc_selector=$(kubectl --kubeconfig=/home/ubuntu/.kube/config get service -n pwn sitelb -o jsonpath="{.spec.selector}") ;
deploy_selector=$(kubectl --kubeconfig=/home/ubuntu/.kube/config get deployment -n pwn site -o jsonpath="{.spec.selector.matchLabels}") ;
if [ "$svc_selector" = "$deploy_selector" ]; then echo -n True; else echo -n False; fi ;

# Check highest cpu
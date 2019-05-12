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
characters=$(cat /home/ubuntu/hcp001 | tr -d \\n\\r | sed "s/\s//g" | wc -c) ;
match_pod=$(grep "fnsoe-ah3na38s-zy3kx" /home/ubuntu/hcp001 | wc -l) ;
if [ $match_pod -gt 0 -a $characters -le 20 ]; then echo -n True; else echo -n False; fi ;

# Check secret in pod via environment variable
secret_exists=$(kubectl --kubeconfig=/home/ubuntu/.kube/config get -n sjq secrets xh8jqk7z | tail -n +2 | wc -l) ;
env_map=$(kubectl --kubeconfig=/home/ubuntu/.kube/config get pod -n sjq server -o jsonpath="{.spec.containers[0].env}") ;
env_secret_name=$(echo $env_map | grep SECRET_TKN | wc -l) ;
env_secret_byref=$(echo $env_map | grep secretKeyRef | wc -l) ;
access_secret=$(kubectl --kubeconfig=/home/ubuntu/.kube/config exec -n sjq server -- env | grep SECRET_TKN=hy8szK2iu | wc -l) ;
if [ $secret_exists -gt 0 -a $env_secret_name -gt 0 -a $env_secret_byref -gt 0 -a $access_secret -gt 0 ]; then echo -n True; else echo -n False; fi ;
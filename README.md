# cka-practice-scenario

Example scenario representative of what you might need to solve in the Certified Kubernetes Admin (CKA), or even the Certified Kubernetes Application Developer (CKAD) Exam

## Example Master SSM command

To check the state of the cluster as an external observer, you can use the RunCommand API in AWS Systems Manager using the AWS-RunShellScript document. An example of a command to run on the master is:

```sh
kubectl --kubeconfig=/home/ubuntu/.kube/config get nodes
```
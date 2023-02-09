kubectl create namespace spark

eksctl create iamidentitymapping --cluster  nonprod-test-eks-cluster  --namespace spark --service-name "emr-containers"  

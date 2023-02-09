
export ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
export AWS_REGION=us-west-2
aws logs create-log-group --log-group-name=/emr-on-eks/eksworkshop-eksctl
export s3DemoBucket=s3://emr-eks-demo-${ACCOUNT_ID}-${AWS_REGION}
#aws s3 mb $s3DemoBucket

export VIRTUAL_CLUSTER_ID=$(aws emr-containers list-virtual-clusters --query "virtualClusters[?state=='RUNNING'].id" --output text)
export EMR_ROLE_ARN=$(aws iam get-role --role-name EMRContainers-JobExecutionRole --query Role.Arn --output text)



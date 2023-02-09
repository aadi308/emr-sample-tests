### EMR on EKS
EMR on EKS is a deployment option in EMR that allows you to automate the provisioning and management of open-source big data frameworks on EKS. There are several advantages of running optimized spark runtime provided by Amazon EMR on EKS such as 3x faster performance, fully managed lifecycle of these jobs, built-in monitoring and logging functionality, integrates securely with Kubernetes and more. Because Kubernetes can natively run Spark jobs, if you use multi-tenant EKS environment (shared with other micro-services), your spark jobs are deployed in seconds vs minutes when compared to EC2 based deployments.

#### Create namespace and RBAC permissions

```$ bash  1spark-namespace-rbac-permission.sh <clustername>```

#### Enable IAM Roles for Service Account (IRSA)

``` $ bash 2Iam-roles-SA.sh <clustername> ```

#### Create IAM Role for job execution

  we need to attach the required IAM policies to the role so it can write logs to s3 and cloudwatch.

  ```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "elasticmapreduce.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}


  ```

add the json file in emr-trust-policy.json  and mention in the script

  ``` $ bash 3Iam-role-JOB-execution.sh   ```

#### Update trust relationship for job execution role

  we need to update the trust relationship between IAM role we just created with EMR service identity.

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:ListBucket"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:PutLogEvents",
                "logs:CreateLogStream",
                "logs:DescribeLogGroups",
                "logs:DescribeLogStreams"
            ],
            "Resource": [
                "arn:aws:logs:*:*:*"
            ]
        }
    ]
}


```
create the json file with name EMRContainers-JobExecutionRole.json and mention on the script

```  $ bash 4EMR-containers-JOB-execution-role.sh   ```
  
#### Register EKS cluster with EMR
  


create the trust relationship for job execution

``` $ bash 5Trust-relationship-jobexecution.sh   ```

  register EKS cluster with EMR.

``` $ bash 6register-eks-with-emr.sh  ```
  

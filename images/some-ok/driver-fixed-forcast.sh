export AWS_PROFILE=emr-nonprod-from-root-fpg-acc
export AWS_REGION=us-west-2
export VIRTUAL_CLUSTER_ID=$(aws emr-containers list-virtual-clusters --query "virtualClusters[?state=='RUNNING'].id" --output text)
export EMR_ROLE_ARN=$(aws iam get-role --role-name EMRContainers-JobExecutionRole --query Role.Arn --output text)

aws emr-containers start-job-run \
  --virtual-cluster-id=$VIRTUAL_CLUSTER_ID \
  --name=forcast-job \
  --execution-role-arn=$EMR_ROLE_ARN \
  --release-label=emr-6.6.0-latest \
  --job-driver='{
    "sparkSubmitJobDriver": {
      "entryPoint":"s3://emr-eks-demo-447722449887-us-east-2/call_forecast_proc.py",
      "sparkSubmitParameters": "--py-files s3://emr-eks-demo-447722449887-us-east-2/* --jars s3://emr-eks-demo-447722449887-us-east-2/jars/mysql-connector-java-8.0.29.jar  --conf spark.executor.instances=1 --deploy-mode cluster --conf spark.shuffle.service.enabled=true --conf spark.executor.memory=1G --conf spark.executor.cores=1 --conf spark.driver.cores=2 --conf spark.kubernetes.container.image=447722449887.dkr.ecr.us-west-2.amazonaws.com/custom-emr:latest "
    }
  }'\
  --configuration-overrides='{

        "applicationConfiguration": [
      {
        "classification": "spark-defaults",
        "properties": {
          "spark.sql.parquet.datetimeRebaseModeInWrite":"CORRECTED",
          "spark.dynamicAllocation.enabled":"true",
          "spark.yarn.driver.CONFIG_FILE":"s3://emr-eks-demo-447722449887-us-east-2/config/k8s_hotel_forecast.json",
          "spark.dynamicAllocation.minExecutors":"1",
          "spark.dynamicAllocation.maxExecutors":"25",
          "spark.dynamicAllocation.initialExecutors":"1",
          "spark.yarn.driver.RUN_TYPE":"complete"
         }
      }
    ]
    

  }'


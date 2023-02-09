
aws emr-containers start-job-run \
  --virtual-cluster-id=$VIRTUAL_CLUSTER_ID \
  --name=threadsleep-dra \
  --execution-role-arn=$EMR_ROLE_ARN \
  --release-label=emr-6.6.0-latest \
  --job-driver='{
    "sparkSubmitJobDriver": {
      "entryPoint": "s3://emr-eks-demo-447722449887-us-east-2/pi.py",
      "sparkSubmitParameters": "--conf spark.executor.instances=1 --conf spark.executor.memory=1G --conf spark.executor.cores=1 --conf spark.driver.cores=1"
    }
  }'\
  --configuration-overrides='{
  	"applicationConfiguration": [
      {
        "classification": "spark-defaults", 
        "properties": {
          "spark.dynamicAllocation.enabled":"true",
          "spark.dynamicAllocation.shuffleTracking.enabled":"true",
          "spark.dynamicAllocation.minExecutors":"1",
          "spark.dynamicAllocation.maxExecutors":"10",
          "spark.dynamicAllocation.initialExecutors":"1",
          "spark.dynamicAllocation.schedulerBacklogTimeout": "1s",
          "spark.dynamicAllocation.executorIdleTimeout": "5s"
         }
      }
    ]
  }'

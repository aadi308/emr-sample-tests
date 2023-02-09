#Get required virtual cluster-id and role arn
export VIRTUAL_CLUSTER_ID=$(aws emr-containers list-virtual-clusters --query "virtualClusters[?state=='RUNNING'].id" --output text)

export EMR_ROLE_ARN=$(aws iam get-role --role-name EMRContainers-JobExecutionRole --query Role.Arn --output text)

#if not uploaded the tempaltes
# aws s3 cp threadsleep.py ${s3DemoBucket}
# aws s3 cp spark_driver_pod_template.yml ${s3DemoBucket}/pod_templates/
# aws s3 cp spark_executor_pod_template.yml ${s3DemoBucket}/pod_templates/

#start spark job with start-job-run
aws emr-containers start-job-run \
  --virtual-cluster-id $VIRTUAL_CLUSTER_ID \
  --name pi-run-now \
  --execution-role-arn $EMR_ROLE_ARN \
  --release-label emr-5.33.0-latest \
  --job-driver '{
    "sparkSubmitJobDriver": {
      "entryPoint": "'${s3DemoBucket}'/threadsleep.py",
      "sparkSubmitParameters": "--conf spark.kubernetes.driver.podTemplateFile=\"'${s3DemoBucket}'/pod_templates/spark_driver_pod_template.yml\" --conf spark.kubernetes.executor.podTemplateFile=\"'${s3DemoBucket}'/pod_templates/spark_executor_pod_template.yml\" --conf spark.executor.instances=15 --conf spark.executor.memory=2G --conf spark.executor.cores=2 --conf spark.driver.cores=1"}}' \
  --configuration-overrides '{
        "applicationConfiguration": [
            {
                "classification": "spark-defaults",
                "properties": {
                  "spark.dynamicAllocation.enabled": "false",
                  "spark.kubernetes.executor.deleteOnTermination": "true",
                  "spark.driver.extraClassPath":"/home/hadoop/fpg_spark_hospitality/jars/mysql-connector-java8.0.29.jar,/home/hadoop/fpg_spark_hospitality/jars/mysql-connector-java8.0.29.jar,/usr/share/aws/redshift/jdbc/RedshiftJDBC.jar,/usr/share/aws/redshift/spark-redshift/lib/spark-redshift.jar,/usr/share/aws/redshift/spark-redshift/lib/spark-avro.jar,/usr/share/aws/redshift/sparkredshift/lib/minimal-json.jar "
                }
            }
        ],
        "monitoringConfiguration": {
            "cloudWatchMonitoringConfiguration": {
                "logGroupName": "/emr-on-eks/eksworkshop-eksctl",
                "logStreamNamePrefix": "pi"
            },
            "s3MonitoringConfiguration": {
                "logUri": "'${s3DemoBucket}'/"
            }
        }
    }'
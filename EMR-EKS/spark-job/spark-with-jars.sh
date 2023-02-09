aws emr-containers start-job-run \
  --virtual-cluster-id=$VIRTUAL_CLUSTER_ID \
  --name=pi-2 \
  --execution-role-arn=$EMR_ROLE_ARN \
  --release-label=emr-6.2.0-latest \
  --profile emr-nonprod-from-root-fpg-acc \
  --job-driver='{
    "sparkSubmitJobDriver": {
      "entryPoint": "s3://emr-eks-demo-447722449887-us-east-2/pi.py",
      "sparkSubmitParameters": " --conf spark.sql.parquet.datetimeRebaseModeInWrite=CORRECTED  --conf spark.dynamicAllocation.enabled=true  --conf spark.dynamicAllocation.initialExecutors=2  --conf spark.dynamicAllocation.minExecutors=2  --conf spark.dynamicAllocation.maxExecutors=25 --conf spark.yarn.driver.CONFIG_FILE=uat_hotel_forecast.json  --conf spark.yarn.driver.RUN_TYPE=complete --conf spark.executor.instances=1 --conf spark.executor.memory=2G --conf spark.executor.cores=1 --conf spark.driver.cores=1 --jars /home/hadoop/fpg_spark_hospitality/jars/mysql-connector-java8.0.29.jar,/home/hadoop/fpg_spark_hospitality/jars/mysql-connector-java8.0.29.jar,/usr/share/aws/redshift/jdbc/RedshiftJDBC.jar,/usr/share/aws/redshift/spark-redshift/lib/spark-redshift.jar,/usr/share/aws/redshift/spark-redshift/lib/spark-avro.jar,/usr/share/aws/redshift/sparkredshift/lib/minimal-json.jar"
    }
  }'
FROM 773914189848.dkr.ecr.us-east-1.amazonaws.com/spark/emr-6.6.0:latest
USER root
RUN pip3 install  boto3 pandas numpy mysql-connector-python
#<copy the repo files with required branch switched for local availability>
COPY .   /  
RUN chmod -R +r  /usr/lib/spark/jars
USER hadoop:hadoop

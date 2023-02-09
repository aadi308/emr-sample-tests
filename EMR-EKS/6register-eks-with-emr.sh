aws emr-containers create-virtual-cluster \
--name emr-virtualcluster \
--container-provider '{
    "id": "nonprod-test-eks-cluster",
    "type": "EKS",
    "info": {
        "eksInfo": {
            "namespace": "spark"
        }
    }
}'

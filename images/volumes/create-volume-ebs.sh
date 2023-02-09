aws ec2 --region us-west-2 create-volume --availability-zone us-west-2a  --size 5asdf

{
    "AvailabilityZone": "us-west-2a",
    "CreateTime": "2022-10-13T06:39:59+00:00",
    "Encrypted": true,
    "Size": 5,
    "SnapshotId": "",
    "State": "creating",
    "VolumeId": "vol-0e88abbdaea7df9d7",
    "Iops": 100,
    "Tags": [],
    "VolumeType": "gp2",
    "MultiAttachEnabled": false
}
{
    "AvailabilityZone": "us-west-2b",
    "CreateTime": "2022-10-13T06:59:54+00:00",
    "Encrypted": true,
    "Size": 5,
    "SnapshotId": "",
    "State": "creating",
    "VolumeId": "vol-0bee51dbbcd8095a8",
    "Iops": 100,
    "Tags": [],
    "VolumeType": "gp2",
    "MultiAttachEnabled": false
}


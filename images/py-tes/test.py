#import os
#os.system('ls -l')

import boto3

import zipfile

from datetime import *

from io import BytesIO

import json

import re

def unzip_file():

    session = boto3.Session(profile_name=’emr-nonprod-from-root-fpg-acc’)

    dev_client = session.client('s3')

    dev_resource=boto3.resource('s3')

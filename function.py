import json
import boto3
ec2_client= boto3.client('ec2')
client = boto3.client('s3')
response = client.get_object(
  Bucket='teed',
  Key='tags.json')
tags = response["Body"].read().decode("ascii")
#print("Tags",Tags)
#print(type(json.loads(Tags)))
#print(response["Body"].read().decode("ascii"))

def lambda_handler(event, context):
  instanceIds = []
  instance_items = event["detail"]["responseElements"]["instancesSet"]["items"]
  #print(event["detail"]["responseElements"]["instancesSet"]["items"])
  for instance in instance_items:
    instanceIds.append(instance["instanceId"])
  
  response = ec2_client.create_tags(
    Resources=instanceIds,
    Tags=json.loads(tags)
    )
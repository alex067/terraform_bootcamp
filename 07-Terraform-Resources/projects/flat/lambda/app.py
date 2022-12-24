import json
import random
import boto3
from string import ascii_lowercase
from os import getenv
from random import randint

dynamodb_client = boto3.resource("dynamodb")

context_attrs = ['resource', 'path', 'httpMethod']

def generate_id():
  return ''.join(random.choice(ascii_lowercase) for i in range(10))

def handler(event, context):
  for context_attr in context_attrs:
    if context_attr not in event:
     return { "statusCode": 500, "headers": {"Content-Type": "application/json"} }

  random_numb = randint(1, 100)
  new_id = generate_id()

  try:
    dynamodb_client.Table(getenv("DYNAMO_TABLE_NAME")).put_item(Item={
      'RandomId': new_id,
      'Value': random_numb
    })
  except Exception as ee:
    print(ee)
    return { "statusCode": 500, "headers": {"Content-Type": "application/json"}, 
      "body": json.dumps({ "error" : ee })
    }

  return { "statusCode": 200, "headers": { "Content-Type": "application/json" },
    "body": json.dumps({ "value": random_numb })
  }
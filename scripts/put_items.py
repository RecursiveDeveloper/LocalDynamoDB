import boto3
import sys

dynamodb = boto3.resource('dynamodb', endpoint_url=sys.argv[1])
table_name= sys.argv[2]

try:
    table = dynamodb.Table(table_name)
    table.put_item(
        TableName=table_name,
        ReturnConsumedCapacity='TOTAL',
        Item={
            'Artist': 'Acme Band',
            'SongTitle': 'PartiQL Rocks!'
        }
    )
except Exception as e:
    print(f"Error: {e}")

import boto3

dynamodb = boto3.resource('dynamodb', endpoint_url="http://localhost:8000")
table_name= "Music"

try:
    table = dynamodb.create_table(
        TableName=table_name,
        KeySchema=[
            {
                'AttributeName': 'Artist',
                'KeyType': 'HASH'
            },
            {
                'AttributeName': 'SongTitle',
                'KeyType': 'RANGE'
            }
        ],
        AttributeDefinitions=[
            {
                'AttributeName': 'Artist',
                'AttributeType': 'S'
            },
            {
                'AttributeName': 'SongTitle',
                'AttributeType': 'S'
            }
        ],
        ProvisionedThroughput={
            'ReadCapacityUnits': 1,
            'WriteCapacityUnits': 1
        }
    )
except Exception as e:
    print(f"Error: {e}")

import json
import boto3
import hashlib
import time
import os

BASE_URL = os.environ.get('BASE_URL', 'https://fallback-url.com')

dynamodb = boto3.resource('dynamodb')
table_name = os.environ.get('TABLE_NAME', 'UrlMappings')
table = dynamodb.Table(table_name)

def generate_short_code(url):
    # Use a hash of the URL + timestamp for uniqueness
    hash_input = url + str(time.time())
    return hashlib.sha256(hash_input.encode()).hexdigest()[:6]

def lambda_handler(event, context):
    try:
        body = json.loads(event['body'])
        original_url = body.get('url')

        if not original_url:
            return {
                'statusCode': 400,
                'body': json.dumps({'error': 'Missing URL'})
            }

        short_code = generate_short_code(original_url)
        timestamp = time.strftime('%Y-%m-%dT%H:%M:%SZ', time.gmtime())

        # Store in DynamoDB
        table.put_item(Item={
            'shortCode': short_code,
            'originalUrl': original_url,
            'createdAt': timestamp,
            'clickCount': 0
        })

        return {
            'statusCode': 200,
            'body': json.dumps({
                'shortUrl': f'{BASE_URL}/{short_code}',
                'originalUrl': original_url
            })
        }

    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)})
        }

import json
import boto3
import os

dynamodb = boto3.resource('dynamodb')
table_name = os.environ.get('TABLE_NAME', 'UrlMappings')
table = dynamodb.Table(table_name)

def lambda_handler(event, context):
    try:
        short_code = event['pathParameters']['shortCode']

        # Look up the short code in DynamoDB
        response = table.get_item(Key={'shortCode': short_code})
        item = response.get('Item')

        if not item:
            return {
                'statusCode': 404,
                'body': json.dumps({'error': 'Short URL not found'})
            }

        # Optional: increment click count
        table.update_item(
            Key={'shortCode': short_code},
            UpdateExpression='SET clickCount = clickCount + :inc',
            ExpressionAttributeValues={':inc': 1}
        )

        # Redirect to original URL
        return {
            'statusCode': 301,
            'headers': {
                'Location': item['originalUrl']
            }
        }

    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)})
        }

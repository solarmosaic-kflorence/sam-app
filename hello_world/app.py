import yaml


def lambda_handler(event, context):
    body = yaml.safe_load(event.body)
    return {
        "statusCode": 200,
        "body": yaml.safe_dump(body)
    }

import boto3
from datetime import datetime, timedelta
import time
import os

client = boto3.client('logs')

log_group_name = os.environ['LOG_GROUP_NAME']
event_name = os.environ['EVENT_NAME']

def lambda_handler(event, context):
    current_time = datetime.now()
    print("current time = ", current_time.strftime("%m/%d/%Y, %H:%M:%S"))
    print("one hour ago = ", (current_time - timedelta(hours=1)).strftime("%m/%d/%Y, %H:%M:%S"))

    start_query_response = client.start_query(
        logGroupName=log_group_name,
        startTime=int((current_time - timedelta(hours=1)).timestamp()),
        endTime=int(datetime.now().timestamp()),
        queryString=f'filter eventName="{event_name}" stats count(*) as Total_Count',
    )

    query_id = start_query_response['queryId']

    get_query_results_response = None

    while get_query_results_response == None or get_query_results_response['status'] == 'Running':
        print('Polling for query result ...')
        time.sleep(1)
        get_query_results_response = client.get_query_results(
            queryId=query_id
        )     
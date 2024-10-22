import boto3
import os
import awswrangler as wr
from datetime import datetime, timedelta

boto3.setup_default_session(region_name=region)

log_group_name = os.environ['log_group_name']
event_name = os.environ['event_name']

def lambda_handler(event, context):
    current_time = datetime.now()
    print("current time = " + current_time)
    print("one hour ago = " + current_time - timedelta(hours=1))
    df = wr.cloudwatch.read_logs(
        log_group_names=[log_group_name],
        start_time=current_time - timedelta(hours=1),
        end_time=current_time,
        query=f'filter eventName="{event_name}" stats count(*) as Total_Count'
    )
    print(df.to_string)   
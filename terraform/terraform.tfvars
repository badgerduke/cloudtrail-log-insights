# The name of the custom Cloudtrail trail
custom_trail_name = "demo-trail"

# The S3 prefix in the bucket storing CloudTrail logs
custom_trail_s3_prefix = "demo-trail"

# The name of the S3 bucket storing the custom trail logs
custom_trail_S3_name = "cloudtrail-eventbridge-example"

# The name of the CloudWatch log group to deliver CloudTrail logs 
custom_trail_cw_log_group_name = "demo-trail-logs"

# The name of the CloudWatch metric filter
metric_filter_name = "demo-metric-filter"

# The metric filter pattern 
metric_filter_pattern = "{ $.eventName = ModifySecurityGroupRules }"

# The custom namespace for the produced metric
metric_filter_metric_namespace = "CTDemo"

# The name of the metric to store filter matches
metric_filter_metric_name = "CountSGModifies"

# The name of the CloudWatch Alarm
alarm_name = "DemoAlarm"

# The name of the security group
security_group_name = "demo-sg"

# The name of the SNS topic.  Note as of 10/15/24, there is a bug in AWS associated with 
# CloudWatch alarms and SNS targets.  See https://stackoverflow.com/questions/62694223/cloudwatch-alarm-pending-confirmation
# This will affect you if you apply/destroy the Terraform multiple times.  You must give the
# SNS topic a new name each cycle.
sns_topic_name = "demo-sns-2"

# The email address subscibing to the SNS topic
sns_email = "<your_email>"




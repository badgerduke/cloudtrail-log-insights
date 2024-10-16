resource "aws_cloudwatch_log_group" "cloudwatch_log_group" {
  name              = var.custom_trail_cw_log_group_name
  retention_in_days = 3
}
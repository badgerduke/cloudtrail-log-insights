resource "null_resource" "install_dependencies" {
  provisioner "local-exec" {
    command = "pip install -r ${var.lambda_root}/requirements.txt -t ${var.lambda_root}/"
  }
  
  # Will trigger this resource when dependencies or Lambda code changes
  triggers = {
    dependencies_versions = filemd5("${var.lambda_root}/requirements.txt")
    source_versions = filemd5("${var.lambda_root}/${var.lambda_filename}")
  }
}

resource "random_uuid" "lambda_src_hash" {
  keepers = {
    for filename in setunion(
      fileset(var.lambda_root, "${var.lambda_filename}"),
      fileset(var.lambda_root, "requirements.txt")
    ):
    filename => filemd5("${var.lambda_root}/${filename}")
  }
}

data "archive_file" "lambda_source" {
  depends_on = [null_resource.install_dependencies]
  excludes   = [
    "__pycache__",
    "venv",
  ]

  source_dir  = var.lambda_root
  output_path = "${random_uuid.lambda_src_hash.result}.zip"
  type        = "zip"
}

resource "aws_lambda_function" "lambda" {
  function_name    = "cw-log-insights-query"
  role             = aws_iam_role.lambda_execution_role.arn
  filename         = data.archive_file.lambda_source.output_path
  source_code_hash = data.archive_file.lambda_source.output_base64sha256

  handler          = var.lambda_handler
  runtime          = var.lambda_runtime

  environment {
    variables = {
      LOG_GROUP_NAME = var.custom_trail_cw_log_group_name,
      EVENT_NAME     = var.cloudtrail_event_name
    }
  }

  depends_on    = [
    aws_iam_role_policy_attachment.lambda_execution_role_policy_attach_1,
    aws_iam_role_policy_attachment.lambda_execution_role_policy_attach_2
  ]
}

resource "aws_iam_role" "lambda_execution_role" {

  name               = "ct-demo-lambda-execution-role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "lambda.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_execution_role_policy_attach_1" {
  role       = "${aws_iam_role.lambda_execution_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "lambda_execution_role_policy_attach_2" {
  role       = "${aws_iam_role.lambda_execution_role.name}"
  policy_arn = "${aws_iam_policy.query_log_insights_policy.arn}"
}

resource "aws_iam_policy" "query_log_insights_policy" {
  name        = "query-log-insights-policy"
  policy      = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "logs:StartQuery"
        ],
        "Resource": "*"
      }
    ]
  })
}



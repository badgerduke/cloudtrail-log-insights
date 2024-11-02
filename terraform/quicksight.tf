resource "aws_s3_bucket" "demo_quicksight_bucket" {
  bucket        = var.quicksight_S3_name
  force_destroy = true
}

# Creates a folder
resource "aws_s3_bucket_object" "demo-quicksight-folder" {
    bucket = aws_s3_bucket.demo_quicksight_bucket.id
    acl    = "private"
    key    = "${var.quicksight_S3_folder}/"
    source = "/dev/null"
}


/* {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::hamacher-quicksight-2",
                "arn:aws:s3:::hamacher-quicksight-2/*"
            ]
        },
        {
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::hamacher-quicksight-2",
                "arn:aws:s3:::hamacher-quicksight-2/*"
            ],
            "Condition": {
                "ArnNotEquals": {
                    "aws:PrincipalArn": [
                        "arn:aws:iam::093879445146:role/service-role/aws-quicksight-s3-consumers-role-v0",
                        "arn:aws:iam::093879445146:role/service-role/aws-quicksight-service-role-v0",
                        "arn:aws:iam::093879445146:user/me_eric"
                    ]
                }
            }
        }
    ]
} */
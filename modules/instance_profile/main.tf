resource "aws_iam_instance_profile" "instance_profile" {
  name = "${var.instance_profile_name}"
  role = "${aws_iam_role.instance_profile_role.name}"
}

resource "aws_iam_role" "instance_profile_role" {
  name = "${var.instance_profile_name}"
  description = "${var.role_description}"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "webtier_policy_attachment" {
  role       = "${aws_iam_instance_profile.instance_profile.name}"
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
}

resource "aws_iam_role_policy_attachment" "cloudwatch_policy_attachment" {
  role       = "${aws_iam_instance_profile.instance_profile.name}"
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}
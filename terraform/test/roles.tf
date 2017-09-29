resource "aws_iam_instance_profile" "workshop_profile" {
    name = "workshop_profile_kimber"
    roles = ["${aws_iam_role.ec2_role.name}"]
}

resource "aws_iam_role" "ec2_role" {
    name = "ec2_role_kimber"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": { "Service": "ec2.amazonaws.com" },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "s3_bucket_policy" {
    name = "s3_deploy_bucket_policy_kimber"
    role = "${aws_iam_role.ec2_role.id}"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [ "s3:Get*", "s3:List*" ],
      "Resource": [ "arn:aws:s3:::18f-terraform-workshop",
                    "arn:aws:s3:::18f-terraform-workshop/*" ]
    },
    {
      "Effect": "Allow",
      "Action": [ "logs:CreateLogGroup", "logs:CreateLogStream",
        "logs:PutLogEvents", "logs:DescribeLogStreams" ],
      "Resource": [ "arn:aws:logs:*:*:*" ]
    }
  ]
}
EOF
}

resource "aws_launch_configuration" "workshop_launch_conf" {
    	image_id = "ami-c481fad3"
    	instance_type = "t2.micro"
    	key_name = "kimberbat"
    	security_groups = ["${aws_security_group.web_sg.id}"]
    	associate_public_ip_address = true
    	lifecycle {
        create_before_destroy = true
    }
	    iam_instance_profile =
	        "${aws_iam_instance_profile.workshop_profile.arn}"    
	    user_data =  <<EOF
#!/usr/bin/env bash
aws s3 cp s3://18f-terraform-workshop/provision.sh /root/
bash /root/provision.sh
EOF
}
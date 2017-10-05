resource "aws_cloudwatch_metric_alarm" "dead_server" {
	    alarm_name = "Less than two healthy hosts in kimberbat!"
	    comparison_operator = "LessThanThreshold"
	    evaluation_periods = "1"
	    metric_name = "HealthyHostCount"
	    namespace = "AWS/ApplicationELB"
	    period = "60"
	    statistic = "Minimum"
	    threshold = "2"
	    dimensions {
	        LoadBalancer =
	            "${aws_alb.workshop_alb.arn_suffix}"
	        TargetGroup =
	            "${aws_alb_target_group.workshop_alb.arn_suffix}"
	    }
	    alarm_actions = ["${aws_sns_topic.workshop_alerts.arn}"]
	    ok_actions = ["${aws_sns_topic.workshop_alerts.arn}"]
	}

	resource "aws_sns_topic" "workshop_alerts" {
    	name = "workshop-alerts-topic-kimber"
	}

		output "sns.arn" {
    	value = "${aws_sns_topic.workshop_alerts.arn}"
	}


resource "aws_autoscaling_group" "workshop_autoscale" {
	    vpc_zone_identifier = ["${aws_subnet.public_subnet_1.id}",
	                           "${aws_subnet.public_subnet_2.id}"]
	    min_size = 2
	    max_size = 2
	    health_check_type = "EC2"
	    health_check_grace_period = 300
	    launch_configuration = "${aws_launch_configuration.workshop_launch_conf.id}"
	    target_group_arns = ["${aws_alb_target_group.workshop_alb.arn}"]
	    enabled_metrics = ["GroupInServiceInstances"]
}

resource "aws_alb_listener" "workshop_alb_http" {
 		load_balancer_arn = "${aws_alb.workshop_alb.arn}"
  		port = 80
  		protocol = "HTTP"
  		default_action {
    	target_group_arn = "${aws_alb_target_group.workshop_alb.arn}"
    	type = "forward"
  	}
}

resource "aws_alb_target_group" "workshop_alb" {
    	name = "workshop-alb-target-kimberbat"
    	vpc_id = "${aws_vpc.workshop_vpc.id}"
    	port = 80
    	protocol = "HTTP"
    	health_check {
      	matcher = "200,301"
      	path = "/status.php"
  	}
}
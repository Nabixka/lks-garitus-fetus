resource "aws_lb_target_group" "lks_gatus_app_tg" {
  name     = "lks-gatus-app-tg"
  port     = 8080
  protocol = "HTTP"
  target_type = "ip"
  vpc_id   = aws_vpc.lks_pm_vpc.id

  health_check {
    healthy_threshold = 5
    unhealthy_threshold = 3
    interval = 61
    timeout = 60
  }
}

resource "aws_lb_target_group" "lks_leantime_app_tg" {
  name     = "lks-leantime-app-tg"
  port     = 8080
  protocol = "HTTP"
  target_type = "ip"
  vpc_id   = aws_vpc.lks_pm_vpc.id

  health_check {
    healthy_threshold = 3
    unhealthy_threshold = 2
    interval = 60
    timeout = 30
    matcher = "200-302"
  }
}

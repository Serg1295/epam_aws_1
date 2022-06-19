############################################################
# Route53
############################################################
resource "aws_route53_record" "record" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.sergo.zone_id
}
  
resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.sergo.zone_id
  name    = "www.sergo.link"
  type    = "A"

  alias {
    name                   = aws_lb.EPAM_ALB.dns_name
    zone_id                = aws_lb.EPAM_ALB.zone_id
    evaluate_target_health = true
  }
}
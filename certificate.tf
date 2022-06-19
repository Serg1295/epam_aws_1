################################################################
# Certificate
################################################################
resource "aws_acm_certificate" "cert" {
  domain_name       = "*.sergo.link"
  validation_method = "DNS"
}

resource "aws_acm_certificate_validation" "dns_validation" {
  certificate_arn = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.record : record.fqdn]
}
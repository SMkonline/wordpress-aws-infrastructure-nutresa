resource "aws_waf_ipset" "ipset" {
  name = format("%s-%s-%s-%s", var.provider_id, "ipset", var.OU, var.stage)

  ip_set_descriptors {
    type  = "IPV4"
    value = "192.0.7.0/24"
  }
}

resource "aws_waf_rule" "wafrule" {
  depends_on  = [aws_waf_ipset.ipset]
  name        = format("%s-%s-%s-%s", var.provider_id, "wafrule", var.OU, var.stage)
  metric_name = format("%s%s%s%s", var.provider_id, "wafrule", var.OU, var.stage)

  predicates {
    data_id = aws_waf_ipset.ipset.id
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_waf_web_acl" "waf_acl" {
  depends_on = [
    aws_waf_ipset.ipset,
    aws_waf_rule.wafrule,
  ]
  name        = format("%s-%s-%s-%s", var.provider_id, "WebACL", var.OU, var.stage)
  metric_name = format("%s%s%s%s", var.provider_id, "WebACL", var.OU, var.stage)

  default_action {
    type = "ALLOW"
  }

  rules {
    action {
      type = "BLOCK"
    }

    priority = 1
    rule_id  = aws_waf_rule.wafrule.id
    type     = "REGULAR"
  }
}
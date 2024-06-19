resource "aws_db_instance" "aurora_instance" {
    identifier            = format("%s-%s-%s-%s-%s", var.provider_id, "rds", var.OU, var.stage, "web")
    instance_class        = "db.t3.small"
    engine                = "mysql"
    allocated_storage     = 10
    availability_zone     = format("%s%s", var.region, "a")
    multi_az              = false
    publicly_accessible   = false
    skip_final_snapshot   = true

    db_name        = format("%s_%s", "db", var.OU)
    username       = format("%s_%s_%s_%s", "user", var.provider_id, var.OU, var.stage)
    password       = random_password.password.result
}

resource "random_password" "password" {
    length = 16
    special = true
}

resource "aws_secretsmanager_secret" "aurora_db_password" {
    name        = format("%s-%s-%s-%s-%s", var.provider_id, "ssm", var.OU, var.stage, "db")
    description = "The password for the Aurora database."
}

resource "aws_secretsmanager_secret_version" "aurora_db_password_version" {
    secret_id = aws_secretsmanager_secret.aurora_db_password.id
    secret_string = jsonencode({
        db_password = random_password.password.result
    })
}
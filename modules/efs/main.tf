resource "aws_efs_file_system" "efs" {
    creation_token = format("%s-%s-%s-%s-%s", var.provider_id, "efs", var.OU, var.stage, "web")

    lifecycle_policy {
        transition_to_ia = "AFTER_30_DAYS"
    }
}

resource "aws_efs_mount_target" "mount" {
    file_system_id = aws_efs_file_system.efs.id
    subnet_id      = var.subnet_id
    security_groups = [ var.security_group_id ]
}
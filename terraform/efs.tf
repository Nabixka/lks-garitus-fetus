# File System
resource "aws_efs_file_system" "lks_project_management" {
  creation_token = "lks-project-management"
  throughput_mode = "elastic"

  tags = {
    Name = "lks-project-management"
  }
}


# Access Point
resource "aws_efs_access_point" "public_userfiles" {
  file_system_id = aws_efs_file_system.lks_project_management.id

  posix_user {
    gid = 1000
    uid = 1000
  }

  root_directory {
    path = "/public_userfiles"

    creation_info {
      owner_gid = 1000
      owner_uid = 1000
      permissions = 764
    }
  }

}

resource "aws_efs_access_point" "userfiles" {
  file_system_id = aws_efs_file_system.lks_project_management.id

  posix_user {
    gid = 1000
    uid = 1000
  }

  root_directory {
    path = "/userfiles"

    creation_info {
      owner_gid = 1000
      owner_uid = 1000
      permissions = 764
    }
  }

}

resource "aws_efs_access_point" "plugins" {
  file_system_id = aws_efs_file_system.lks_project_management.id

  posix_user {
    gid = 1000
    uid = 1000
  }

  root_directory {
    path = "/plugins"

    creation_info {
      owner_gid = 1000
      owner_uid = 1000
      permissions = 764
    }
  }

}

# Mount Target

resource "aws_efs_mount_target" "private_1a" {
  file_system_id = aws_efs_file_system.lks_project_management.id
  subnet_id      = aws_subnet.lks_pm_private_subnet_1a.id
  security_groups = [aws_security_group.lks_sg_database]
}

resource "aws_efs_mount_target" "private_1b" {
  file_system_id = aws_efs_file_system.lks_project_management.id
  subnet_id      = aws_subnet.lks_pm_private_subnet_1b.id
  security_groups = [aws_security_group.lks_sg_database]
}
resource "aws_ecr_repository" "lks_gatus" {
  name                 = "lks-gatus"
  image_tag_mutability = "MUTABLE"
}
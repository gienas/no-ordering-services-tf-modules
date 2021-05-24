
resource "aws_ecr_lifecycle_policy" "retention" {
  for_each   = toset(var.ecr_repositories)
  repository = each.value
  policy     = <<EOF
{
    "rules": [
      {
        "action": {
          "type": "expire"
        },
        "selection": {
          "countType": "imageCountMoreThan",
          "countNumber": ${var.number_of_images_to_retain},
          "tagStatus": "any"
        },
        "description": "Leaves ${var.number_of_images_to_retain} images in the repository",
        "rulePriority": 1
      }
    ]
}
EOF
}
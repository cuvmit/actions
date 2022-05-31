resource "aws_iam_user" "github-actions" {
  name = "github-actions"
}

resource "aws_iam_group" "github-actions-group" {
  name = "github-actions-group"
}

resource "aws_iam_user_group_membership" "github-actions-gm" {
  user = aws_iam_user.github-actions.name

  groups = [
    aws_iam_group.github-actions-group.name
  ]
}

resource "aws_iam_group_policy" "github-actions-policy" {
  name  = "github-actions-policy"
  group = aws_iam_group.github-actions-group.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:*"
        ],
        "Resource" : [
          "arn:aws:s3:::vetapp-sb.vmit.cucloud.net",
          "arn:aws:s3:::vetapp-sb.vmit.cucloud.net/*",
          "arn:aws:s3:::vetapp-prod.vmit.cucloud.net",
          "arn:aws:s3:::vetapp-prod.vmit.cucloud.net/*",
          "arn:aws:s3:::app-sb.vet.cornell.edu",
          "arn:aws:s3:::app-sb.vet.cornell.edu/*",
          "arn:aws:s3:::app.vet.cornell.edu",
          "arn:aws:s3:::app.vet.cornell.edu/*",
        ]
      },
      {
        "Sid" : "UpdateIngress",
        "Effect" : "Allow",
        "Action" : [
          "ec2:RevokeSecurityGroupIngress",
          "ec2:AuthorizeSecurityGroupIngress"
        ],
        "Resource" : "arn:aws:ec2:us-east-1:165158508528:security-group/sg-06a1c0133c41d79b9"
      },
      {
        "Sid" : "DescribeGroups",
        "Effect" : "Allow",
        "Action" : "ec2:DescribeSecurityGroups",
        "Resource" : "*"
      },
      {
        "Sid" : "ECRActions",
        "Effect" : "Allow",
        "Action" : [
          "ecr:GetAuthorizationToken",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:PutImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload",
          "ecr:DescribeImages"
        ],
        "Resource" : "*"
      },
      {
        "Sid" : "ReadOracleClient",
        "Effect" : "Allow",
        "Action" : [
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:ListBucket"
        ],
        "Resource" : [
          "arn:aws:s3:::vmit-public/*",
          "arn:aws:s3:::vmit-public"
        ]
      }
    ]
  })
}

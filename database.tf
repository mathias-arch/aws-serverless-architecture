resource "aws_dynamodb_table" "mathias_db" {
  name           = "MathiasDataTable"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "UserId"

  attribute {
    name = "UserId"
    type = "S" # 'S'
  }

  tags = {
    Name        = "Mathias-Database"
    Environment = "Dev"
  }
}

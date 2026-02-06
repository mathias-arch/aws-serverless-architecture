# Esto mete mi archivo hello.py en un .zip automáticamente
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "hello.py"
  output_path = "lambda_function.zip"
}

# Permisos: El "carnet de identidad" para que la Lambda pueda trabajar
resource "aws_iam_role" "iam_for_lambda" {
  name = "mathias_lambda_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

# La función real en AWS
resource "aws_lambda_function" "mathias_lambda" {
  filename      = "lambda_function.zip"
  function_name = "MathiasFunction"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "hello.lambda_handler"
  runtime       = "python3.9"

  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
}

# Política para que la Lambda pueda escribir en DynamoDB
resource "aws_iam_role_policy" "dynamodb_lambda_policy" {
  name = "mathias_lambda_dynamo_policy"
  role = aws_iam_role.iam_for_lambda.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action   = ["dynamodb:PutItem", "dynamodb:GetItem"]
      Effect   = "Allow"
      Resource = "*" 
    }]
  })
}

# 1. Creamos la API (El Interfono)
resource "aws_apigatewayv2_api" "lambda_api" {
  name          = "mathias_public_api"
  protocol_type = "HTTP"
}

# 2. Conectamos la API con mi función Lambda
resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id           = aws_apigatewayv2_api.lambda_api.id
  integration_uri  = aws_lambda_function.mathias_lambda.invoke_arn
  integration_type = "AWS_PROXY"
}

# 3. Creamos la ruta (El botón del interfono)
resource "aws_apigatewayv2_route" "lambda_route" {
  api_id    = aws_apigatewayv2_api.lambda_api.id
  route_key = "GET /saludo" # Si escribes esto al final de la URL, funciona
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}

# 4. Abrimos la puerta al mundo (Stage)
resource "aws_apigatewayv2_stage" "lambda_stage" {
  api_id      = aws_apigatewayv2_api.lambda_api.id
  name        = "$default"
  auto_deploy = true
}

# 5. Permiso: Le decimos a la Lambda que deje que la API la despierte
resource "aws_lambda_permission" "api_gw" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.mathias_lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.lambda_api.execution_arn}/*/*"
}

# 6. Esto hará que Terraform me imprima la URL en pantalla al terminar
output "url_final_proyecto" {
  value = "${aws_apigatewayv2_api.lambda_api.api_endpoint}/saludo"
}



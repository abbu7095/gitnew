data "archive_file" "fun" {
  type = "zip"
  source_file = "./python/function.py"
  output_path = "./python/function.zip"
}
resource "aws_lambda_function" "test_lambda" {
  filename      = "./python/function.zip"
  function_name = "terraform-lamda"
  role          = aws_iam_role.lambda_role.arn
  handler       = "function.lambda_handler"
  runtime       = "python3.9"
}
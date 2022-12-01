resource "aws_s3_bucket" "janu" {
  bucket = "teed"

  tags = {
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_object" "s3singleobject"{
  bucket = "teed
  key    = "tags.json"
  source = "D:\\Task\\tags.json"

}
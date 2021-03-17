provider "aws" {
    region   = "us-east-2"
    access_key = "AKIA3FPJTK7JACZKAPM7"
    secret_key = "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"

}
resource "aws_vpc" "vpc1" {
    cidr_block = "10.1.0.0/16"
    tags = merge(
        {
        "Name" = format("%s", var.name),
        },
        var.tags,
    )
}


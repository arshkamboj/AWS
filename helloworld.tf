provider "aws" {
    region = "eu-west-1"
    profile = "krugeraws-administrator"
}

resource "aws_s3_bucket" "mybucket" {
    bucket = "mybucket-kurger-test"
    acl = "private"

    tags = {
        Environment = "Dev"
    }

}

resource "aws_s3_bucket_object" "myfirstobject" {
    bucket ="${aws_s3_bucket.mybucket.id}"
    key= "tesfile.txt"
    source = "testfiles/sampleobject.txt"
    etag= "${md5(file("testfiles/sampleobject.txt"))}"

}
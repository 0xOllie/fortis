/*
  MySQL Database
*/

module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = var.name

  engine               = "mysql"
  family               = "mysql5.7"
  engine_version       = "5.7"
  major_engine_version = "5.7"

  instance_class    = "db.t3.micro"
  allocated_storage = 5

  db_name                = var.name
  username               = var.name
  port                   = "3306"
  db_subnet_group_name   = var.database_subnet_group_name
  subnet_ids             = var.database_subnet_ids
  vpc_security_group_ids = [aws_security_group.database.id]
}

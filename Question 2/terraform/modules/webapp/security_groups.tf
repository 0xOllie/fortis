/*
  Load Balancer Security Group
*/

resource "aws_security_group" "alb" {
  name        = "${var.name}_alb_security_group"
  description = "Security group for the ${var.name} ALB."
  vpc_id      = var.vpc_id
  ingress {
    description = "Internet HTTP access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description      = "Open Egress"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

/*
  Application Security Group
*/

resource "aws_security_group" "app" {
  name        = "${var.name}_app_security_group"
  description = "Security group for the ${var.name} server."
  vpc_id      = var.vpc_id
  egress {
    description      = "Open Egress"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_security_group_rule" "alb_ingress" {
  type                     = "ingress"
  security_group_id        = aws_security_group.app.id
  description              = "ALB to EC2 port 80"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.alb.id
}

resource "aws_security_group_rule" "bastion_ingress" {
  type                     = "ingress"
  security_group_id        = aws_security_group.app.id
  description              = "Bastion to EC2 port 22"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.bastion.id
}

/*
  Bastion Security Group
*/

resource "aws_security_group" "bastion" {
  name        = "${var.name}_bastion_security_group"
  description = "Security group for the ${var.name} bastion."
  vpc_id      = var.vpc_id
  ingress {
    description = "All SSH inbound"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description      = "Open Egress"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

/*
  Database Security Group
*/
resource "aws_security_group" "database" {
  name        = "${var.name}_database_security_group"
  description = "Security group for the ${var.name} database."
  vpc_id      = var.vpc_id
  egress {
    description      = "Open Egress"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_security_group_rule" "database_ingress" {
  type                     = "ingress"
  security_group_id        = aws_security_group.database.id
  description              = "MySQL Inbound from App"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.app.id
}

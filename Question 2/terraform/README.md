```
terraform init
terraform apply -target module.vpc
terraform apply -target module.webapp.aws_instance.app
terraform apply
```

https://developer.hashicorp.com/terraform/language/meta-arguments/for_each#limitations-on-values-used-in-for_each

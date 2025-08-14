# RDS Service on HuaweiCloud

For running the xpanse stack, we can use the RDS service on the HuaweiCloud instead of self-hosting the DB. This can be
used for demo as well as for production.

## Run Scripts

1. First the provider must be configured by adding the following environment variables in your command line session.
   All available values can be
   found [here](https://github.com/huaweicloud/terraform-provider-huaweicloud/blob/master/docs/index.md).

```shell
export HW_ACCESS_KEY="xxxxxxxx"
export HW_SECRET_KEY="xxxxxxxxx"
export HW_PROJECT_NAME="xxxxxxxxx" # optional. 
```

2. Update variable values using the `deployment.tfvars` file and then execute the scripts or directly execute the script
   and enter the variables on command
   prompt.

```shell
terraform init
terraform apply -var-file=deployment.tfvars -auto-approve # preferred way.
```

or

```shell
terraform init
terraform apply #this will ask the user to enter variables.
```

## Resources Created

1. Instance
2. Database on the instance
3. Application account on the database
4. Security rule to allow connections to the database
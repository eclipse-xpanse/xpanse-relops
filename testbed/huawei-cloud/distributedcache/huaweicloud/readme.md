# DCS Service on HuaweiCloud

For running the xpanse stack, we can use the DCS service on the HuaweiCloud instead of 
self-hosting the Redis. This can be used for demo as well as for production.

## Run Scripts

1. First the provider must be configured by adding the following environment variables in your command line session.
   All available values can be
   found [here](https://github.com/huaweicloud/terraform-provider-huaweicloud/blob/master/docs/index.md).

```shell
export HW_ACCESS_KEY="xxxxxxxx"
export HW_SECRET_KEY="xxxxxxxxx"
export HW_REGION_NAME="xxxxxxxxx"
export HW_PROJECT_NAME="xxxxxxxxx" # optional. 
```

2. Update variable values using the `deployment.tfvars` file and then execute the scripts or directly execute the script
   and enter the variables on command prompt.

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

1. Redis Instance
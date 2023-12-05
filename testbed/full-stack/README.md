# Full Stack Single Node Installation

The scripts and config here are used to install complete xpanse stack under a single node using docker-compose. The same
is used also for installing our test bed. This full stack consist of the following components

- xpanse-runtime
- mysql
- xpanse-ui
- terraform-boot
- policy-man
- opentelemetry-collector
- grafana
- loki
- tempo
- prometheus

## Start Full Stack

1. Checkout this repository.
2. Update versions of docker images if necessary.
3. Update DB passwords in environment config files - [xpanse-runtime](.xpanse.env) and [database](.mysql.db.env).
4. Start the stack using below command

```shell
docker-compose up -d
```

> Note: This stack is configured to run using Zitadel Oauth. Current configuration in the docker-compose is using our
> Zitadel testbed instance. If you intend to use any other Zitadel or oauth instance, then the respetive configurations
> in docker-compose file must be updated.

## Load balancer Config

Currently, the nginx runs as a standalone process on the node and not as a docker container.
The configuration in the [nginx](nginx) folder can be used to configure nginx to handle requests to UI, swagger UIs and
grafana UI

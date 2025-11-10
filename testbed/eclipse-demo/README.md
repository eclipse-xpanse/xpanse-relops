# Xpanse Full Stack on Eclipse Foundation's Demo VM

This setup is different compared to our other test beds. 
Here, we install all components including the IAM applications on the same server.

## Components

1. Standalone NGINX container routing requests between different applications. 
2. All other applications are started using one single docker-compose.yml
3. NGINX container and all other applications share the same docker network. 

## Installation Steps

1. Create Docker Network using script in [create-docker-network.sh](./create-docker-network.sh). 
2. Start zitadel containers using the docker-compose in `zitadel-iam` repository under `zitadel/eclipse-demo` folder.  
3. Setup Zitadel using the Terraform scripts in the `zitadel-iam` repository. 
4. Now add new Zitadel configuration to [docker-compose.yml](./docker-compose.yml) and start it.
5. Start NGINX container using the command in [start-docker.sh](./nginx/start-docker.sh).

```shell
terraform init
terraform apply -auto-approve -var-file=environments/local.tfvars
```

## Starting NGINX container

```ssh
sudo docker run --network xpanse-demo-network --name nginx -p 443:443 -v /etc/letsencrypt/:/etc/letsencrypt/ -v ./conf.d/:/etc/nginx/conf.d -d nginx:latest
```

## SSL Certificates

Certificates for the **xpanse-demo.eclipseprojects.io** domain can be renewed or recreated using the certbot command below.
The certificates are on the VM but the directory is mounted inside the NGINX docker container.

```ssh
sudo certbot certonly --standalone --certname xpanse-demo.eclipseprojects.io
sudo docker restart nginx
```
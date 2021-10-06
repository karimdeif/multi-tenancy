#!/bin/bash

# **** Global variables

export REGISTRY=localmachine
export IMAGE_NAME=service_catalog_local
export IMAGE_TAG=v1

# default
export default_datasource_base_certs="5df929c2-b76a-11e9-b3dd-4acf6c229d45"
export default_datasource_mycompany_certs="2b11af40-8aa6-4b13-a424-1a9109624264"
export default_datasource_certs_data="MIIDDzCCAfegAwIBAgIJANEH58y2/F3xMvTMoy35DcT3E2ZeSVjouZs15O90kI3k2daS2OHJABW0vSj4nLz+PQzp/B9cQmOO8dCe049Q3oaUA=="

export default_datasource_base_certs_data="MIIDDzCCAfegAwIBAgIJANEH58y2/kzHMA0GCSqGSIb3DQEBCwUAMB4xHDAa5zB=="

export "default_datasource_mycompany_certs_data=MIIDDzCCAfegAwIBAgIJANix26qJEuqFG0IP57QQI5TCRJ6Xt/supRHo63eDvKw8zR7tlWQ9Q3oaUA=="

# **********************************************************************************
# Execution
# **********************************************************************************

# Show output
set -x

# Set the right directory
cd ../code/service-catalog-tmp

# Build the image
docker container stop -f  "service-catalog-verification"
docker container rm -f "service-catalog-verification"
docker image rm -f "$REGISTRY/$IMAGE_NAME:$IMAGE_TAG"
docker build  --file Dockerfile \
              --tag "$REGISTRY/$IMAGE_NAME:$IMAGE_TAG" .

docker run --name="service-catalog-verification" \
           -it \
           --env default_datasource_certs=${default_datasource_base_certs} \
           --env default_datasource_certs_data=${default_datasource_certs_data} \
           --env default.datasource.username=${default_datasource_username} \
           --env default.datasource.password=${default_datasource_password} \
           --env default.datasource.jdbc.url=${default_datasource_jdbc_url} \
           --env default.datasource.base.certs=${default_datasource_base_certs} \
           --env default.datasource.base.certs.data=${default_datasource_base_certs_data} \
           --env default.datasource.base.username=${default_datasource_base_username} \
           --env default.datasource.base.password=${default_datasource_base_password} \
           --env default.datasource.base.jdbc.url=${default_datasource_base_jdbc_url} \
           --env default.datasource.mycompany.certs=${default_datasource_mycompany_certs} \
           --env default.datasource.mycompany.certs.data=${default_datasource_mycompany_certs_data} \
           -p 8080:8080/tcp \
           "$REGISTRY/$IMAGE_NAME:$IMAGE_TAG"
                           


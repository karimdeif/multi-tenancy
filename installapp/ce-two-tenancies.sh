#!/bin/bash

# CLI Documentation
# ================
# command documentation: https://cloud.ibm.com/docs/codeengine?topic=codeengine-cli#cli-application-create

# **************** Global variables

# Code Engine
#export PROJECT_NAME_A=multi-tenancy-serverless-a
export PROJECT_NAME_A=multi-tenancy-serverless-tmp-v2
export PROJECT_NAME_B=multi-tenancy-serverless-b

# Applications
export SERVICE_CATALOG_NAME_A="service-catalog-a"
export FRONTEND_NAME_A="frontend-a"

export SERVICE_CATALOG_NAME_B="service-catalog-b"
export FRONTEND_NAME_B="frontend-b"

# IBM CLoud CR
#export SERVICE_CATALOG_IMAGE="us.icr.io/multi-tenancy-cr/service-catalog:latest"
#export FRONTEND_IMAGE="us.icr.io/multi-tenancy-cr/frontend:latest"

# Quay and Docker
export SERVICE_CATALOG_IMAGE="quay.io/tsuedbroecker/multi-tenancy-service-catalog:v1"
export FRONTEND_IMAGE="quay.io/tsuedbroecker/multi-tenancy-frontend:v1"
#export SERVICE_CATALOG_IMAGE="docker.io/karimdeif/service-catalog-quarkus-reactive:1.0.0-SNAPSHOT"
#export FRONTEND_IMAGE="quay.io/kdeif/frontend:v0.0"

# App ID
export APPID_SERVICE_INSTANCE_NAME_A="multi-tenancy-serverless-appid-a"
export APPID_SERVICE_KEY_NAME_A="multi-tenancy-serverless-appid-key-a"

export APPID_SERVICE_INSTANCE_NAME_B="multi-tenancy-serverless-appid-b"
export APPID_SERVICE_KEY_NAME_B="multi-tenancy-serverless-appid-key-b"

# Postgres
export POSTGRES_SERVICE_INSTANCE_A=multi-tenant-pg-a
export POSTGRES_SERVICE_INSTANCE_B=multi-tenant-pg-b

# **********************************************************************************
# Functions definition
# **********************************************************************************

#TBD

# **********************************************************************************
# Execution
# **********************************************************************************

echo "************************************"
echo " Tenant A"
echo "************************************"

bash ./temp-database-ce-install-application-ibmcr.sh $PROJECT_NAME_A \
                                                     $APPID_SERVICE_INSTANCE_NAME_A \
                                                     $APPID_SERVICE_KEY_NAME_A \
                                                     $SERVICE_CATALOG_NAME_A \
                                                     $FRONTEND_NAME_A \
                                                     $SERVICE_CATALOG_IMAGE \
                                                     $FRONTEND_IMAGE

echo "************************************"
echo " Tenant B"
echo "************************************"

# bash ./temp-database-ce-install-application-ibmcr.sh $PROJECT_NAME_A
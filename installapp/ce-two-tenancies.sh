#!/bin/bash

# CLI Documentation
# ================
# command documentation: https://cloud.ibm.com/docs/codeengine?topic=codeengine-cli#cli-application-create

# **************** Global variables

# Code Engine
export PROJECT_NAME_A=multi-tenancy-serverless-a
export PROJECT_NAME_B=multi-tenancy-serverless-b

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

# **********************************************************************************
# Execution
# **********************************************************************************

echo "************************************"
echo " Tenant A"
echo "************************************"

bash ./temp-database-ce-install-application-ibmcr.sh $PROJECT_NAME_A

echo "************************************"
echo " Tenant B"
echo "************************************"

# bash ./temp-database-ce-install-application-ibmcr.sh $PROJECT_NAME_A
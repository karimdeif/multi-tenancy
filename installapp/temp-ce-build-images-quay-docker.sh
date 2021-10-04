#!/bin/bash

# **************** Global variables
export REPOSITORY=tsuedbroecker
export SERVICE_CATALOG="multi-tenancy-service-catalog:v1"
export FRONTEND="multi-tenancy-frontend:v1"

# **********************************************************************************
# Execution
# **********************************************************************************

cd ..
export ROOT_PATH=$(PWD)
echo "Path: $ROOT_PATH"

echo "************************************"
echo " Clean up container if needed"
echo "************************************"
unalias docker
docker image list
docker container list
docker image prune -a -f
docker version
docker image rm -f "$SERVICE_CATALOG"
docker image rm -f "$FRONTEND"

echo "************************************"
echo " Service catalog $SERVICE_CATALOG"
echo "************************************"
cd $ROOT_PATH/code/service-catalog
pwd
docker login quay.io
docker build -t "quay.io/$REPOSITORY/$SERVICE_CATALOG" -f Dockerfile .
docker push "quay.io/$REPOSITORY/$SERVICE_CATALOG"

echo ""

echo "************************************"
echo " Frontend $FRONTEND"
echo "************************************"
cd $ROOT_PATH/code/frontend

docker login quay.io
docker build -t "quay.io/$REPOSITORY/$FRONTEND" -f Dockerfile.os4-webapp .
docker push "quay.io/$REPOSITORY/$FRONTEND"

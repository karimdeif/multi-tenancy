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
docker image list
docker container list
#docker container stop -f  "TBD"
#docker container rm -f "TBD"
#docker image prune -a -f
docker image rm -f "$SERVICE_CATALOG"
docker image rm -f "$FRONTEND"
# rm -rf ~/var/home/core/.local/share/containers/storage/overlay/* f
#docker image rm -f "docker.io/adoptopenjdk/maven-openjdk11"
#docker image rm -f "docker.io/adoptopenjdk/openjdk11-openj9:ubi-minimal"
#docker image rm -f "registry.access.redhat.com/ubi8/ubi-minimal"

echo "************************************"
echo " Service catalog $SERVICE_CATALOG"
echo "************************************"
cd $ROOT_PATH/code/service-catalog-tmp
pwd
docker login quay.io
docker build -t "quay.io/$REPOSITORY/$SERVICE_CATALOG" -f Dockerfile.simple .
# docker push "quay.io/$REPOSITORY/$SERVICE_CATALOG"

echo ""

echo "************************************"
echo " Frontend $FRONTEND"
echo "************************************"
cd $ROOT_PATH/code/frontend
#pwd
# docker login quay.io
# docker build -t "quay.io/$REPOSITORY/$FRONTEND" -f Dockerfile.os4-webapp .
# docker push "quay.io/$REPOSITORY/$FRONTEND"

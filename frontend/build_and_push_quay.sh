#!/bin/bash
export REPOSITORY=$MY_REPOSITORY # Example to set the variable: export MY_REPOSITORY=tsuedbroecker

echo "************************************"
echo " frontend"
echo "************************************"
docker login quay.io

echo "************************************"
echo " Build frontend"
echo "************************************"
docker build -t "quay.io/$REPOSITORY/frontend:v0.0" -f Dockerfile.os4-webapp .

echo "************************************"
echo " Test frontend container in interactive mode"
echo " -d or -it"
echo "************************************"

docker run --name="frontend" \
           -d \
           -e VUE_APPID_CLIENT_ID='b3adeb3b-36fc-40cb-9bc3-dd6f15047195' \
           -e VUE_APPID_DISCOVERYENDPOINT='https://us-south.appid.cloud.ibm.com/oauth/v4/a7ec8ce4-3602-42c7-8e88-6f8a9db31935/.well-known/openid-configuration' \
           -e VUE_APP_API_URL_PRODUCTS="http://service-catalog-quarkus-reactive-app-mod-tekton-dev.niklas-heidloff-dal12-b-162e406f043e20da9b0ef0731954a894-0000.us-south.containers.appdomain.cloud/CustomerOrderServicesWeb/jaxrs/Product/?categoryId=" \
           -e VUE_APP_API_URL_ORDERS="http://localhost/CustomerOrderServicesWeb/jaxrs/Customer/Orders" \
           -e VUE_APP_CATEGORY_NANE="Movies" \
           -e VUE_APP_HEADLINE="Hi, I run in the container" \
           -p 8080:8081 \
           "quay.io/$REPOSITORY/frontend:v0.0"

echo "************************************"
echo "Push frontend"
echo "************************************"
docker push "quay.io/$REPOSITORY/frontend:v0.0"

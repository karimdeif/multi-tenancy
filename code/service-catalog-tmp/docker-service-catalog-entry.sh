#!/bin/bash

export info=$(pwd)

echo "**********************************"
echo "-> Log: Root path: '$info'"
echo "-> Log: Check env variables:" 
echo " '$default.datasource.certs'"
echo " '$default.datasource.certs.data'"
echo " '$POSTGRES_cert_content'"

export CERT_FILE_NAME=./outside_location/mycert
"/bin/sh" ./create-service-catalog-cert.sh
more ./create-service-catalog-cert.sh
more ./outside_location/mycert


echo "**********************************"
echo "Execute java command "
echo "**********************************"

java -Xmx128m \
     -Xscmaxaot100m \
     -XX:+IdleTuningGcOnIdle \
     -Xtune:virtualized \
     -Xscmx128m \
     -Xshareclasses:cacheDir=/opt/shareclasses \
     -jar \
     /deployments/quarkus-run.jar

#java -Xmx128m \
#     -Xscmaxaot100m \
#     -XX:+IdleTuningGcOnIdle \
#     -Xtune:virtualized \
#     -Xscmx128m \
#     -Xshareclasses:cacheDir=/opt/shareclasses \
#     -D_POSTGRES_1=${POSTGRES_1} \
#     -D_POSTGRES_2=${POSTGRES_2} \
#     -D_CERT_FILE_NAME=${CERT_FILE_NAME} \
#     - cp D_CERT_FILE_NAME \
#     -jar \
#     /deployments/quarkus-run.jar

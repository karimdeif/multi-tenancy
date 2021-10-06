#!/bin/bash
# uncomment to debug the script
#set -x
# copy the script below into your app code repo (e.g. ./scripts/build_image.sh) and 'source' it from your pipeline job
#    source ./scripts/build_image.sh
# alternatively, you can source it from online script:
#    source <(curl -sSL "https://raw.githubusercontent.com/open-toolchain/commons/master/scripts/build_image.sh")
# ------------------
# source: https://raw.githubusercontent.com/open-toolchain/commons/master/scripts/build_image.sh

# This script does build a Docker image into IBM Container Service private image registry, and copies information into
# a build.properties file, so they can be reused later on by other scripts (e.g. image url, chart name, ...)
echo "REGISTRY_URL=${REGISTRY_URL}"
echo "REGISTRY_NAMESPACE=${REGISTRY_NAMESPACE}"
echo "IMAGE_NAME=${IMAGE_NAME}"
echo "BUILD_NUMBER=${BUILD_NUMBER}"
echo "ARCHIVE_DIR=${ARCHIVE_DIR}"
echo "GIT_BRANCH=${GIT_BRANCH}"
echo "GIT_COMMIT=${GIT_COMMIT}"
echo "DOCKER_ROOT=${DOCKER_ROOT}"
echo "DOCKER_FILE=${DOCKER_FILE}"

echo "default.datasource.base.certs=${default_datasource_base_certs}"
export default.datasource.base.certs="${default.datasource.base.certs:=5df929c2-b76a-11e9-b3dd-4acf6c229d45}"

echo "default.datasource.base.certs=${default.datasource.base.certs}"


echo "default.datasource.base.certs=${default.datasource.base.certs}"

echo "default.datasource.mycompany.certs=${default.datasource.mycompany.certs:2b11af40-8aa6-4b13-a424-1a9109624264}"

echo "default.datasource.certs.data=${default.datasource.certs.data:-----BEGIN CERTIFICATE-----
                                                                    MIIDDzCCAfegAwIBAgIJANEH58y2/kzHMA0GCSqGSIb3DQEBCwUAMB4xHDAaBgNV
                                                                    BAMME0lCTSBDbG91ZCBEYXRhYmFzZXMwHhcNMTgwNjI1MTQyOTAwWhcNMjgwNjIy
                                                                    MTQyOTAwWjAeMRwwGgYDVQQDDBNJQk0gQ2xvdWQgRGF0YWJhc2VzMIIBIjANBgkq
                                                                    hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA8lpaQGzcFdGqeMlmqjffMPpIQhqpd8qJ
                                                                    Pr3bIkrXJbTcJJ9uIckSUcCjw4Z/rSg8nnT13SCcOl+1to+7kdMiU8qOWKiceYZ5
                                                                    y+yZYfCkGaiZVfazQBm45zBtFWv+AB/8hfCTdNF7VY4spaA3oBE2aS7OANNSRZSK
                                                                    pwy24IUgUcILJW+mcvW80Vx+GXRfD9Ytt6PRJgBhYuUBpgzvngmCMGBn+l2KNiSf
                                                                    weovYDCD6Vngl2+6W9QFAFtWXWgF3iDQD5nl/n4mripMSX6UG/n6657u7TDdgkvA
                                                                    1eKI2FLzYKpoKBe5rcnrM7nHgNc/nCdEs5JecHb1dHv1QfPm6pzIxwIDAQABo1Aw
                                                                    TjAdBgNVHQ4EFgQUK3+XZo1wyKs+DEoYXbHruwSpXjgwHwYDVR0jBBgwFoAUK3+X
                                                                    Zo1wyKs+DEoYXbHruwSpXjgwDAYDVR0TBAUwAwEB/zANBgkqhkiG9w0BAQsFAAOC
                                                                    AQEAJf5dvlzUpqaix26qJEuqFG0IP57QQI5TCRJ6Xt/supRHo63eDvKw8zR7tlWQ
                                                                    lV5P0N2xwuSl9ZqAJt7/k/3ZeB+nYwPoyO3KvKvATunRvlPBn4FWVXeaPsG+7fhS
                                                                    qsejmkyonYw77HRzGOzJH4Zg8UN6mfpbaWSsyaExvqknCp9SoTQP3D67AzWqb1zY
                                                                    doqqgGIZ2nxCkp5/FXxF/TMb55vteTQwfgBy60jVVkbF7eVOWCv0KaNHPF5hrqbN
                                                                    i+3XjJ7/peF3xMvTMoy35DcT3E2ZeSVjouZs15O90kI3k2daS2OHJABW0vSj4nLz
                                                                    +PQzp/B9cQmOO8dCe049Q3oaUA==
                                                                    -----END CERTIFICATE-----

                                        }"

echo "default.datasource.base.certs.data=${default.datasource.base.certs.data:-----BEGIN CERTIFICATE-----
                                                                    MIIDDzCCAfegAwIBAgIJANEH58y2/kzHMA0GCSqGSIb3DQEBCwUAMB4xHDAaBgNV
                                                                    BAMME0lCTSBDbG91ZCBEYXRhYmFzZXMwHhcNMTgwNjI1MTQyOTAwWhcNMjgwNjIy
                                                                    MTQyOTAwWjAeMRwwGgYDVQQDDBNJQk0gQ2xvdWQgRGF0YWJhc2VzMIIBIjANBgkq
                                                                    hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA8lpaQGzcFdGqeMlmqjffMPpIQhqpd8qJ
                                                                    Pr3bIkrXJbTcJJ9uIckSUcCjw4Z/rSg8nnT13SCcOl+1to+7kdMiU8qOWKiceYZ5
                                                                    y+yZYfCkGaiZVfazQBm45zBtFWv+AB/8hfCTdNF7VY4spaA3oBE2aS7OANNSRZSK
                                                                    pwy24IUgUcILJW+mcvW80Vx+GXRfD9Ytt6PRJgBhYuUBpgzvngmCMGBn+l2KNiSf
                                                                    weovYDCD6Vngl2+6W9QFAFtWXWgF3iDQD5nl/n4mripMSX6UG/n6657u7TDdgkvA
                                                                    1eKI2FLzYKpoKBe5rcnrM7nHgNc/nCdEs5JecHb1dHv1QfPm6pzIxwIDAQABo1Aw
                                                                    TjAdBgNVHQ4EFgQUK3+XZo1wyKs+DEoYXbHruwSpXjgwHwYDVR0jBBgwFoAUK3+X
                                                                    Zo1wyKs+DEoYXbHruwSpXjgwDAYDVR0TBAUwAwEB/zANBgkqhkiG9w0BAQsFAAOC
                                                                    AQEAJf5dvlzUpqaix26qJEuqFG0IP57QQI5TCRJ6Xt/supRHo63eDvKw8zR7tlWQ
                                                                    lV5P0N2xwuSl9ZqAJt7/k/3ZeB+nYwPoyO3KvKvATunRvlPBn4FWVXeaPsG+7fhS
                                                                    qsejmkyonYw77HRzGOzJH4Zg8UN6mfpbaWSsyaExvqknCp9SoTQP3D67AzWqb1zY
                                                                    doqqgGIZ2nxCkp5/FXxF/TMb55vteTQwfgBy60jVVkbF7eVOWCv0KaNHPF5hrqbN
                                                                    i+3XjJ7/peF3xMvTMoy35DcT3E2ZeSVjouZs15O90kI3k2daS2OHJABW0vSj4nLz
                                                                    +PQzp/B9cQmOO8dCe049Q3oaUA==
                                                                    -----END CERTIFICATE-----

                                        }"

echo "default.datasource.mycompany.certs.data=${default.datasource.mycompany.certs.data:-----BEGIN CERTIFICATE-----
                                                                    MIIDDzCCAfegAwIBAgIJANEH58y2/kzHMA0GCSqGSIb3DQEBCwUAMB4xHDAaBgNV
                                                                    BAMME0lCTSBDbG91ZCBEYXRhYmFzZXMwHhcNMTgwNjI1MTQyOTAwWhcNMjgwNjIy
                                                                    MTQyOTAwWjAeMRwwGgYDVQQDDBNJQk0gQ2xvdWQgRGF0YWJhc2VzMIIBIjANBgkq
                                                                    hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA8lpaQGzcFdGqeMlmqjffMPpIQhqpd8qJ
                                                                    Pr3bIkrXJbTcJJ9uIckSUcCjw4Z/rSg8nnT13SCcOl+1to+7kdMiU8qOWKiceYZ5
                                                                    y+yZYfCkGaiZVfazQBm45zBtFWv+AB/8hfCTdNF7VY4spaA3oBE2aS7OANNSRZSK
                                                                    pwy24IUgUcILJW+mcvW80Vx+GXRfD9Ytt6PRJgBhYuUBpgzvngmCMGBn+l2KNiSf
                                                                    weovYDCD6Vngl2+6W9QFAFtWXWgF3iDQD5nl/n4mripMSX6UG/n6657u7TDdgkvA
                                                                    1eKI2FLzYKpoKBe5rcnrM7nHgNc/nCdEs5JecHb1dHv1QfPm6pzIxwIDAQABo1Aw
                                                                    TjAdBgNVHQ4EFgQUK3+XZo1wyKs+DEoYXbHruwSpXjgwHwYDVR0jBBgwFoAUK3+X
                                                                    Zo1wyKs+DEoYXbHruwSpXjgwDAYDVR0TBAUwAwEB/zANBgkqhkiG9w0BAQsFAAOC
                                                                    AQEAJf5dvlzUpqaix26qJEuqFG0IP57QQI5TCRJ6Xt/supRHo63eDvKw8zR7tlWQ
                                                                    lV5P0N2xwuSl9ZqAJt7/k/3ZeB+nYwPoyO3KvKvATunRvlPBn4FWVXeaPsG+7fhS
                                                                    qsejmkyonYw77HRzGOzJH4Zg8UN6mfpbaWSsyaExvqknCp9SoTQP3D67AzWqb1zY
                                                                    doqqgGIZ2nxCkp5/FXxF/TMb55vteTQwfgBy60jVVkbF7eVOWCv0KaNHPF5hrqbN
                                                                    i+3XjJ7/peF3xMvTMoy35DcT3E2ZeSVjouZs15O90kI3k2daS2OHJABW0vSj4nLz
                                                                    +PQzp/B9cQmOO8dCe049Q3oaUA==
                                                                    -----END CERTIFICATE-----

                                        }"



# also run 'env' command to find all available env variables
# or learn more about the available environment variables at:
# https://console.bluemix.net/docs/services/ContinuousDelivery/pipeline_deploy_var.html#deliverypipeline_environment

# To review or change build options use:
# bx cr build --help

set -x

cd /workspace/code/service-catalog-tmp/

cat ${default.datasource.certs.data} > src/main/resources/${default.datasource.base.certs}
cat ${default.datasource.mycompany.certs.data} > src/main/resources/${default.datasource.mycompany.certs}

chmod 777 mvnw

./mvnw package

#ibmcloud cr build --file Dockerfile --tag ${REGISTRY_URL}/${REGISTRY_NAMESPACE}/${IMAGE_NAME}:${IMAGE_TAG} .
ibmcloud cr build --file Dockerfile --tag ${REGISTRY_URL}/${REGISTRY_NAMESPACE}/${IMAGE_NAME}:latest .
set +x

ibmcloud cr image-inspect ${REGISTRY_URL}/${REGISTRY_NAMESPACE}/${IMAGE_NAME}:latest

# Set PIPELINE_IMAGE_URL for subsequent jobs in stage (e.g. Vulnerability Advisor)
export PIPELINE_IMAGE_URL="$REGISTRY_URL/$REGISTRY_NAMESPACE/$IMAGE_NAME:latest"

ibmcloud cr images --restrict ${REGISTRY_NAMESPACE}/${IMAGE_NAME}

######################################################################################
# Copy any artifacts that will be needed for deployment and testing to $WORKSPACE    #
######################################################################################
echo "=========================================================="
echo "COPYING ARTIFACTS needed for deployment and testing (in particular build.properties)"

echo "Checking archive dir presence"
if [ -z "${ARCHIVE_DIR}" ]; then
  echo -e "Build archive directory contains entire working directory."
else
  echo -e "Copying working dir into build archive directory: ${ARCHIVE_DIR} "
  mkdir -p ${ARCHIVE_DIR}
  find . -mindepth 1 -maxdepth 1 -not -path "./$ARCHIVE_DIR" -exec cp -R '{}' "${ARCHIVE_DIR}/" ';'
fi

# Persist env variables into a properties file (build.properties) so that all pipeline stages consuming this
# build as input and configured with an environment properties file valued 'build.properties'
# will be able to reuse the env variables in their job shell scripts.

# If already defined build.properties from prior build job, append to it.
cp build.properties $ARCHIVE_DIR/ || :

# IMAGE information from build.properties is used in Helm Chart deployment to set the release name
echo "IMAGE_NAME=${IMAGE_NAME}" >> $ARCHIVE_DIR/build.properties
echo "IMAGE_TAG=${IMAGE_TAG}" >> $ARCHIVE_DIR/build.properties
# REGISTRY information from build.properties is used in Helm Chart deployment to generate cluster secret
echo "REGISTRY_URL=${REGISTRY_URL}" >> $ARCHIVE_DIR/build.properties
echo "REGISTRY_NAMESPACE=${REGISTRY_NAMESPACE}" >> $ARCHIVE_DIR/build.properties
echo "GIT_BRANCH=${GIT_BRANCH}" >> $ARCHIVE_DIR/build.properties
echo "File 'build.properties' created for passing env variables to subsequent pipeline jobs:"
cat $ARCHIVE_DIR/build.properties

#!/bin/bash
# uncomment to debug the script
#set -x
# copy the script below into your app code repo (e.g. ./scripts/deploy_kubectl.sh) and 'source' it from your pipeline job
#    source ./scripts/deploy_kubectl.sh
# alternatively, you can source it from online script:
#    source <(curl -sSL "https://raw.githubusercontent.com/open-toolchain/commons/master/scripts/deploy_kubectl.sh")
# ------------------
# source: https://raw.githubusercontent.com/open-toolchain/commons/master/scripts/deploy_kubectl.sh
# Input env variables (can be received via a pipeline environment properties.file.
echo "IMAGE_NAME=${IMAGE_NAME}"
echo "IMAGE_TAG=${IMAGE_TAG}"
echo "REGISTRY_URL=${REGISTRY_URL}"
echo "REGISTRY_NAMESPACE=${REGISTRY_NAMESPACE}"
echo "DEPLOYMENT_FILE=${DEPLOYMENT_FILE}"


echo "default.datasource.certs=${default.datasource.certs:5df929c2-b76a-11e9-b3dd-4acf6c229d45}"
echo "default.datasource.username=${default.datasource.username:ibm_cloud_a66ff784_d8a6_4545_bb4c_b24dec4e02b8}"
echo "default.datasource.password=${default.datasource.password:7f5dfe3c8d3eabcf52d15a7b81ce845a013e681ed753e063a4be3276a4461530}"
echo "default.datasource.jdbc.url=${default.datasource.jdbc.url:jdbc:postgresql://3bd53622-20ce-426b-8232-cf6a3d0c52ce.bkvfv1ld0bj2bdbncbeg.databases.appdomain.cloud:30143/ibmclouddb}"

echo "default.datasource.base.certs=${default.datasource.base.certs:5df929c2-b76a-11e9-b3dd-4acf6c229d45}"
echo "default.datasource.base.username=${default.datasource.base.username:ibm_cloud_a66ff784_d8a6_4545_bb4c_b24dec4e02b8}"
echo "default.datasource.base.password=${default.datasource.base.password:7f5dfe3c8d3eabcf52d15a7b81ce845a013e681ed753e063a4be3276a4461530}"
echo "default.datasource.base.jdbc.url=${default.datasource.base.jdbc.url:jdbc:postgresql://3bd53622-20ce-426b-8232-cf6a3d0c52ce.bkvfv1ld0bj2bdbncbeg.databases.appdomain.cloud:30143/ibmclouddb}"

echo "default.datasource.mycompany.certs=${default.datasource.mycompany.certs:2b11af40-8aa6-4b13-a424-1a9109624264}"
echo "default.datasource.mycompany.username=${default.datasource.mycompany.username:ibm_cloud_27df2776_ca1d_4e5d_acc8_79e557a60482}"
echo "default.datasource.mycompany.password=${default.datasource.mycompany.password:1381b9739602be4254a0dedd56a5093f1d641414b3714643c3a8003b10efe146}"
echo "default.datasource.mycompany.jdbc.url=${default.datasource.mycompany.jdbc.url:jdbc:postgresql://5e6b66a4-70b6-4caf-be8b-23cd2d1ed26b.c00no9sd0hobi6kj68i0.databases.appdomain.cloud:30266/ibmclouddb}"

set -x
#kubectl apply --namespace ${CLUSTER_NAMESPACE} -f ${DEPLOYMENT_FILE} 

ibmcloud plugin install code-engine
ibmcloud resource groups
ibmcloud target -g Default
ibmcloud ce project select --name multi-tenant
#ibmcloud ce registry create --name ibm-container-registry --server us.icr.io --username iamapikey --password $API

ibmcloud ce application create --name service-catalog-a --image us.icr.io/multi-tenancy-cr/service-catalog:latest \
                                                        --port 8081 --rs test \
                                                        --env default.datasource.certs=${default.datasource.certs} \
                                                        --env default.datasource.username=${default.datasource.username} \
                                                        --env default.datasource.password=${default.datasource.password} \
                                                        --env default.datasource.jdbc.url=${default.datasource.jdbc.url} \
                                                        --env default.datasource.base.certs=${default.datasource.base.certs} \
                                                        --env default.datasource.base.username=${default.datasource.base.username} \
                                                        --env default.datasource.base.password=${default.datasource.base.password} \
                                                        --env default.datasource.base.jdbc.url=${default.datasource.base.jdbc.url} \
                                                        --env default.datasource.mycompany.certs=${default.datasource.mycompany.certs} \
                                                        --env default.datasource.mycompany.username=${default.datasource.mycompany.username} \
                                                        --env default.datasource.mycompany.password=${default.datasource.mycompany.password} \
                                                        --env default.datasource.mycompany.jdbc.url=${default.datasource.mycompany.jdbc.url}

set +x

echo ""
echo "=========================================================="
IMAGE_REPOSITORY=${REGISTRY_URL}/${REGISTRY_NAMESPACE}/${IMAGE_NAME}
echo -e "CHECKING deployment status of ${IMAGE_REPOSITORY}:${IMAGE_TAG}"
echo ""
#for ITERATION in {1..30}
#do
#  DATA=$( kubectl get pods --namespace ${CLUSTER_NAMESPACE} -o json )
#  NOT_READY=$( echo $DATA | jq '.items[].status | select(.containerStatuses!=null) | .containerStatuses[] | select(.image=="'"${IMAGE_REPOSITORY}:${IMAGE_TAG}"'") | select(.ready==false) ' )
#  if [[ -z "$NOT_READY" ]]; then
#    echo -e "All pods are ready:"
#    echo $DATA | jq '.items[].status | select(.containerStatuses!=null) | .containerStatuses[] | select(.image=="'"${IMAGE_REPOSITORY}:${IMAGE_TAG}"'") | select(.ready==true) '
#    break # deployment succeeded
#  fi
#  REASON=$(echo $DATA | jq '.items[].status | select(.containerStatuses!=null) | .containerStatuses[] | select(.image=="'"${IMAGE_REPOSITORY}:${IMAGE_TAG}"'") | .state.waiting.reason')
#  echo -e "${ITERATION} : Deployment still pending..."
#  echo -e "NOT_READY:${NOT_READY}"
#  echo -e "REASON: ${REASON}"
#  if [[ ${REASON} == *ErrImagePull* ]] || [[ ${REASON} == *ImagePullBackOff* ]]; then
#    echo "Detected ErrImagePull or ImagePullBackOff failure. "
#    echo "Please check proper authenticating to from cluster to image registry (e.g. image pull secret)"
#    break; # no need to wait longer, error is fatal
#  elif [[ ${REASON} == *CrashLoopBackOff* ]]; then
#    echo "Detected CrashLoopBackOff failure. "
#    echo "Application is unable to start, check the application startup logs"
#    break; # no need to wait longer, error is fatal
#  fi
#  sleep 5
#done

#APP_NAME=$(kubectl get pods --namespace ${CLUSTER_NAMESPACE} -o json | jq -r '[ .items[] | select(.spec.containers[]?.image=="'"${IMAGE_REPOSITORY}:${IMAGE_TAG}"'") | .metadata.labels.app] [1]')
#echo -e "APP: ${APP_NAME}"
#echo "DEPLOYED PODS:"
#kubectl describe pods --selector app=${APP_NAME} --namespace ${CLUSTER_NAMESPACE}
#if [ ! -z "${APP_NAME}" ]; then
#  APP_SERVICE=$(kubectl get services --namespace ${CLUSTER_NAMESPACE} -o json | jq -r ' .items[] | select (.spec.selector.app=="'"${APP_NAME}"'") | .metadata.name ')
#  echo -e "SERVICE: ${APP_SERVICE}"
#  echo "DEPLOYED SERVICES:"
#  kubectl describe services ${APP_SERVICE} --namespace ${CLUSTER_NAMESPACE}
#fi
#echo "Application Logs"
#kubectl logs --selector app=${APP_NAME} --namespace ${CLUSTER_NAMESPACE}  
echo ""
#if [[ ! -z "$NOT_READY" ]]; then
#  echo ""
#  echo "=========================================================="
#  echo "DEPLOYMENT FAILED"
#  exit 1
#fi

echo ""
echo "=========================================================="
echo "DEPLOYMENT SUCCEEDED"
#if [ ! -z "${APP_SERVICE}" ]; then
#  echo ""
  # check if a route resource exists in the this kubernetes cluster
#  if kubectl explain route > /dev/null 2>&1; then
    # Assuming the kubernetes target cluster is an openshift cluster
    # Check if a route exists for exposing the service ${APP_SERVICE}
#    if  kubectl get routes --namespace ${CLUSTER_NAMESPACE} -o json | jq --arg service "$APP_SERVICE" -e '.items[] | select(.spec.to.name==$service)'; then
#      echo "Existing route to expose service $APP_SERVICE"
#    else
#      # create OpenShift route
#cat > test-route.json << EOF
#{"apiVersion":"route.openshift.io/v1","kind":"Route","metadata":{"name":"${APP_SERVICE}"},"spec":{"to":{"kind":"Service","name":"${APP_SERVICE}"}}}
#EOF
#      echo ""
#      cat test-route.json
#      kubectl apply -f test-route.json --validate=false --namespace ${CLUSTER_NAMESPACE}
#      kubectl get routes --namespace ${CLUSTER_NAMESPACE}
#    fi
#    echo "LOOKING for host in route exposing service $APP_SERVICE"
#    IP_ADDR=$(kubectl get routes --namespace ${CLUSTER_NAMESPACE} -o json | jq --arg service "$APP_SERVICE" -r '.items[] | select(.spec.to.name==$service) | .status.ingress[0].host')
#    PORT=80
#  else 
#    IP_ADDR=$(bx cs workers --cluster ${PIPELINE_KUBERNETES_CLUSTER_NAME} | grep normal | head -n 1 | awk '{ print $2 }')
#    PORT=$( kubectl get services --namespace ${CLUSTER_NAMESPACE} | grep ${APP_SERVICE} | sed 's/.*:\([0-9]*\).*/\1/g' )
#  fi
#  echo ""
#  echo -e "VIEW THE APPLICATION AT: http://${IP_ADDR}:${PORT}"
#fi

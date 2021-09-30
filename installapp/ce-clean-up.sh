#!/bin/bash

# **************** Global variables

#export PROJECT_NAME=$MYPROJECT
export PROJECT_NAME=multi-tenancy-serverless
export RESOURCE_GROUP=default
export REGION="us-south"
export NAMESPACE=""
export STATUS="Running"
export SECRET_NAME="multi.tenancy.cr.sec"
export EMAIL=thomas.suedbroecker@de.ibm.com
export IBMCLOUDCLI_KEY_NAME=cliapikey_for_multi_tenant
export SECRET_NAME="multi.tenancy.cr.sec"
export YOUR_SERVICE_FOR_IBMCR_APPID="multi-tenancy-AppID-ibmcr-automated-serverless"
export YOUR_SERVICE_FOR_QUAY_APPID="multi-tenancy-AppID-quay-automated-serverless"
export APPID_SERVICE_QUAY_KEY_NAME="multi-tenancy-AppID-quay-automated-serverless-service-key"
export APPID_SERVICE_IBMCR_KEY_NAME="multi-tenancy-AppID-ibmcr-automated-serverless-service-key"


# **********************************************************************************
# Functions definition
# **********************************************************************************

function setupCLIenvCE() {
  echo "**********************************"
  echo " Using following project: $PROJECT_NAME" 
  echo "**********************************"
  
  ibmcloud target -g $RESOURCE_GROUP
  ibmcloud target -r $REGION

  ibmcloud ce project get --name $PROJECT_NAME
  ibmcloud ce project select -n $PROJECT_NAME
  
  #to use the kubectl commands
  ibmcloud ce project select -n $PROJECT_NAME --kubecfg
  
  NAMESPACE=$(ibmcloud ce project get --name $PROJECT_NAME --output json | grep "namespace" | awk '{print $2;}' | sed 's/"//g' | sed 's/,//g')
  echo "Namespace: $NAMESPACE"
  kubectl get pods -n $NAMESPACE
}

cleanCEapplications () {
    ibmcloud ce application delete --name frontend-a  --force
    ibmcloud ce application delete --name frontend  --force
    ibmcloud ce application delete --name service-catalog-a  --force
    ibmcloud ce application delete --name service-catalog  --force
}

cleanCEregistry(){
    ibmcloud ce registry delete --name $SECRET_NAME
}

cleanKEYS () {
   echo $IBMCLOUDCLI_KEY_NAME
   #List api-keys
   ibmcloud iam api-keys | grep $IBMCLOUDCLI_KEY_NAME
   #Delete api-key
   ibmcloud iam api-key-delete $IBMCLOUDCLI_KEY_NAME -f
   
   #List service-keys
   
   #ibmcr
   ibmcloud resource service-keys | grep $APPID_SERVICE_IBMCR_KEY_NAME
   ibmcloud resource service-keys --instance-name $YOUR_SERVICE_FOR_IBMCR_APPID
   ibmcloud resource service-key-delete $APPID_SERVICE_IBMCR_KEY_NAME -f

   #quay
   ibmcloud resource service-keys | grep $APPID_SERVICE_QUAY_KEY_NAME
   ibmcloud resource service-keys --instance-name $YOUR_SERVICE_FOR_QUAY_APPID
   ibmcloud resource service-key-delete $APPID_SERVICE_QUAY_KEY_NAME -f
}

cleanAppIDservice (){
    
    #ibmcr
    ibmcloud resource service-instance $YOUR_SERVICE_FOR_IBMCR_APPID
    ibmcloud resource service-instance-delete $YOUR_SERVICE_FOR_IBMCR_APPID -f
 
    #quay
    ibmcloud resource service-instance $YOUR_SERVICE_FOR_QUAY_APPID
    ibmcloud resource service-instance-delete $YOUR_SERVICE_FOR_QUAY_APPID -f
}

# **********************************************************************************
# Execution
# **********************************************************************************

echo "************************************"
echo " CLI config"
echo "************************************"

setupCLIenvCE

echo "************************************"
echo " Clean CE apps"
echo "************************************"

cleanCEapplications

echo "************************************"
echo " Clean CE registry"
echo "************************************"

cleanCEregistry

echo "************************************"
echo " Clean keys"
echo "************************************"

cleanKEYS

echo "************************************"
echo " Clean AppID service"
echo "************************************"

cleanAppIDservice

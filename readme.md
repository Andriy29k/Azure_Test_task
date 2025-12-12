# First step
Create service principal on Azure portal using CLI

az ad sp create-for-rbac

then will be output like:

{
  "appId": "myAppId",
  "displayName": "myServicePrincipalName",
  "password": "myServicePrincipalPassword",
  "tenant": "myTentantId"
}

usign grep export to Environment variables:

export APP_ID=
export AZ_PASSWORD=
export TENANT_ID=

# Second step
Assign "Contributor" role to subscription

az role assignment create \
    --assignee $APP_ID \
    --role "Contributor" \
    --scope /subscriptions/$SUBSCRIPTION_ID

# Azure cli login using service principal
az login --service-principal --username $APP_ID --password $AZ_PASSWORD --tenant $TENANT_ID

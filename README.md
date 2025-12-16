# Azure_Test_task
eSchool is a school management web application based on Spring Boot and developed as graduation project at SoftServe IT Academy.
# Core Features
Administrator functionality:
    Add students and teachers to database
    Create classes and add students into them
    Add subjects studied at school
    Assign teachers and subjects to classes

Teachers functionality

    View and edit mark book
    Assign home tasks
    Add notes for student
    View school performance chart

Students functionality:

    View their school diary with schedule
    View received marks and notes form teacher
    View assigned home tasks

# Start application on 2 servers(backend, database)

1. Create account in Azure cloud.
2. In Azure portal or using command
```az ad sp create-for-rbac --name <your_service_principal_name> --role <your_role> --scopes /subscriptions/<your_scopes>`` create service principal.
3. Add contributor role to service principal object using command in Azure CLI 
```az role assignment create --assignee <YOUR_SERVICE_PRINCIPAL_OBJECT_ID> --role "Contributor" --scope "<YOUR_SUBSCRIPTION_ID>"```, or add using Azure portal
4. Install Azure CLI using bash ```curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash```. (Optional)
5. Login in Azure CLI using command ```az login --service-principal --username <YOUR_APP_ID> --password <YOUR_CLIENT_SECRET> --tenant <YOUR_TENANT_ID>```
6. Generate 2 ssh keys for backend and database.
7. Use your variables by replacing or by filling values in ```terraform.tfvars.example```.
8. Fill your password to environment variables: ```export DATABASE_PASSWORD=<YOUR_VALUE>```
9. Go to application directory and run ```bash ./deploy.sh```
10. Go to ```<your_backend_ip>>:8080```

# Deploymnet details

1. Script runs terraform which create Cloud infrastructure(resource group, vpc, subnet, 2 security groups, 2 virtual machines, 2 network interfaces, 2 public ip's, 4 security group rules).
2. Next step is environment variable filling from cloud.
3. The script wrote environment variable for backend and database and transfer to vm's env's and another scripts required for deploying.
4. Using ssh bash starts scripts for setups in database and backend.
5. In overall setup_database.sh at the start defines .database_env file and load to source, then installing mysql and execute queries for user creating and granting privilegies also make autoload server and replace bind_answer to from everywhere.
6. In overall setup_backend.sh at the start define .backend_env file and load to source, then installing openjdk8, maven. Then clone eSchool repository, build application and make backend autostart.
8. Done! Go to ```<your_backend_ip>:8080/```, use user:admin, password:admin to login and test.  
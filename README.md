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

1. Create in Azure portal or Azure CLI on cloud create Service Principal.
2. Install Azure CLI using bash ```curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash```.
3. 
4. Generate 2 ssh keys for backend and database.
5. Use your variables by replacing or by filling values in ```terraform.tfvars.example```.
6. Fill your password to environment variables: ```export DATABASE_PASSWORD=<YOUR_VALUE>```
7. Go to application directory and run ```bash ./deploy.sh```
8. Go to ```<your_backend_ip>>:8080```

# Deploymnet details

1. Script runs terraform which create Cloud infrastructure(vpc, subnet, 2 security groups, 2 virtual machines, 2 network interfaces, 2 public ip's, 4 security group rules).
2. Next step is environment variable filling from cloud.
3. The script wrote environment variable for backend and database and transfer to vm's env's, and another scripts required for deploying..
4. Using ssh starts scripts for setups in database and backend.
5. In overall at the start define .database_env file and load to source, then installing mysql and execute queries for user creating and granting privilegies, also make autoload server and replace bind_answer to from everywhere.
6. In overall at the start define .backend_env file and load to source, then installing openjdk8 and maven.
7. Next is repository cloning, application build and making application autoloaded after OS start.
8. Done! Go to ```<your_backend_ip>:8080/```, use u:admin, p:admin to login and test.  
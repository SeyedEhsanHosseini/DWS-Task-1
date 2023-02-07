# DevOps Engineer (Mid-level) : Task 1

1- Write a simple python web application with the web framework of your choice “Flask
preferred”. The application should have the following endpoints:  

/ : to show index page that shows a simple text “Welcome to our application”  

/status: to show application metrics which shows a JSON output shows the current application status, number of active connections, the instance IP address, instance available RAM and CPU and the instance Datetime in UTC format like the following output:

```
{
    “status”: “up”,
    “active_connections”: X,
    “ip_address”: “10.20.30.40”,
    “memory_total”: x,
    “cpu_total”: x,
    “current_datetime”: x
}
```

2-Dockerize the application and create an image of the application.  

3- Write an IaC code in Terraform to create an MAAS instance  

4- After bringing up the instance, Ansible should take it, upgrade the instance and install Docker and Docker-compose on that instance. So, you must write a playbook to upgrade the machine and install everything needed.  

5- At this point, Terraform should take the control again and deploy the following services in the right order. Write a Terraform code to do the following works:  

*  Deploy a Docker registry into the MAAS instance (Docker)
*  Push the application image into that registry
*  Create a container of the application and publish it port

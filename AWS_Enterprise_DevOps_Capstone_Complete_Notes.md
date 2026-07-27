# AWS Enterprise DevOps Capstone Project

## Project Overview

This project implements a complete Enterprise DevOps platform on AWS
using Terraform, Amazon EKS, Docker, GitHub Actions, Helm, CloudWatch,
SonarCloud, Trivy, AWS Secrets Manager, and Kubernetes.

## Architecture

``` text
Developer
   |
GitHub
   |
GitHub Actions CI
   |-- Install
   |-- Test
   |-- Build
   |-- SonarCloud
   |-- Trivy
   |-- Docker Build
   |
Amazon ECR
   |
GitHub Actions CD
   |
Amazon EKS
   |
Deployment -> Service -> Pods
   |
CloudWatch
```

## Flow

1.  Terraform provisions AWS infrastructure.
2.  Developer pushes code to GitHub.
3.  CI runs install, tests, build, SonarCloud, Trivy.
4.  Docker image is built and pushed to ECR.
5.  CD deploys to EKS.
6.  Helm manages releases.
7.  External Secrets retrieves secrets from Secrets Manager.
8.  CloudWatch collects logs and metrics.
9.  CloudWatch alarms monitor CPU and memory.
10. Terraform destroys infrastructure after testing.

## Main AWS Services

-   VPC
-   Public/Private Subnets
-   Internet Gateway
-   NAT Gateway
-   IAM
-   Amazon EKS
-   EC2 Worker Nodes
-   Amazon ECR
-   Secrets Manager
-   CloudWatch
-   SNS

## Common Commands

### Terraform

``` bash
terraform init
terraform validate
terraform plan
terraform apply
terraform destroy -auto-approve
```

### Docker

``` bash
docker build -t enterprise-devops-capstone .
docker push <ecr-image>
```

### Kubernetes

``` bash
kubectl apply -f kubernetes/
kubectl get pods -A
kubectl get svc -A
kubectl get nodes
kubectl logs <pod>
kubectl delete -f kubernetes/
```

### Helm

``` bash
helm install enterprise-app helm/enterprise-app -n enterprise
helm upgrade enterprise-app helm/enterprise-app -n enterprise
helm uninstall enterprise-app -n enterprise
```

### EKS

``` bash
aws eks update-kubeconfig --region ap-south-2 --name enterprise-eks
```

## DevSecOps

-   SonarCloud
-   Trivy Filesystem Scan
-   Trivy Image Scan
-   npm audit

## Monitoring

-   CloudWatch Agent
-   Fluent Bit
-   CloudWatch Logs
-   CloudWatch Metrics
-   CloudWatch Alarms

## Troubleshooting

-   Service selector mismatch
-   Missing endpoints
-   Image pull issues
-   Pipeline failures
-   Terraform dependency issues

## Cost Optimization

-   Review Cost Explorer
-   Review Trusted Advisor
-   Use Spot Instances
-   Reduce log retention
-   Remove unused ECR images
-   Destroy unused infrastructure

## End-to-End Summary

Terraform creates the infrastructure. GitHub Actions validates and
secures the application. Docker packages the application, Amazon ECR
stores the image, Amazon EKS runs the workloads, Helm manages releases,
External Secrets injects secrets securely, CloudWatch provides
observability, and Terraform destroys the environment when work is
complete.

# AWS Enterprise DevOps Capstone Project

# Phase 2 - CI/CD Pipelines

# Task 3 - Continuous Delivery (CD)

---

# Objective

Implement an Enterprise Continuous Delivery (CD) Pipeline using GitHub Actions.

The pipeline should:

- Build the Docker image
- Push the image to Amazon Elastic Container Registry (ECR)
- Prepare deployment to Amazon EKS
- Support manual approval before Production deployment
- Follow Enterprise CI/CD standards

---

# What is Continuous Delivery?

Continuous Delivery (CD) is the process of automatically deploying an application after it has successfully passed all CI stages.

Instead of manually deploying applications, CD automatically packages and delivers the application to different environments.

Example:

Developer
↓

Push Code

↓

CI Pipeline

↓

Tests Passed

↓

CD Pipeline

↓

Docker Image

↓

Amazon ECR

↓

Amazon EKS

↓

Production

---

# Difference Between CI and CD

| Continuous Integration | Continuous Delivery |
|------------------------|---------------------|
| Validates code | Deploys application |
| Runs tests | Pushes Docker image |
| Builds application | Deploys to Kubernetes |
| Finds coding issues | Delivers new release |
| Triggered on PR/Push | Triggered after CI success |

---

# Enterprise CI/CD Architecture

                         Developer

                              │

                        Git Push

                              │

                              ▼

                  GitHub Repository

                              │

                              ▼

               GitHub Actions CI Pipeline

        Checkout Source Code

               Install Packages

                 Run Tests

             Build Application

              Upload Artifact

                              │

                              ▼

              GitHub Actions CD Pipeline

                 Configure AWS

                Login Amazon ECR

               Build Docker Image

                Push Docker Image

                      │

             (Phase 3)

              Deploy to EKS

                      │

             Manual Approval

                      │

                Production

---

# Repository Structure

enterprise-devops-capstone/

│

├── app/

│      Dockerfile

│      package.json

│      package-lock.json

│      server.js

│

├── kubernetes/

│      deployment.yaml

│      service.yaml

│

├── terraform/

│

├── .github/

│      workflows/

│           ci.yml

│           cd.yml

│

└── README.md

---

# Workflow Execution

Developer Pushes Code

↓

CI Pipeline Executes

↓

Application Build Successful

↓

Artifact Uploaded

↓

CD Pipeline Executes

↓

Docker Image Created

↓

Docker Image Pushed to Amazon ECR

↓

(Phase 3)

Deploy to Amazon EKS

---

# Required AWS Services

This phase uses:

- GitHub
- GitHub Actions
- Docker
- Amazon ECR
- IAM
- (Later) Amazon EKS

---

# Create Amazon ECR Repository

Using AWS Console

AWS Console

↓

Elastic Container Registry

↓

Private Registry

↓

Create Repository

Repository Name

capstone1

Repository URI Example

705557196379.dkr.ecr.ap-south-2.amazonaws.com/capstone1

---

# GitHub Secrets

Go to

Repository

↓

Settings

↓

Secrets and Variables

↓

Actions

Create the following secrets.

| Secret Name | Example Value |
|-------------|---------------|
| AWS_ACCESS_KEY_ID | AKIA******** |
| AWS_SECRET_ACCESS_KEY | ************* |
| AWS_REGION | ap-south-2 |
| AWS_ACCOUNT_ID | 705557196379 |
| ECR_REPOSITORY | capstone1 |

---

# Why GitHub Secrets?

Never hardcode credentials inside YAML files.

❌ Wrong

aws-access-key-id: AKIAxxxxxxxx

✅ Correct

aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}

---

# CI Pipeline

The CI pipeline is responsible only for validating the application.

Responsibilities

✔ Checkout Source Code

✔ Install NodeJS

✔ Install Dependencies

✔ Run Tests

✔ Build Application

✔ Upload Artifact

Notice

The CI pipeline DOES NOT build Docker images.

Docker images belong to the CD pipeline.

---

# Complete CI Workflow

File

.github/workflows/ci.yml

```yaml
# Workflow Name
name: Continuous Integration

# Trigger Conditions
on:

  # Trigger when code is pushed
  push:

    branches:
      - develop
      - main

  # Trigger when Pull Request is created
  pull_request:

    branches:
      - develop

jobs:

  build:

    # GitHub Hosted Runner
    runs-on: ubuntu-latest

    # Execute all run commands from app directory
    defaults:
      run:
        working-directory: app

    steps:

      # Download repository source code
      - name: Checkout Repository
        uses: actions/checkout@v4

      # Install NodeJS
      - name: Setup Node.js
        uses: actions/setup-node@v4

        with:

          # NodeJS Version
          node-version: 20

          # Cache npm dependencies
          cache: npm

          cache-dependency-path: app/package-lock.json

      # Install project dependencies
      - name: Install Dependencies

        run: npm install

      # Execute Unit Tests
      - name: Run Tests

        run: npm test

      # Build Application
      - name: Build Application

        run: npm run build

      # Upload application as artifact
      - name: Upload Build Artifact

        uses: actions/upload-artifact@v4

        with:

          # Artifact Name
          name: application

          # Upload app directory
          path: app/
```

---

# CI Pipeline Flow

Git Push

↓

Checkout Repository

↓

Install NodeJS

↓

Install Packages

↓

Run Tests

↓

Build Application

↓

Upload Artifact

↓

Pipeline Success

---

# Deliverables

✔ ci.yml

✔ Successful Build Logs

✔ Uploaded Artifact

✔ GitHub Actions Success Screenshot


# AWS Enterprise DevOps Capstone Project

# Phase 2 - CI/CD Pipelines

# Task 3 - Continuous Delivery (CD)

---

# Continuous Delivery Workflow

Once the Continuous Integration (CI) pipeline completes successfully, the Continuous Delivery (CD) pipeline starts.

Workflow

Developer

↓

Push Code to Main Branch

↓

CI Pipeline

↓

Tests Successful

↓

CD Pipeline

↓

Configure AWS Credentials

↓

Login to Amazon ECR

↓

Build Docker Image

↓

Tag Docker Image

↓

Push Docker Image

↓

(Phase 3)

Deploy to Amazon EKS

↓

Manual Approval

↓

Production

---

# Why Build Docker Image in CD?

Many beginners build Docker images in both CI and CD.

Enterprise projects usually follow this approach:

CI

✔ Validate Code

✔ Run Tests

✔ Build Application

✔ Upload Artifact

CD

✔ Build Docker Image

✔ Push Image

✔ Deploy Application

This avoids building Docker images twice.

---

# Complete CD Workflow

Location

.github/workflows/cd.yml

```yaml
# Workflow Name
name: Continuous Delivery

# Execute only after CI completes successfully
on:

  workflow_run:

    workflows:

      - Continuous Integration

    types:

      - completed

jobs:

  deploy:

    # Execute only if CI succeeded
    if: >
      ${{
        github.event.workflow_run.conclusion == 'success' &&
        github.event.workflow_run.head_branch == 'main'
      }}

    # GitHub Hosted Runner
    runs-on: ubuntu-latest

    # Execute commands inside app folder
    defaults:
      run:
        working-directory: app

    steps:

      # Download repository
      - name: Checkout Repository

        uses: actions/checkout@v4

      # Configure AWS Credentials
      - name: Configure AWS Credentials

        uses: aws-actions/configure-aws-credentials@v4

        with:

          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}

          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}

          aws-region: ${{ secrets.AWS_REGION }}

      # Login to Amazon ECR
      - name: Login to Amazon ECR

        id: login-ecr

        uses: aws-actions/amazon-ecr-login@v2

      # Build Docker Image
      - name: Build Docker Image

        run: |

          docker build -t capstone1:${{ github.sha }} .

      # Tag Docker Image
      - name: Tag Docker Image

        run: |

          docker tag capstone1:${{ github.sha }} \
          ${{ secrets.AWS_ACCOUNT_ID }}.dkr.ecr.${{ secrets.AWS_REGION }}.amazonaws.com/${{ secrets.ECR_REPOSITORY }}:${{ github.sha }}

      # Push Docker Image
      - name: Push Docker Image

        run: |

          docker push \
          ${{ secrets.AWS_ACCOUNT_ID }}.dkr.ecr.${{ secrets.AWS_REGION }}.amazonaws.com/${{ secrets.ECR_REPOSITORY }}:${{ github.sha }}

      # Deployment Placeholder
      - name: Deployment Status

        run: |

          echo "Docker image pushed successfully."

          echo "Deployment to Amazon EKS will be implemented in Phase 3."
```

---

# CD Workflow Explanation

## Trigger

```yaml
on:
```

Defines when the workflow should execute.

---

## workflow_run

```yaml
workflow_run:
```

Instead of running on every push,

this workflow starts only after another workflow completes.

---

## workflows

```yaml
workflows:
  - Continuous Integration
```

Means

Start CD only after the CI workflow finishes.

---

## Condition

```yaml
if:
```

Checks

Did CI succeed?

Was the code merged into main?

If both are true,

Deployment begins.

---

# Configure AWS Credentials

```yaml
aws-actions/configure-aws-credentials
```

This action authenticates GitHub Actions with your AWS account.

Without this step,

GitHub cannot

- Push Docker Images
- Access ECR
- Access EKS
- Read Secrets Manager

---

# Login to Amazon ECR

```yaml
amazon-ecr-login
```

Logs into Amazon Elastic Container Registry.

Without login

docker push

↓

Permission Denied

---

# Build Docker Image

```yaml
docker build
```

Creates Docker Image.

Example

capstone1:f3acb21

---

# Why GitHub SHA?

```yaml
${{ github.sha }}
```

Each Git Commit receives a unique Docker Image.

Example

Commit

abc123

↓

Docker Image

capstone1:abc123

Next Commit

5d33fa

↓

Docker Image

capstone1:5d33fa

Advantages

✔ No duplicate tags

✔ Easy Rollback

✔ Version Tracking

---

# Tag Docker Image

Local Image

↓

capstone1:abc123

↓

Tag

↓

705557196379.dkr.ecr.ap-south-2.amazonaws.com/capstone1:abc123

---

# Push Docker Image

Uploads the Docker Image into Amazon ECR.

Developer

↓

Docker Image

↓

Amazon ECR

Later

Amazon EKS

↓

Pulls Image

↓

Runs Container

---

# Manual Approval

The project slide mentions

Manual Approval before Production.

GitHub Actions uses

Environments

instead of a YAML step.

Configuration

Repository

↓

Settings

↓

Environments

↓

Create Environment

production

Enable

✔ Required Reviewers

Now

Deployment

↓

Waiting for Approval

↓

Reviewer Clicks Approve

↓

Production Deployment Starts

---

# Deployment to Amazon EKS

This will be implemented after Phase 3.

Future Deployment Step

```yaml
- name: Configure kubectl

  run: |

    aws eks update-kubeconfig \
      --region ${{ secrets.AWS_REGION }} \
      --name capstone-cluster

- name: Deploy Application

  run: |

    kubectl apply -f ../kubernetes/
```

Notice

Since cd.yml executes inside

app/

the Kubernetes folder is

../kubernetes

---

# CD Pipeline Flow

Developer

↓

Main Branch

↓

GitHub Actions

↓

Configure AWS

↓

Login Amazon ECR

↓

Build Docker Image

↓

Push Docker Image

↓

Amazon ECR

↓

(Phase 3)

Amazon EKS

↓

Pods Created

↓

Application Running

---

# Expected Output

GitHub Actions

↓

Continuous Delivery

↓

Configure AWS

✔

↓

Login Amazon ECR

✔

↓

Build Docker Image

✔

↓

Push Docker Image

✔

↓

Workflow Success

---

# Verify Image in Amazon ECR

AWS Console

↓

Amazon ECR

↓

Private Repository

↓

capstone1

↓

Images

Example

TAG

abc123

IMAGE SIZE

65 MB

PUSHED

Just Now

---

# Deliverables

✔ cd.yml

✔ Docker Image

✔ Amazon ECR Repository

✔ Docker Push Logs

✔ Successful GitHub Actions Workflow

---

# Screenshots to Capture

1. GitHub Actions CD Success

2. Amazon ECR Repository

3. Docker Image inside ECR

4. GitHub Secrets

5. GitHub Environment (production)

6. Docker Push Logs

---

# Common Errors

## Error

AccessDeniedException

Reason

Incorrect IAM Permissions

Solution

Attach AmazonEC2ContainerRegistryPowerUser policy.

---

## Error

Repository Not Found

Reason

Repository Name Incorrect

Solution

Check

ECR_REPOSITORY

GitHub Secret.

---

## Error

Docker Push Failed

Reason

Not Logged into Amazon ECR

Solution

Use

amazon-ecr-login

GitHub Action.

---

## Error

Invalid AWS Credentials

Reason

Wrong Access Key

Solution

Update GitHub Secrets.

---

# Best Practices

✔ Never hardcode AWS credentials.

✔ Use GitHub Secrets.

✔ Build Docker Image only once.

✔ Use Commit SHA instead of latest.

✔ Protect Production with Manual Approval.

✔ Store Docker Images inside Amazon ECR.

✔ Deploy only from Main Branch.

✔ Use IAM Least Privilege.

---

# Interview Questions

## Why is Docker Image built in CD instead of CI?

CI validates source code.

CD packages and deploys the application.

Building Docker Images only in CD avoids duplicate builds.

---

## Why use GitHub SHA as Docker Tag?

Every commit receives a unique image.

This makes rollback and version tracking easier.

---

## Why use Amazon ECR?

Amazon EKS can securely pull Docker Images from Amazon ECR.

---

## Why use GitHub Secrets?

Secrets prevent AWS credentials from being exposed inside repository code.

---

## Why is Deployment not implemented yet?

The EKS Cluster is created in Phase 3 using Terraform.

After creating the cluster,

we'll simply add

kubectl apply

to the CD pipeline.

---

# Phase 2 Completed

Congratulations!

You have now completed

✔ Continuous Integration

✔ Continuous Delivery

✔ Docker Build

✔ Docker Push

✔ Amazon ECR Integration

✔ GitHub Actions

✔ Enterprise CI/CD Architecture

Next Phase

Phase 3

Infrastructure as Code (Terraform)

We'll provision

✔ VPC

✔ Public & Private Subnets

✔ NAT Gateway

✔ Internet Gateway

✔ IAM Roles

✔ EKS Cluster

✔ Managed Node Groups

✔ CloudWatch

using reusable Terraform modules.
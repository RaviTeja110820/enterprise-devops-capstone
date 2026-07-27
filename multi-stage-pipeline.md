# Task 4 - Multi-Stage Deployment Pipeline

## Objective

The objective of this task is to create a **Multi-Stage Deployment Pipeline** using **GitHub Actions**.

Instead of deploying directly to production, the application will go through multiple environments:

```
Development → Testing → Production
```

This is the deployment strategy followed in most enterprise DevOps projects.

---

# Architecture

```
Developer

    │

    ▼

Push Code to GitHub

    │

    ▼

GitHub Actions Pipeline

    │

    ▼

Build Application

    │

    ▼

Deploy to Development

    │

    ▼

Manual Approval (Optional)

    │

    ▼

Deploy to Testing

    │

    ▼

Manual Approval

    │

    ▼

Deploy to Production
```

---

# Prerequisites

Before starting this task, make sure you have completed:

- ✅ Task 1 – Git Branching Strategy
- ✅ Task 2 – Continuous Integration Pipeline
- ✅ Task 3 – Continuous Delivery Pipeline

---

# Step 1 - Create a Feature Branch

Always create a new feature branch instead of working directly on the **main** branch.

```bash
git checkout develop
git checkout -b feature/multi-stage-pipeline
```

Verify the branch.

```bash
git branch
```

Example Output

```
main
develop
* feature/multi-stage-pipeline
```

---

# Step 2 - Create Kubernetes Folder

Create a folder named **kubernetes** in the project root.

```
enterprise-devops-capstone/

│
├── app/
│
├── kubernetes/
│
├── terraform/
│
├── .github/
│
└── README.md
```

Command

```bash
mkdir kubernetes
```

> **Note:** The `kubernetes` folder should **NOT** be created inside the `app` folder.

Correct Structure

```
enterprise-devops-capstone/

├── app/
├── kubernetes/
├── terraform/
├── .github/
```

Wrong Structure

```
app/

└── kubernetes/
```

---

# Step 3 - Create Namespace YAML Files

Create the following files.

```
kubernetes/

├── namespace-dev.yaml

├── namespace-test.yaml

└── namespace-prod.yaml
```

---

## namespace-dev.yaml

```yaml
# Create Development Namespace

apiVersion: v1

kind: Namespace

metadata:

  name: dev
```

---

## namespace-test.yaml

```yaml
# Create Testing Namespace

apiVersion: v1

kind: Namespace

metadata:

  name: test
```

---

## namespace-prod.yaml

```yaml
# Create Production Namespace

apiVersion: v1

kind: Namespace

metadata:

  name: production
```

---

# Why Create Namespaces?

Namespaces logically separate applications inside the same Kubernetes cluster.

Example

```
Amazon EKS Cluster

│

├── dev

├── test

└── production
```

This allows the same application to run in different environments without creating multiple clusters.

---

# Step 4 - Create GitHub Environments

Open GitHub Repository.

```
Repository

↓

Settings

↓

Environments
```

Create the following environments.

```
Development

Testing

Production
```

---

## Production Environment

Enable the following protection rules.

```
✓ Required Reviewers

✓ Wait Timer (Optional)

✓ Deployment Branch Rules
```

This will create a **Manual Approval** step before production deployment.

---

# Step 5 - Update cd.yml

Open

```
.github/workflows/cd.yml
```

Update the workflow.

```yaml
# Workflow Name
name: Multi Stage Deployment

# Trigger when code is pushed to the main branch
on:

  push:

    branches:

      - main

jobs:

  # Build Job
  build:

    runs-on: ubuntu-latest

    steps:

      # Build the application
      - name: Build Docker Image

        run: echo "Docker Image Built Successfully"

  # Deploy to Development
  deploy-dev:

    needs: build

    runs-on: ubuntu-latest

    environment: Development

    steps:

      - name: Deploy to Development

        run: echo "Deploying to Development..."

  # Deploy to Testing
  deploy-test:

    needs: deploy-dev

    runs-on: ubuntu-latest

    environment: Testing

    steps:

      - name: Deploy to Testing

        run: echo "Deploying to Testing..."

  # Deploy to Production
  deploy-production:

    needs: deploy-test

    runs-on: ubuntu-latest

    environment: Production

    steps:

      - name: Deploy to Production

        run: echo "Deploying to Production..."
```

---

# Explanation of Workflow

## on

```yaml
on:
```

Specifies when the workflow should execute.

---

## push

```yaml
push:
```

Runs the workflow whenever code is pushed.

---

## branches

```yaml
branches:
  - main
```

Only pushes to the **main** branch will trigger the deployment.

---

## jobs

```yaml
jobs:
```

Defines all the stages of the pipeline.

---

## needs

```yaml
needs: build
```

Means this job waits for the previous job to complete successfully.

Pipeline Flow

```
Build

↓

Deploy Development

↓

Deploy Testing

↓

Deploy Production
```

---

## environment

```yaml
environment: Production
```

Uses the GitHub **Production Environment**.

If **Required Reviewers** are configured, GitHub pauses the workflow until approval is given.

---

# Why Use Placeholder Commands?

Currently, the project does **NOT** have an Amazon EKS cluster.

Therefore, instead of using:

```bash
kubectl apply -f deployment.yaml
```

we temporarily use:

```yaml
run: echo "Deploying to Development..."
```

Once Terraform creates the EKS cluster in **Phase 3**, these placeholder commands will be replaced with actual deployment commands.

Example

```yaml
- name: Configure kubectl

  run: |

    aws eks update-kubeconfig \
    --region us-east-1 \
    --name enterprise-eks

- name: Deploy Application

  run: |

    kubectl apply -f kubernetes/
```

---

# Step 6 - Commit Changes

Add files.

```bash
git add .
```

Commit.

```bash
git commit -m "Added multi-stage deployment pipeline"
```

Push.

```bash
git push origin feature/multi-stage-pipeline
```

---

# Step 7 - Create Pull Request

Create a Pull Request.

```
feature/multi-stage-pipeline

↓

develop
```

After review,

Merge into **develop**.

Then,

```
develop

↓

main
```

---

# Project Structure After Task 4

```
enterprise-devops-capstone/

│

├── app/

│

├── kubernetes/

│     namespace-dev.yaml

│     namespace-test.yaml

│     namespace-prod.yaml

│

├── terraform/

│

├── .github/

│      workflows/

│           ci.yml

│           cd.yml

│

└── README.md
```

---

# Deliverables

After completing this task, you should have:

- ✅ Multi-stage GitHub Actions workflow
- ✅ Kubernetes namespace YAML files
- ✅ GitHub Environments (Development, Testing, Production)
- ✅ Feature branch with Pull Request
- ✅ Merged code into `develop` and then `main`

---

# Screenshots to Capture

Take screenshots of the following:

1. GitHub Environments page
2. GitHub Actions workflow showing Build → Development → Testing → Production jobs
3. Pull Request page
4. Repository folder structure
5. Git commit history (`git log --oneline --graph --all`)

---

# Important Note

Do **NOT** execute the namespace YAML files yet.

Do **NOT** run:

```bash
kubectl apply -f kubernetes/
```

because the Amazon EKS cluster will be created later in **Phase 3 (Terraform Infrastructure)**.

For now, only prepare the Kubernetes manifests and the GitHub Actions pipeline. Once the infrastructure is ready, these manifests will be applied to the cluster.

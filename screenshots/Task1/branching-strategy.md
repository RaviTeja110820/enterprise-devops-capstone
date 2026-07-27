# Git Branching Strategy

## Project Name

**AWS Enterprise DevOps Capstone Project**

---

# Objective

The objective of this branching strategy is to enable multiple developers to work on the same project simultaneously without affecting the production code.

This workflow provides:

- Safe development
- Easy collaboration
- Code review before merging
- Stable production releases
- Version control best practices

---

# Branching Workflow

The project follows the following Git branching model:

```text
                     feature/docker
                           │
                     feature/terraform
                           │
                     feature/github-actions
                           │
                     feature/helm
                           │
                           ▼
                       develop
                           │
                    Pull Request (PR)
                           │
                     Code Review
                           │
                           ▼
                         main
                           │
                      Production
```

---

# Branches Used

## 1. main Branch

Purpose:

- Production-ready code
- Stable version of the application
- Only tested and approved code is merged here

Branch Name

```text
main
```

Rules

- Direct commits are not allowed.
- Changes must come through Pull Requests.
- Branch protection is enabled.
- Force push is disabled.
- Branch deletion is disabled.

---

## 2. develop Branch

Purpose

The develop branch is the integration branch where all completed feature branches are merged before going to production.

Branch Name

```text
develop
```

Responsibilities

- Collect all completed features
- Integration testing
- Bug fixes
- Prepare production release

Workflow

```text
feature/*

      │

      ▼

develop

      │

Testing

      │

      ▼

main
```

---

## 3. Feature Branches

Purpose

Each new feature or task is developed in its own feature branch.

Naming Convention

```text
feature/<feature-name>
```

Examples

```text
feature/docker

feature/github-actions

feature/terraform

feature/eks

feature/monitoring

feature/security

feature/helm
```

Advantages

- Isolated development
- No impact on production
- Easy rollback
- Parallel development

---

# Development Workflow

## Step 1

Clone Repository

```bash
git clone https://github.com/<username>/enterprise-devops-capstone.git

cd enterprise-devops-capstone
```

---

## Step 2

Create Develop Branch

```bash
git checkout -b develop
```

Push branch

```bash
git push -u origin develop
```

---

## Step 3

Create Feature Branch

Example

```bash
git checkout develop

git checkout -b feature/docker
```

---

## Step 4

Develop Feature

Example

```bash
touch Dockerfile

git add .

git commit -m "Added production Dockerfile"

git push origin feature/docker
```

---

## Step 5

Create Pull Request

On GitHub

```text
feature/docker

↓

develop
```

Title

```text
Added Production Dockerfile
```

Description

```text
Implemented production-ready Dockerfile for the application.
```

---

## Step 6

Code Review

Every Pull Request must be reviewed before merging.

The reviewer checks

- Code quality
- Folder structure
- Naming conventions
- Documentation
- Best practices
- Build status
- Merge conflicts

If everything is correct

Approve PR

↓

Merge into develop

---

## Step 7

Merge into Develop

After approval

```text
feature/docker

↓

develop
```

---

## Step 8

Testing

Testing is performed on the develop branch.

Examples

- Build verification
- Unit testing
- Integration testing
- Docker image creation
- CI Pipeline execution

---

## Step 9

Production Release

After successful testing

```text
develop

↓

main
```

The main branch always contains production-ready code.

---

# Complete Workflow Diagram

```text
                     feature/docker
                            │
                            │
                     Pull Request
                            │
                            ▼
                        develop
                            │
                  Integration Testing
                            │
                            ▼
                     Pull Request
                            │
                            ▼
                          main
                            │
                      Production
```

---

# Branch Protection Rules

Branch protection is enabled only on the **main** branch.

Configured Rules

- Require Pull Request before merging
- Require review before merging (optional for solo projects)
- Prevent force push
- Prevent branch deletion
- Require branch to be up-to-date before merging

These rules ensure that no developer can accidentally modify the production branch.

---

# Pull Request Workflow

```text
Developer

    │

Creates Feature Branch

    │

Develops Feature

    │

Pushes Code

    │

Creates Pull Request

    │

Code Review

    │

Approval

    │

Merge into develop

    │

Testing

    │

Merge into main
```

---

# Branch Naming Standards

| Branch Type | Example |
|-------------|----------|
| Production | `main` |
| Integration | `develop` |
| Feature | `feature/docker` |
| Feature | `feature/github-actions` |
| Feature | `feature/terraform` |
| Feature | `feature/eks` |
| Feature | `feature/security` |
| Feature | `feature/monitoring` |
| Bug Fix (optional) | `bugfix/login-error` |
| Hotfix (optional) | `hotfix/docker-build` |

---

# Git Commands Used

## Clone Repository

```bash
git clone <repository-url>
```

---

## Create Develop Branch

```bash
git checkout -b develop
```

---

## Push Develop Branch

```bash
git push -u origin develop
```

---

## Create Feature Branch

```bash
git checkout develop

git checkout -b feature/docker
```

---

## Check Current Branch

```bash
git branch
```

---

## Check Branch Status

```bash
git status
```

---

## Stage Changes

```bash
git add .
```

---

## Commit Changes

```bash
git commit -m "Added Dockerfile"
```

---

## Push Feature Branch

```bash
git push origin feature/docker
```

---

## Pull Latest Changes

```bash
git pull origin develop
```

---

## Merge Develop into Main

```bash
git checkout main

git merge develop
```

---

## Push Main Branch

```bash
git push origin main
```

---

# Benefits of This Branching Strategy

- Supports parallel development
- Keeps production stable
- Simplifies code reviews
- Makes bug tracking easier
- Reduces merge conflicts
- Improves collaboration
- Supports CI/CD pipelines
- Enables controlled releases

---

# Expected Git History

```text
* Merge pull request #8 from feature/helm

* Added Helm Chart

* Merge pull request #7 from feature/eks

* Added Kubernetes Deployment

* Merge pull request #6 from feature/github-actions

* Added GitHub Actions CI

* Merge pull request #5 from feature/docker

* Added Dockerfile

* Initial Project Setup
```

---

# Screenshots to Capture

Capture the following screenshots for submission:

- GitHub repository homepage
- Branch list (`main`, `develop`, and `feature/*`)
- Pull Request page
- Code review page (or self-review if working individually)
- Merge confirmation
- Branch protection rules
- Git commit history
- GitHub commit graph

---

# Conclusion

This branching strategy follows industry-standard Git workflows by separating production, integration, and feature development into dedicated branches. Developers create isolated feature branches, submit Pull Requests for review, merge approved changes into the `develop` branch for testing, and finally promote stable code to the `main` branch for production. This approach improves collaboration, maintains code quality, and ensures a reliable release process.

# Vulnerability Mitigation Report

## Project

AWS Enterprise DevOps Capstone

---

# Objective

The objective of this task is to identify vulnerabilities present in the Docker image stored in Amazon Elastic Container Registry (ECR) and document the remediation strategy.

---

# Root Cause Analysis

Amazon Inspector identified vulnerabilities in the OpenSSL package bundled with the official Node.js Alpine base image.

These vulnerabilities originate from upstream operating system packages and are not caused by the application source code.

---

# Identified Package

Package Name

openssl

Installed Version

3.5.6-r0

---

# Mitigation Strategy

## 1. Keep Base Images Updated

Use the latest supported Node.js base image whenever possible.

Current Dockerfile

```dockerfile
FROM node:20-alpine
```

Future Recommendation

```dockerfile
FROM node:22-alpine
```

Updating the base image allows patched operating system packages to be included during the build process.

---

## 2. Rebuild Images Frequently

Whenever security updates become available:

- Pull the latest base image.
- Rebuild the Docker image.
- Push the updated image to Amazon ECR.
- Allow Amazon Inspector to perform a new scan.

---

## 3. Continuous Image Scanning

Amazon Inspector Enhanced Scanning has been enabled for the Amazon ECR repository.

Every newly pushed image is automatically scanned for known vulnerabilities.

---

## 4. CI/CD Security Integration

The GitHub Actions pipeline includes:

- SonarCloud Static Code Analysis
- npm dependency audit
- Trivy filesystem scan
- Trivy Docker image scan

This ensures vulnerabilities are detected before deployment.

---

## 5. Monitor Vulnerabilities

Amazon Inspector findings should be reviewed regularly.

Critical and High severity findings should be prioritized for remediation before production deployment.

---

# Validation

After rebuilding the Docker image using an updated base image:

- Push the image to Amazon ECR.
- Trigger Amazon Inspector scanning.
- Verify that the number of Critical and High vulnerabilities has been reduced.

---

# Best Practices

- Use official Docker images.
- Keep operating system packages updated.
- Perform automated image scanning.
- Scan every image pushed to Amazon ECR.
- Integrate security scanning into the CI/CD pipeline.
- Regularly review Amazon Inspector findings.

---

# Conclusion

Amazon ECR Enhanced Scanning was successfully implemented using Amazon Inspector.

The scan identified vulnerabilities within the operating system packages included in the container image.

Continuous image scanning, regular base image updates, automated CI/CD security checks, and prompt patch management will be used to reduce security risks before production deployment.
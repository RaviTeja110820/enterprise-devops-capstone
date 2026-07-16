# Amazon ECR Container Image Scan Report

## Project Information

| Item | Value |
|------|-------|
| Project | AWS Enterprise DevOps Capstone |
| Repository | enterprise-devops-capstone |
| Image Tag | latest |
| Scanner | Amazon Inspector (Enhanced Scanning) |
| Registry | Amazon Elastic Container Registry (ECR) |
| AWS Region | ap-south-2 |

---

# Scan Summary

The Docker image stored in Amazon ECR was scanned using Amazon Inspector Enhanced Scanning after being pushed to the repository.

The scan detected multiple vulnerabilities in packages included in the base image.

## Vulnerability Summary

| Severity | Status |
|----------|--------|
| Critical | Detected |
| High | Detected |
| Medium | Detected |
| Low | None Reported |

---

# Major Findings

## Critical Vulnerability

### CVE-2026-34182

**Package**

openssl

**Installed Version**

3.5.6-r0

**CVSS Score**

9.1

**Severity**

Critical

**Description**

Insufficient validation during Cryptographic Message Services (CMS) processing may allow attackers to bypass integrity validation or obtain key-equivalent functionality, potentially compromising encrypted communications.

**Reference**

https://nvd.nist.gov/vuln/detail/CVE-2026-34182

---

## High Vulnerabilities

### CVE-2026-34181

Package:
openssl

Severity:
High

Description:

PKCS#12 processing vulnerability allowing forged certificates and private keys under specific conditions.

---

### CVE-2026-9076

Package:
openssl

Severity:
High

Description:

Heap out-of-bounds read during CMS password-based decryption that may result in application crashes (Denial of Service).

---

### CVE-2026-45447

Package:
openssl

Severity:
High

Description:

Use-after-free vulnerability during PKCS#7 signature verification that may lead to crashes or remote code execution.

---

### CVE-2026-34183

Package:
openssl

Severity:
High

Description:

QUIC PATH_CHALLENGE frame processing may lead to excessive memory allocation and Denial of Service.

---

### CVE-2026-45445

Package:
openssl

Severity:
High

Description:

AES-OCB encryption incorrectly handles initialization vectors, potentially compromising confidentiality.

---

### CVE-2026-7383

Package:
openssl

Severity:
High

Description:

Heap buffer overflow vulnerability in ASN.1 string processing.

---

### CVE-2026-34180

Package:
openssl

Severity:
High

Description:

Heap buffer over-read in ASN.1 decoder caused by integer truncation.

---

### CVE-2026-42764

Package:
openssl

Severity:
High

Description:

NULL pointer dereference in OpenSSL QUIC server resulting in Denial of Service.

---

## Medium Vulnerabilities

- CVE-2026-42766
- CVE-2026-42769
- CVE-2026-42767
- CVE-2026-45446

All medium severity vulnerabilities are associated with the OpenSSL package included in the base image.

---

# Root Cause

The detected vulnerabilities originate from the operating system packages bundled with the official Node.js Alpine base image rather than from the application source code.

---

# Scan Result

The image was successfully scanned using Amazon Inspector Enhanced Scanning integrated with Amazon ECR.

The scan identified vulnerabilities in the OpenSSL package included in the base image.

No vulnerabilities were introduced by the application source code itself.

---

# Conclusion

Container image scanning was successfully implemented using Amazon ECR Enhanced Scanning.

The scan detected Critical, High, and Medium vulnerabilities within the operating system packages of the container image. These findings will be addressed by regularly updating the base image and rebuilding the container image as newer package versions become available.
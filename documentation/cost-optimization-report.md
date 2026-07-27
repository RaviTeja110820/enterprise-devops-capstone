# AWS Enterprise DevOps Capstone

# Phase 8 – Cost Optimization Report

## Project

Enterprise DevOps Capstone

---

# Objective

Review AWS resource usage, identify cost-saving opportunities, and propose optimizations for the deployed infrastructure.

---

# Infrastructure Reviewed

The following AWS services were evaluated:

- Amazon EKS
- Amazon EC2
- Amazon ECR
- Amazon VPC
- NAT Gateway
- Internet Gateway
- Elastic Load Balancer
- CloudWatch
- IAM
- AWS Secrets Manager

---

# Cost Explorer Review

AWS Cost Explorer was reviewed to understand current infrastructure costs.

The review included:

- Daily costs
- Monthly costs
- Cost by AWS service

Major contributors included:

- Amazon EKS Control Plane
- Amazon EC2 Worker Nodes
- NAT Gateway
- CloudWatch Logs
- Elastic Load Balancer

---

# Trusted Advisor Review

AWS Trusted Advisor was reviewed for cost optimization recommendations.

Categories reviewed:

- Cost Optimization
- Security
- Performance
- Fault Tolerance

If no recommendations were available, this is expected for AWS Basic Support accounts.

---

# Cost Saving Opportunities

## 1. Reduce Worker Node Size

Current:

- t3.small (or t3.medium)

Recommendation:

- Use smaller instances for development environments.
- Scale up only when additional capacity is required.

Expected Benefit:

Lower EC2 compute costs.

---

## 2. Enable Cluster Autoscaler

Current:

Fixed node count.

Recommendation:

Automatically remove unused worker nodes.

Expected Benefit:

Reduced EC2 usage during idle periods.

---

## 3. Use Spot Instances

Current:

ON_DEMAND

Recommendation:

Use Spot Instances for non-production workloads.

Expected Benefit:

Up to 70% lower EC2 costs.

---

## 4. Optimize CloudWatch Logs

Current:

CloudWatch log retention configured.

Recommendation:

Reduce retention period for development environments.

Expected Benefit:

Lower CloudWatch storage costs.

---

## 5. Delete Unused ECR Images

Recommendation:

Configure lifecycle policies to remove old images.

Expected Benefit:

Reduced ECR storage costs.

---

## 6. Delete Unused Load Balancers

Recommendation:

Delete unused Services of type LoadBalancer after testing.

Expected Benefit:

Lower Elastic Load Balancer charges.

---

## 7. Remove Unused Secrets

Recommendation:

Delete obsolete AWS Secrets Manager secrets.

Expected Benefit:

Reduced Secrets Manager costs.

---

## 8. Destroy Development Infrastructure

Recommendation:

Run Terraform destroy after completing the project.

```bash
terraform destroy -auto-approve
```

Expected Benefit:

Avoid unnecessary infrastructure charges.

---

# Best Practices

- Use Terraform to provision and destroy infrastructure.
- Delete unused AWS resources immediately after testing.
- Enable lifecycle policies for ECR.
- Monitor costs regularly using Cost Explorer.
- Review Trusted Advisor recommendations periodically.
- Use Auto Scaling where appropriate.
- Use Spot Instances for development environments.

---

# Conclusion

The AWS Enterprise DevOps infrastructure was reviewed using AWS Cost Explorer and Trusted Advisor.

Several opportunities were identified to reduce operational costs while maintaining application functionality.

The primary recommendations include:

- Right-size EC2 instances.
- Enable Auto Scaling.
- Use Spot Instances.
- Clean up ECR images.
- Reduce CloudWatch log retention.
- Destroy unused infrastructure after project completion.

These optimizations improve cost efficiency and align with AWS Well-Architected Framework best practices.
# Pipeline Debugging - Root Cause Analysis (RCA)

## Project

AWS Enterprise DevOps Capstone

---

## Issue Summary

The GitHub Actions Continuous Integration pipeline failed during the package installation stage.

---

## Failed Pipeline Stage

Install Packages

---

## Error Message

```
npm ERR! Unknown command: "installl"
```

GitHub Actions returned Exit Code 1.

---

## Root Cause

A typographical error was introduced into the GitHub Actions workflow.

The command

```yaml
run: npm installl
```

was incorrectly written.

The correct command is

```yaml
run: npm install
```

Because of this typo, npm could not recognize the command and terminated the workflow.

---

## Impact

- Dependency installation failed.
- Unit tests were skipped.
- SonarCloud analysis did not execute.
- Trivy scanning did not execute.
- Docker image was not built.
- Deployment pipeline was blocked.

---

## Resolution

The workflow file was corrected.

Incorrect

```yaml
run: npm installl
```

Correct

```yaml
run: npm install
```

---

## Validation

After correcting the workflow, the pipeline was triggered again.

The pipeline completed successfully.

All stages executed successfully:

- Checkout Repository
- Install Packages
- Run Unit Tests
- Build Application
- SonarCloud Scan
- Trivy Filesystem Scan
- Docker Build
- Trivy Image Scan
- Upload Artifact

---

## Lessons Learned

- Validate workflow syntax before committing.
- Review pipeline changes through Pull Requests.
- Enable branch protection rules.
- Perform peer review for CI/CD changes.
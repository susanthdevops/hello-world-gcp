# GCP Cloud Function with Load Balancer - Terraform Deployment

## Overview
This solution deploys a highly available Node.js "Hello World" Cloud Function across multiple GCP regions, exposed through a global HTTP Load Balancer with security best practices. The infrastructure is fully managed using Terraform with modular design

## Features
- **Multi-region Deployment**: Cloud Functions deployed in `us-central1` and `us-west1`
- **Global Load Balancing**: HTTP Load Balancer with serverless NEGs and failover
- **Security Controls**:
  - IAM role-based access for Cloud Functions
  - Audit logging with sensitive data exclusion
  - Outlier detection for automatic failover
- **Infrastructure as Code**:
  - Modular Terraform configuration
  - Variable-driven deployment
- **Observability**:
  - Cloud Audit Logs integration
  - Storage bucket for log archival

## Folder Structure
```
gcp-cloud-functions-lb/
├── modules/
│   └── audit-logs/          # Reusable audit logging module
├── function/                # Cloud Function source code
├── 1-provider.tf            # Terraform provider config
├── 2-service-accounts.tf    # IAM configuration
├── 3-cloud-functions.tf     # Function deployment
├── 4-negs.tf                # Network Endpoint Groups
├── 5-load-balancer.tf       # Load Balancer config
├── 6-iam.tf                 # Permissions
├── 7-audit-logs.tf          # Logging setup
├── outputs.tf               # Deployment outputs
├── variables.tf             # Configuration variables
└── terraform.tfvars         # Project-specific values
```

## Prerequisites
1. **GCP Account** with:
   - Billing enabled
   - Project Owner permissions
2. **Google Cloud SDK** installed and configured
3. **Terraform** v1.5+ installed
4. **Enable Required APIs**:
   ```bash
   gcloud services enable \
     cloudfunctions.googleapis.com \
     compute.googleapis.com \
     logging.googleapis.com \
     accesscontextmanager.googleapis.com
   ```

## Deployment Instructions

### 1. Clone Repository
```bash
git clone https://github.com/susanthdevops/hello-world-gcp.git
cd hello-world-gcp
cd gcp-cloud-functions-lb
```

### 2. Initialize Terraform
```bash
terraform init 
```
### 3. Validate Configuration
```bash
terraform validate
```

### 4. Plan Infrastructure
```bash
terraform plan -var="project_id=YOUR_PROJECT_ID"
```

### 5. Deploy Infrastructure
```bash
terraform apply -var="project_id=YOUR_PROJECT_ID" -auto-approve
```

## Verification & Testing

### Expected Outputs After Deployment
```bash
Outputs:

load_balancer_ip = "35.190.10.100"  # Random Public IP will be generated
primary_function_url = "https://us-central1-YOUR_PROJECT.cloudfunctions.net/hello-primary"  # URL includes your Project ID
secondary_function_url = "https://us-west1-YOUR_PROJECT.cloudfunctions.net/hello-secondary" # # URL includes your Project ID
```

### Test Through Load Balancer (Success Case)
**Browser Test:**
1. Open `http://LOAD_BALANCER_IP` in your browser
2. Should display "Hello World!"

**Terminal Test:**
```bash
curl http://$(terraform output -raw load_balancer_ip)
# Expected output: Hello World!
```

### Test Direct Function Access (Expected Failure)
```bash
# This should fail with 404 Page not found
curl $(terraform output -raw primary_function_url)
curl $(terraform output -raw secondary_function_url)
```

> **Note:** Direct function access is intentionally restricted (returns 404) to enforce security - only the Load Balancer can invoke the functions.

### Verify Failover
1. Manually disable primary function
2. Send 5 consecutive error requests to LB IP
3. Verify traffic fails over to secondary region

## Cleanup
```bash
terraform destroy -var="project_id=YOUR_PROJECT_ID" -auto-approve

```

## Key Implementation Details

### Node.js Cloud Function
```javascript
// function/index.js
const functions = require('@google-cloud/functions-framework');

functions.http('helloHttp', (req, res) => {
  res.send(`Hello ${req.query.name || req.body.name || 'World'}!`);
});
```

## Security Implementation
1. **Least Privilege IAM**:
   - Dedicated service account for Cloud Functions
   - Function-to-function invocation restricted
2. **Audit Logging**:
   - Centralized log bucket with retention
   - Data access logs excluded by default
3. **Network Security**:
   - Load Balancer ingress filtering
   - Function ingress restricted to internal/GCLB
4. **Operational Security**:
   - Remote state encryption
   - Automatic outlier detection


## Assignment Requirements Checklist
| Requirement | Implementation Status |
|-------------|-----------------------|
| Terraform IaC | ✅ Modular, Versioned, Remote State |
| Cloud Function | ✅ Multi-region Node.js 20 |
| Load Balancer | ✅ HTTP LB with Serverless NEGs |
| Security | ✅ IAM, Audit Logs, Network Controls |
| Documentation | ✅ Comprehensive README |
| Advanced Features | ✅ Failover, Modular Design |

**Note to Reviewers:** Full destruction command included to ensure cost control during evaluation.

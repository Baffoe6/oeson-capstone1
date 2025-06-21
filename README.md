# OESON Capstone: End-to-End CI/CD and Infrastructure for a Microservice on Kubernetes

## 📌 Project Overview
This capstone demonstrates a complete DevOps pipeline for deploying and managing a microservice on Kubernetes using modern tooling like Docker, Jenkins, Terraform, Helm, Prometheus, and Grafana on AWS.

---

## ✅ Tasks Completed

### 1. Dockerize a Microservice (Secure Non-Root Build)
- Dockerfile uses `python:3.11-slim` or `node:18-alpine`
- Multi-stage build with `appuser` (non-root)
- Exposed on port 8080
- Tagged as `dockerhub_username/app-name:version`

### 2. Kubernetes Manifests with Security Context
- All manifests stored in `k8s/` folder
- Deployment, Service, ConfigMap, Secret included
- Security: `runAsNonRoot: true`, `readOnlyRootFilesystem: true`
- Probes + Resource Limits enforced

### 3. Infrastructure Provisioning using Terraform on AWS
- Directory: `infra/terraform/`
- Resources:
  - VPC `devops-vpc`
  - Subnets: `subnet-a`, `subnet-b`
  - EC2 instances: Jenkins + Kubernetes Nodes (EKS)
  - Security Groups for SSH, HTTP, and NodePorts
- Output includes Jenkins IP and kubeconfig

### 4. Jenkins CI/CD Pipeline
- Jenkinsfile located at `cd-pipeline/Jenkinsfile`
- Pipeline:
  - Checkout code
  - Unit Tests (pytest or npm test)
  - Docker Build + Push to DockerHub
  - Deploy to K8s using `kubectl apply -f k8s/`

### 5. Monitoring with Prometheus and Grafana
- Helm charts deployed in `monitoring` namespace
- Grafana exposed via NodePort on port 30000
- Dashboards:
  - CPU/Memory per pod
  - HTTP request rate (if instrumented)

### 6. End-to-End Delivery Automation
- Jenkins pipeline runs:
  1. `terraform apply` for infra
  2. Ansible for provisioning (Jenkins, Docker, K8s, Helm)
  3. App Deployment
  4. Monitoring Setup (Helm install)

---

## 🧾 Directory Structure

```
oeson-capstone1/
├── docker/
│   └── Dockerfile
├── k8s/
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── configmap.yaml
│   └── secret.yaml
├── infra/
│   └── terraform/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
├── ansible/
│   └── playbooks/
│       ├── install-jenkins.yml
│       ├── install-docker.yml
│       ├── install-k8s.yml
│       └── install-monitoring.yml
├── cd-pipeline/
│   └── Jenkinsfile
├── monitoring/
│   └── values.yaml (optional)
└── README.md
```

---

## 🔐 Credentials and Secrets
- DockerHub, K8s credentials stored securely in Jenkins Credentials store.
- Access controlled via AWS IAM roles and security groups.

---

## 🚀 How to Deploy

```bash
# 1. Apply infrastructure
cd infra/terraform
terraform init
terraform apply

# 2. Run Ansible provisioning
ansible-playbook ansible/playbooks/install-all.yml

# 3. Push code to GitHub to trigger Jenkins pipeline
```

---

## 👨‍💻 Author
Lord Kingsley Baffoe 


# Lima with Garden Linux (from GCP)

## 📚 Table of Contents

- [Overview](#-overview)
- [Steps](#-steps)


## 🧰 Overview 
_This space describes the steps for setting up OIDC in GCP for creating uploading Qcow2 images and accessing it publicly_

## ✨ Steps

- Setting up OIDC for GCP
  -  Create Workload-identity-pool
  -  Create OIDC
  -  Verify the created identity-pool and fetch the name
  -  Create Service Account
  -  Create Authorization binding for the Identity and Service Account
  -  Add binding to the project 

## 🚀 Setting up OIDC for GCP

- Create Workload-identity-pool
```bash
gcloud iam workload-identity-pools create "github-pool" \
  --location="global" \
  --display-name="GitHub Actions Pool"
```

- Create OIDC
```bash
gcloud iam workload-identity-pools providers create-oidc "github-provider" \
  --location="global" \
  --workload-identity-pool="github-pool" \
  --display-name="GitHub Provider" \
  --issuer-uri="https://token.actions.githubusercontent.com" \
  --attribute-mapping="google.subject=assertion.sub,attribute.actor=assertion.actor,attribute.repository=assertion.repository,attribute.repository_owner=assertion.repository_owner" \
  --attribute-condition="attribute.repository_owner == 'saubhikdattagithub'"

Created workload identity pool provider [github-provider].
```

- Verify the created identity-pool and fetch the name
```bash
 gcloud iam workload-identity-pools describe github-pool \
  --location="global" \
  --format="value(name)"
projects/366393408502/locations/global/workloadIdentityPools/github-pool
![image](https://github.com/user-attachments/assets/c188cfc7-77c0-4be1-86b6-e771125d576d)
```

- Create Service Account
```bash
gcloud iam service-accounts create gha-sa \
  --display-name "GitHub Actions SA"
Created service account [gha-sa].
```

- Create Authorization binding for the Identity and Service Account
```bash
gcloud iam service-accounts add-iam-policy-binding gha-sa@heidelberg-417321.iam.gserviceaccount.com \
  --role roles/iam.workloadIdentityUser \
  --member "principalSet://iam.googleapis.com/projects/366393408502/locations/global/workloadIdentityPools/github-pool/attribute.repository/saubhikdattagithub/mygardenimage"
Updated IAM policy for serviceAccount [gha-sa@heidelberg-417321.iam.gserviceaccount.com].
bindings:
- members:
  - principalSet://iam.googleapis.com/projects/366393408502/locations/global/workloadIdentityPools/github-pool/attribute.repository/saubhikdattagithub/mygardenimage
  role: roles/iam.workloadIdentityUser
etag: BwY5U-ZvZiI=
version: 1
```

- Add binding to the project 
```bash
gcloud projects add-iam-policy-binding heidelberg-417321 \
  --member="serviceAccount:gha-sa@heidelberg-417321.iam.gserviceaccount.com" \
  --role="roles/storage.admin"
Updated IAM policy for project [heidelberg-417321].
bindings:
- members:
  - user:saubhikdatta@gmail.com
  role: roles/owner
- members:
  - serviceAccount:gha-sa@heidelberg-417321.iam.gserviceaccount.com
  - serviceAccount:poc-gardenlinux@heidelberg-417321.iam.gserviceaccount.com
  role: roles/storage.admin
etag: BwY5U-pBvKY=
version: 1
```

Enable IAM SA Cred API in GCloud
<img width="1405" alt="image" src="https://github.com/user-attachments/assets/71dc1482-d891-46d2-b32a-74f0456e163b" />





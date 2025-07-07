
# Lima with Garden Linux (from GCP)

## 📚 Table of Contents

- [Overview](#-overview)
- [Steps](#-steps)
- [Identification](#-identification)
- [Solution](#-solution)

## 🧰 Overview 
_This space describes the steps for setting up OIDC in GCP for creating uploading Qcow2 images and accessing it publicly_

## ✨ Steps

- 1. Setting up OIDC for GCP
- 2. 
- 3. 
- 4. 

## 🚀 Setting up OIDC for GCP

'''
gcloud iam workload-identity-pools create "github-pool" \
  --location="global" \
  --display-name="GitHub Actions Pool"
'''

'''
gcloud iam workload-identity-pools providers create-oidc "github-provider" \
  --location="global" \
  --workload-identity-pool="github-pool" \
  --display-name="GitHub Provider" \
  --issuer-uri="https://token.actions.githubusercontent.com" \
  --attribute-mapping="google.subject=assertion.sub,attribute.actor=assertion.actor,attribute.repository=assertion.repository,attribute.repository_owner=assertion.repository_owner" \
  --attribute-condition="attribute.repository_owner == 'saubhikdattagithub'"

![image](https://github.com/user-attachments/assets/29beb6f9-7c79-4214-864f-4458dcaeba03)

Created workload identity pool provider [github-provider].![image](https://github.com/user-attachments/assets/2310de16-bef8-4014-9d98-ccc015426293)
'''


 * Image is built by forking the gardenlinux repo in github.tools.sap to keep the packages and proprietary information internal to SAP
   - 

## ⚙️ Solution

 *
**Fix::** 
   - https://github.com/gardenlinux/package-libxml2/pull/3
   - https://github.com/gardenlinux/package-libxml2/commit/247c84c2966b99636d55e93cf8ddcf081ee3adf7
   - The above would ideally now fix the libxml2 package build during Image creation
---

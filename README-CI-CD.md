# GitHub Actions Setup Guide for Fashion App

## Introduction

This document guides you through setting up GitHub Actions to automatically deploy Fashion App backends (pybackend and fashion_payment) to an Azure VM when new code is pushed to GitHub.

## Setup Steps

### 1. SSH Key Setup

You already have an SSH key from your Azure VM to connect to the server. Now we need to use this key to allow GitHub Actions to connect to the VM.

#### Preparing the key for GitHub Actions

1. Open the private key file downloaded from Azure VM (usually with `.pem` extension)
2. Copy the entire content of this file, including both the header (`-----BEGIN RSA PRIVATE KEY-----`) and footer (`-----END RSA PRIVATE KEY-----`)

### 2. Setting up GitHub Secrets

In your GitHub repository, add the following secrets:

1. Go to repository > Settings > Secrets and variables > Actions
2. Add these secrets:
   - `AZURE_VM_HOST`: IP address of your Azure VM
   - `AZURE_VM_USERNAME`: SSH login username (usually adminuser on Azure VM)
   - `AZURE_VM_SSH_KEY`: Content of the private SSH key copied in step 1
   - `AZURE_VM_PORT`: SSH port (usually 22)
   - `PROJECT_PATH`: Path to the project folder on Azure VM (example: `/home/adminuser/fullstack-fashionapp`)

### 3. Setting up Git on Azure VM

1. Login to Azure VM:

   ```bash
   ssh adminuser@your-azure-vm-ip
   ```

2. If you haven't cloned the repository yet, run these commands:

   ```bash
   # Create project directory if it doesn't exist
   mkdir -p /path/to/project/folder
   cd /path/to/project/folder
   
   # Clone repository from GitHub
   git clone https://github.com/your-username/fullstack-fashionapp.git
   ```

3. Set up credentials to avoid entering password when pulling code:

   ```bash
   cd fullstack-fashionapp
   git config --global credential.helper store
   git pull  # Enter username/password to save in credential store
   ```

### 4. Checking the Workflow

Workflows are set to run when code is pushed to the `master` branch. You can trigger them manually by:

1. Going to the Actions tab in GitHub repository
2. Selecting the "Deploy to Azure VM" workflow
3. Clicking the "Run workflow" button
4. Selecting the `master` branch and clicking "Run workflow"

## References

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [SSH Action](https://github.com/appleboy/ssh-action)

## How to check backend status

After the workflow completes, you can check the status of the backends:

```bash
# Check Python backend
ssh adminuser@your-azure-vm-ip "cd /path/to/project/pybackend && python run_azure_server.py --action status"

# Check Node.js backend
ssh adminuser@your-azure-vm-ip "cd /path/to/project/fashion_payment && node run_azure_server.js status"
```

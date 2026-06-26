# 🚀 Terraform AWS Web Server


**Infrastructure as Code | Automated AWS Deployment | Zero Manual Setup**

---

## 📌 What This Project Does

This project automates the deployment of a **production-ready web server on AWS** using Terraform.

When you run `terraform apply`, it automatically:

✅ Creates a **Security Group** with HTTP, HTTPS & SSH access  
✅ Launches an **EC2 instance** (Ubuntu 22.04 LTS, t3.micro)  
✅ Installs & configures **Nginx** web server  
✅ Deploys a live website (accessible via public IP)  
✅ Outputs the server URL for immediate access

---

## 📂 Project Structure

```
├── main.tf           # EC2 instance + Security Group + Nginx setup
├── variables.tf      # Input variables (region, instance type, environment)
├── outputs.tf        # Outputs (public IP, security group ID)
└── README.md         # This file
```

---

## ⚙️ Tech Stack

| Technology | Purpose |
|-----------|---------|
| **Terraform** | Infrastructure as Code provisioning |
| **AWS EC2** | Cloud compute instance (t3.micro) |
| **Security Groups** | Network firewall configuration |
| **Nginx** | Web server |
| **Bash Script** | Automated server bootstrap |

---

## 🔧 How To Deploy

### Prerequisites
✅ Terraform installed ([download here](https://developer.hashicorp.com/terraform/downloads))  
✅ AWS CLI configured (`aws configure`)  
✅ AWS account with EC2 permissions

### Step-by-Step

**1. Clone repository**
```bash
git clone https://github.com/YOUR_USERNAME/terraform-aws-webserver.git
cd terraform-aws-webserver
```

**2. Initialize Terraform**
```bash
terraform init
```
This downloads required AWS provider plugins.

**3. Review the infrastructure plan**
```bash
terraform plan
```
This shows what will be created (no actual changes yet).

**4. Deploy infrastructure**
```bash
terraform apply
```
Type `yes` when prompted. Wait 2-3 minutes for EC2 to initialize.

**5. Access your server**
After deployment completes, you'll see outputs like:
```
Outputs:

instance_public_ip = "54.123.45.67"
web_server_url = "http://54.123.45.67"
```

Copy the IP and paste in browser to see Nginx running.

**6. Clean up (important to avoid AWS charges)**
```bash
terraform destroy
```
Type `yes` to remove all resources.

---

## 📋 Configuration Variables

| Variable | Description | Default Value |
|----------|-------------|----------------|
| `aws_region` | AWS region for resources | `ap-south-1` |
| `instance_type` | EC2 instance size | `t3.micro` |
| `environment` | Environment tag | `dev` |

To use custom values, create a `terraform.tfvars` file:
```hcl
aws_region   = "us-east-1"
instance_type = "t3.micro"
environment   = "production"
```

---

## 🔐 Security Group Rules

| Type | Protocol | Port | Source | Purpose |
|------|----------|------|--------|---------|
| HTTP | TCP | 80 | 0.0.0.0/0 | Web traffic |
| HTTPS | TCP | 443 | 0.0.0.0/0 | Secure web traffic |
| SSH | TCP | 22 | 0.0.0.0/0 | Remote access |

**⚠️ Security Note:** SSH is open to all IPs (0.0.0.0/0) for development. In production, restrict to your IP address.

---

## 📊 What Gets Deployed

### Infrastructure Components
- **VPC:** Default VPC
- **EC2 Instance:** Ubuntu 22.04 LTS (t3.micro - free tier eligible)
- **Security Group:** 3 inbound rules + 1 outbound rule
- **Public IP:** Automatically assigned

### Software Installed
- Nginx web server (via user_data script)
- System updated and configured

---

## 🎓 Learning Outcomes

From this project, you'll understand:

1. **Terraform basics**
   - Provider configuration
   - Resource declaration
   - State management

2. **AWS Concepts**
   - EC2 instance types
   - Security groups
   - Public/private IPs

3. **Infrastructure as Code**
   - Why IaC is better than manual setup
   - Reproducibility
   - Version control for infrastructure

4. **Automation**
   - User data scripts
   - Bootstrap configuration
   - Hands-off deployment

---

## 🛠️ Troubleshooting

### "terraform init" fails
```
Solution: Ensure AWS credentials are configured
$ aws configure
```

### EC2 instance created but Nginx not running
```
Wait 2-3 minutes for user_data script to complete
SSH into instance and check: systemctl status nginx
```

### Can't SSH to instance
```
Check that port 22 is allowed in Security Group
Verify your IP is in the CIDR block or set to 0.0.0.0/0
```

### "AccessDenied" error
```
Ensure your AWS IAM user has EC2, VPC, and Security Group permissions
```

---

## 📝 Project Details

**Status:** ✅ Complete  
**Last Updated:** June 2026  
**AWS Free Tier Eligible:** Yes (t3.micro)  
**Estimated Cost:** $0 (within free tier limits)

---

## 🚀 Next Steps

After mastering this project:

1. Add **RDS database** for data persistence
2. Implement **auto-scaling groups**
3. Deploy **load balancer** for multiple instances
4. Add **monitoring and logging**
5. Implement **CI/CD pipeline** for automatic deployments

---

## 📚 Resources

- [Terraform AWS Provider Docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS EC2 Documentation](https://docs.aws.amazon.com/ec2/)
- [Nginx Documentation](https://nginx.org/en/docs/)
- [Terraform Official Tutorials](https://developer.hashicorp.com/terraform/tutorials)

---

## 💡 Tips

✅ Always run `terraform plan` before `terraform apply`  
✅ Use `terraform state list` to see created resources  
✅ Use `terraform destroy` to avoid unexpected charges  
✅ Keep your `terraform.tfstate` file safe (contains sensitive data)  
✅ Use remote state (S3) for team projects  

---

**Happy Infrastructure Coding! 🚀**

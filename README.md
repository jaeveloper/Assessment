
# Cloud Infrastructure Engineer Assessment — Hub & Spoke Deployment By Joshua Ukpozi

---

[![Terraform](https://img.shields.io/badge/Terraform-9B59B6?style=for-the-badge&logo=terraform&logoColor=white)]
[![Azure](https://img.shields.io/badge/Microsoft%20Azure-0078D4?style=for-the-badge&logo=microsoft-azure&logoColor=white)]

---

## 📄 Project Summary

This repo contains a reusable Terraform implementation of a **Hub & Spoke** network on Azure, deployed with cost and security best-practices:

- Hub VNet + two Spoke VNets (VM1 in Spoke1, VM2 in Spoke2)  
- VNet peering Hub ↔ Spoke1 & Spoke2  
- NSGs, route table(s), UDRs pointing spokes to hub VPN gateway  
- Azure Bastion for secure access (no public IPs on VMs)  
- Self-hosted GitHub Actions runner (local) for CI/CD pipelines  
- All resources modularized for reusability

---

## 🏛 Architecture Diagram

<img width="924" height="510" alt="image" src="https://github.com/user-attachments/assets/6f8b37e2-d4e4-4f91-994c-eae33356be84" />

*IMAGE 1 — Hub & Spoke architecture diagram (Hub VNet, Spoke1, Spoke2, Bastion, VNG, peering)*

---

## 📦 Repo Structure

├── modules/

│ ├── network/

│ ├── nsg/

│ ├── vm/

│ ├── bastion/

│ ├── vng/

│ └── routes/

├── main.tf

├── variables.tf

├── outputs.tf

└──  README.md



---

## 🧾 Key Screenshots / Evidence

**Terraform code snapshot**  
<img width="1033" height="499" alt="image" src="https://github.com/user-attachments/assets/73eb1ae0-6e2f-4dcd-a23c-a7f1b635f10e" />

*IMAGE 2 — key module layout and sample resource blocks*

**Terraform apply output**  
<img width="953" height="464" alt="image" src="https://github.com/user-attachments/assets/4dadaaf2-4632-44b4-8279-504e4cb333cd" />

*IMAGE 3 — `terraform apply` console output showing success*

**Resources deployed in Azure Portal**  
<img width="976" height="509" alt="image" src="https://github.com/user-attachments/assets/1633dabf-7740-4afd-bf47-017b6cf8892d" />

*IMAGE 4 — Portal view: Hub & Spoke VNets, Bastion, VNG, NSGs, VMs*

**Connectivity proof (VM1 → VM2)**  
<img width="1002" height="447" alt="image" src="https://github.com/user-attachments/assets/04fbb1ef-f872-4218-9629-7e0556be82e3" />

*IMAGE 5 — VM1 (10.1.0.4) successfully pinging VM2 (10.2.0.4)*

**Connectivity proof (VM2 → VM1)**  
<img width="978" height="459" alt="image" src="https://github.com/user-attachments/assets/929d20b9-654a-4791-bab6-a86c11f472ad" />

*IMAGE 6 — VM2 (10.2.0.4) successfully pinging VM1 (10.1.0.4)*

**Self-hosted runner setup**  
<img width="1002" height="455" alt="image" src="https://github.com/user-attachments/assets/22a9107c-df84-4302-9448-800dc72cc523" />

*IMAGE 7 — Installation steps / console for self-hosted runner*

**Runner status in GitHub repo**  
<img width="987" height="495" alt="image" src="https://github.com/user-attachments/assets/8f9b3c99-0216-48d9-a227-a4a43945dfb9" />

*IMAGE 8 — Runner shown in repository settings*

**Workflow run using self-hosted runner**  
<img width="1013" height="512" alt="image" src="https://github.com/user-attachments/assets/c6719f98-f539-4848-84a1-83bec459c64f" />

-----
<img width="1090" height="149" alt="image" src="https://github.com/user-attachments/assets/1ed5a7a5-a31f-4990-8110-dc098ae9599c" />

*IMAGE 9 — Successful workflow run in GitHub Actions*

<img width="1886" height="1057" alt="image" src="https://github.com/user-attachments/assets/e1e0577c-dfcf-41f6-a3b6-f48bc9f2f89e" />

*IMAGE 10 — cleaning up infrastructure*

---

## 🔐 Security & Cost Optimization (Design Choices)

**Security**
- **No public IPs** attached to VMs — access via **Azure Bastion**.
- NSGs follow least privilege (allow only required ports; ICMP allowed inside VNet for test).
- Hub-and-Spoke isolates network segments; central control in Hub.
- Route tables / UDRs ensure traffic flows via VNG where required.

**Cost Optimization**
- Minimal viable SKUs (e.g., `VpnGw1` where necessary, conservative VM sizes).
- Avoided unnecessary public IP addresses and unused services.
- Single route table reused across spokes where appropriate.
- Destroy resources with `terraform destroy` after validation to avoid charges.

---

## ⚙️ Deploy Steps (short)

1. `terraform init`  
2. `terraform plan `  
3. `terraform apply -auto-approve`

**Destroy:**

```bash
terraform destroy -auto-approve
```

Author
Joshua Ukpozi – Cloud & Infrastructure Engineer
LinkedIn: https://www.linkedin.com/in/joshua-ukpozi




















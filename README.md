# AWS EBS + Linux Storage Operations

Production-oriented hands-on project demonstrating how AWS Elastic Block Store (EBS) volumes are provisioned, attached to Amazon EC2, initialized and managed from Linux, mounted persistently, and expanded online with XFS.

The project focuses on the operational boundary between AWS infrastructure and the Linux operating system — the same workflow a Cloud Engineer uses when managing application and data storage on EC2 workloads.

---

## Objective

The objective of this project is to build practical proficiency in:

- AWS EBS volume provisioning
- EC2 volume attachment
- Linux block-device discovery
- Filesystem identification
- XFS filesystem creation
- Linux filesystem mounting
- Persistent filesystem configuration
- Storage validation and write testing
- EBS volume expansion
- Online XFS filesystem expansion
- Post-change verification
- Safe operational change practices

---

## Architecture

```text
                    AWS Cloud
                        │
                        ▼
                 ┌─────────────┐
                 │    EC2      │
                 │  Instance   │
                 └──────┬──────┘
                        │
                        │ Attach
                        ▼
                 ┌─────────────┐
                 │   AWS EBS   │
                 │   Volume    │
                 └──────┬──────┘
                        │
                        ▼
              Linux Block Device
                 /dev/nvme1n1
                        │
                        ▼
                 XFS Filesystem
                        │
                        ▼
                     /data
                        │
                        ▼
              Application / Data Files

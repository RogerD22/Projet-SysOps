# 🚀 Projet SysOps - Infrastructure et Configuration Automatisées

## 📋 Description

Ce projet implémente une solution complète d'Infrastructure as Code (IaC) et de Configuration Management pour déployer automatiquement un serveur web Ubuntu sur AWS.

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                        AWS Cloud                            │
│  ┌─────────────────────────────────────────────────────┐    │
│  │                VPC (10.0.0.0/16)                    │    │
│  │  ┌─────────────────────────────────────────────┐    │    │
│  │  │         Subnet (10.0.1.0/24)                │    │    │
│  │  │  ┌─────────────────────────────────────┐    │    │    │
│  │  │  │     EC2 Instance Ubuntu 22.04       │    │    │    │
│  │  │  │     - Nginx                         │    │    │    │
│  │  │  │     - MySQL                         │    │    │    │
│  │  │  │     - Utilisateur deployer          │    │    │    │
│  │  │  └─────────────────────────────────────┘    │    │    │
│  │  └─────────────────────────────────────────────┘    │    │
│  │                                                     │    │
│  │  Internet Gateway ←→ Route Table                    │    │
│  └─────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────┘
```

## 🛠️ Technologies Utilisées

- **Terraform** : Provisioning de l'infrastructure AWS
- **Ansible** : Configuration et déploiement des services
- **AWS** : Cloud provider (région eu-west-3)
- **Ubuntu 22.04** : Système d'exploitation
- **Nginx** : Serveur web
- **MySQL** : Base de données

## 📁 Structure du Projet

```
projet_sysops/
├── README.md                         # Documentation du projet
├── terraform/                        # Infrastructure as Code
│   ├── main.tf                       # Ressources AWS principales
│   ├── variables.tf                  # Variables Terraform
│   ├── output.tf                     # Outputs Terraform
│   ├── boot.sh                       # Script d'initialisation
│   └── terraform.tfvars              # Valeurs des variables
└── ansible/                          # Configuration Management
    ├── playbook.yml                  # Playbook principal
    ├── inventory/
    │   └── prod.ini                  # Inventaire des serveurs
    ├── group_vars/
    │   └── all.yml                   # Variables globales
    └── roles/                        # Rôles Ansible
        ├── common/                   # Mise à jour système
        ├── users/                    # Gestion des utilisateurs
        ├── nginx/                    # Installation Nginx
        ├── mysql/                    # Installation MySQL
        └── firewall/                 # Configuration firewall
```



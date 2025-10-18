# VM-Network Troubleshooting, Firewall Configuration and Nmap scan.

The network_check.sh script automates network checks and a basic scan on Kali to Check interface status and run a simple nmap scan.

Usage: 
Clone this repository:git clone <repo-url>
Navigate to the directory and make the script executable:cd <repo-folder>
chmod +x network_check.sh
Run the script with sudo:sudo ./network_check.sh <target-ip>
Replace <target-ip> with your Windows VM IP .

A guide and script to troubleshoot network connectivity between VMs and to configure firewall rules on Windows based on a real-world lab setup.

This repository documents a hands-on troubleshooting journey to enable network communication between VMs and configure firewall rules. The setup addresses VMware bridged networking issues, Windows firewall configuration and service enabling.

Background:
The goal was to scan a Windows VM from a Kali VM using nmap. Initial issues included subnet mismatches due to Hyper-V interference with VMware’s bridged networking and a Windows VM firewall blocking ports because its network profile was set to Public.

Steps Taken: 

(1)Diagnose Network Configuration:

Check IPs 
on Kali : ifconfig eth1
on  Windows:  ipconfig
Identified Wi-Fi adapter on the host:  netsh wlan show interfaces


(2) Fix VMware Bridged Networking:

Open VMware Virtual Network Editor (as admin), set VMnet0 to the Wi-Fi adapter (not Automatic).
Renew IPs: sudo dhclient eth1 (Kali), ipconfig /renew (Windows).
Ensure both VMs used the correct subnet by running step (1) codes.


(3) Enable Services on Windows VM:

Enable Remote Desktop (RDP, port 3389) via Settings.
Enable File Sharing (SMB, ports 139, 445) in Advanced Sharing Settings.
Verify with :   netstat -ano | findstr "3389 445"


(4) Configure Windows Firewall:

Switch network profile to Private: Set-NetConnectionProfile -InterfaceAlias "Ethernet0" -NetworkCategory Private.
Create inbound rules for TCP ports 80,135,139,445,3389, scoped to Kali’s IP, using Private profile.


(5) Run nmap Scans:
Execute: sudo nmap -sS -sV -v 192.168.1.102 to detect open ports and services.



Feel free to fork, modify, or contribute.  

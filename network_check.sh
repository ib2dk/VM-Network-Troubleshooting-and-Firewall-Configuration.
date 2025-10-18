#!/bin/bash

# Check if target IP is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <target-ip>"
  exit 1
fi

TARGET_IP=$1

# Display network interface status
echo "Checking network interfaces on Kali..."
ifconfig eth1

# Perform a basic nmap scan
echo "Running nmap scan on $TARGET_IP..."
sudo nmap -sS -v $TARGET_IP

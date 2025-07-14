#!/bin/bash

cat << "EOF"
 _   _      _            _                            
| \ | | ___| |_ __ _  __| | ___ _ __ ___   ___  _ __  
|  \| |/ _ \ __/ _` |/ _` |/ _ \ '_ ` _ \ / _ \| '_ \ 
| |\  |  __/ || (_| | (_| |  __/ | | | | | (_) | | | |
|_| \_|\___|\__\__,_|\__,_|\___|_| |_| |_|\___/|_| |_|                                                   
EOF

echo "🔍 NetScan v1.0 – A Bash-based Network Scanner"
echo " Created by: Jitesh Bagale"
echo "Powered by Kali Linux"
echo "⚙️  Use with root for best results"
echo "==========================================="

if [ "$EUID" -ne 0 ]; then
echo "This Script must be run as root. Use: sudo ./netscan.sh"
exit 1
fi


#===================================
#      Subnet Detection
#===================================

local_ip=$(ip route get 1.1.1.1 | awk '{print $7}' | head -1)
subnet=$(echo $local_ip |  cut -d '.' -f 1-3).0/24

echo "Detected local subnet: $subnet"
read -p "Enter target IP range (press Enter to use default): " ip_range

ip_range=${ip_range:-$subnet}

echo "target subnet set to: $ip_range"

#===================================
#      Ping Sweep Logic
#===================================

echo "Starting live host discovery on $ip_range..."
live_hosts=()

for ip in $(seq 1 254); do
    target_ip="${ip_range%.*}.$ip"
    
    (ping -c 1 -W 1 $target_ip > /dev/null 2>&1 &&
    echo "Host up: $target_ip" &&
    live_hosts+=("$target_ip")) &
done

wait
echo "Host discovery complete"
echo $target_ip >> live_hosts.txt

#===================================
#      Port Scanning
#===================================

echo
read -p "Enter an IP from live hosts above to scan ports: " target_ip

common_ports=(21 22 23 25 53 80 110 139 443 445)
echo "Scanning common ports on $target_ip..."

  for port in "${common_ports[@]}"; do
  timeout 1 bash -c "echo > /dev/tcp/$target_ip/$port" 2>/dev/null &&
     echo "🟢 Port $port is OPEN" ||
     echo "X Port $port is closed"
done

# ========================
#      Nmap Scan
# ========================
echo
read -p "Do you want to run an Nmap service scan on $target_ip? (y/n): " run_nmap

if [[ "$run_nmap" == "y" || "$run_nmap" == "Y" ]]; then
  echo " Running Nmap on $target_ip..."
  nmap -sV $target_ip
  echo "Service scan complete."
else
  echo "⏭️ Skipping service detection..."
fi

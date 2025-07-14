**🛡️ NetScan v1.0** — Bash Network Scanner
A simple, interactive network scanner built using pure Bash on Kali Linux.
NetScan helps discover live hosts, open ports, and services within your local network — ideal for beginners in DevOps, Linux, or Cybersecurity roles.

🚀 Features
✅ Auto Subnet Detection — detects your local IP range or allows manual input

✅ Live Host Discovery (Ping Sweep) — finds reachable devices in your network

✅ Port Scanning (Common Ports) — scans top TCP ports like SSH, HTTP, HTTPS, etc.

✅ Optional Nmap Integration — runs advanced service/version detection

✅ Gamified CLI Flow — structured as a level-wise interactive script

✅ Lightweight & Fast — uses standard Linux tools without extra dependencies

🧰 Tools & Concepts Used
Category:	Tools/Concepts
Scripting:	Bash scripting, functions, loops
Networking:	ICMP (ping), TCP, subnetting
Utilities:	ping, bash TCP sockets, timeout
Advanced Option:	Nmap service detection (-sV)
Linux Skills:	CLI, root privilege scripting

📖 How to Use
bash
git clone https://github.com/Lunatic5565/netscan-bash.git
cd netscan-bash
chmod +x netscan.sh
sudo ./netscan.sh
⚠️ Root access is required for full functionality (ping & port scanning).


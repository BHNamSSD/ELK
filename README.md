# ELK
- ELK SOC
- Link Inciden Report: https://drive.google.com/drive/folders/1Qnku5wpwfOQ6rRY1La3a0lDebusTeU7z?usp=sharing

🔐 ELK Stack SIEM Lab – Log Monitoring & Incident Detection
📌 Overview

This project demonstrates the deployment of a full SIEM (Security Information and Event Management) system using the ELK Stack (Elasticsearch, Logstash, Kibana) to collect, process, and analyze logs from multiple sources in a simulated enterprise environment.

The lab focuses on real-world attack detection, log correlation, and incident response workflows, making it suitable for SOC Analyst and Blue Team practice.

🏗️ Architecture

The system is built on a virtualized infrastructure using Proxmox, including:

ELK Stack
Elasticsearch – Log storage and indexing
Logstash – Log processing and parsing
Kibana – Visualization and detection dashboards
Log Sources
🌐 Web Server (bhnamssd.online)
🖥️ Windows Server (Event Logs)
🧭 DNS Server
🔥 Firewall logs
🐧 Linux (Auth.log, Syslog)
Supporting Services
📡 Internal DNS
💾 Storage system (DSM)
📧 Email notification system (Postfix)
⚙️ Key Features
📥 Log Collection & Processing
Centralized log ingestion using Logstash pipelines
Parsing multiple log formats:
Windows Event Logs
Nginx / Web logs
Syslog / Auth.log
Normalization for analysis and correlation
📊 Detection & Visualization
Built custom Kibana dashboards for:
Authentication activity monitoring
Network traffic analysis
Web access patterns
Developed detection rules for:
🚨 RDP Brute-force attacks
🚨 SSH Brute-force attempts
🚨 Web scanning (e.g. directory brute-force, abnormal requests)
🔍 Threat Hunting & Analysis
Identified Indicators of Compromise (IOCs):
Malicious IP addresses
Suspicious login behavior
Abnormal access patterns
Correlated logs across multiple sources to detect attack chains
🚑 Incident Response

Performed incident handling following standard IR process:

Detection – Alert triggered from Kibana dashboards
Analysis – Investigate logs and identify attack patterns
Containment – Determine affected systems/services
Eradication – Remove threat indicators
Recovery – Restore normal operations
Lessons Learned – Improve detection rules
🧪 Example Use Cases
Detect multiple failed login attempts (Event ID 4625)
Identify successful brute-force compromise (4624 after many 4625)
Monitor SSH login attempts from suspicious IPs
Detect web scanning via abnormal request frequency
🛠️ Technologies Used
ELK Stack (Elasticsearch, Logstash, Kibana)
Proxmox Virtualization
Linux (Syslog, Auth.log)
Windows Server (Event Logs)
Postfix (Email alerts)
Nginx Web Server
📸 Screenshots (Optional)

Add screenshots of:

Kibana dashboards
Logstash pipeline configs
Attack detection visualizations
🎯 Learning Outcomes
Hands-on experience with SIEM deployment
Log analysis across multiple platforms
Detection engineering (rule creation)
Incident response workflow
Threat hunting techniques
🚀 Future Improvements
Integrate Wazuh / Elastic Security
Add automated alerting (Slack/Telegram)
Implement MITM or lateral movement detection
Expand threat intelligence integration
👨‍💻 Author

Phạm Huy Nam
SOC Tier 1 Analyst (Aspiring)

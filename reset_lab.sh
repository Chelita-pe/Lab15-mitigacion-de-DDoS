#!/usr/bin/env bash
set -euo pipefail

echo "[+] Restaurando el laboratorio al estado original (Vulnerable)..."

iptables -D INPUT -p tcp --syn --dport 80 -m limit --limit 10/s --limit-burst 15 -j ACCEPT 2>/dev/null || true
iptables -D INPUT -p tcp --syn --dport 80 -j DROP 2>/dev/null || true
iptables -D INPUT -p tcp --dport 80 -m string --string "db.sql" --algo bm -j DROP 2>/dev/null || true

echo "[✓] Reglas del firewall removidas. El servidor vuelve a estar desprotegido."

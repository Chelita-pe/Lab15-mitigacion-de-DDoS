#!/usr/bin/env bash
set -euo pipefail

echo "========================================================"
echo "[+] Iniciando plan de respuesta ante incidentes..."
echo "========================================================"

iptables -D INPUT -p tcp --syn --dport 80 -m limit --limit 10/s --limit-burst 15 -j ACCEPT 2>/dev/null || true
iptables -D INPUT -p tcp --syn --dport 80 -j DROP 2>/dev/null || true
iptables -D INPUT -p tcp --dport 80 -m string --string "db.sql" --algo bm -j DROP 2>/dev/null || true

iptables -A INPUT -p tcp --dport 80 -m string --string "db.sql" --algo bm -j DROP

iptables -A INPUT -p tcp --syn --dport 80 -m limit --limit 10/s --limit-burst 15 -j ACCEPT
iptables -A INPUT -p tcp --syn --dport 80 -j DROP

echo "========================================================"
echo "[✓] ¡Mitigación completada con éxito!"
echo "========================================================"

#!/bin/bash

echo "=========================================="
echo "    vavoo Automatisches Installationsprogramm"
echo "=========================================="

# 1. Systempakete und Build-Tools (Rust, Clang usw.) aktualisieren und installieren
echo "[+] Systempakete und Build-Tools (Rust, Clang usw.) werden aktualisiert und installiert..."
pkg update -y && pkg upgrade -y
pkg install -y python python-pip git curl libxml2 libxslt rust clang build-essential

# 2. Python-Umgebung (venv) im Ordner 'vavoo' erstellen
echo "[+] Python-Umgebung (venv) wird im Ordner 'vavoo' vorbereitet..."
python -m venv ~/vavoo
source ~/vavoo/bin/activate

# 3. Pip-Aktualisierung und Installation aus dem offiziellen Mastaaa1987/vxparser-Repository
echo "[+] vxparser wird aus dem GitHub-Repository installiert..."
pip install --upgrade pip
pip install git+https://github.com/Mastaaa1987/vxparser.git

# 4. .bashrc-Einstellung für den automatischen Start beim Öffnen von Termux
echo "[+] Automatischer Start wird konfiguriert..."
if ! grep -q "vavoo/bin/activate" ~/.bashrc; then
    echo "" >> ~/.bashrc
    echo "# vavoo Automatischer Start" >> ~/.bashrc
    echo "source ~/vavoo/bin/activate && vxparser" >> ~/.bashrc
fi

echo "=========================================="
echo "    INSTALLATION ERFOLGREICH ABGESCHLOSSEN! "
echo "=========================================="
echo "vxparser startet automatisch, sobald Sie Termux neu starten."

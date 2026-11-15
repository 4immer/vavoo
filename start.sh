#!/data/data/com.termux/files/usr/bin/bash

echo "=========================================="
echo "   VAVOO / VXPARSER INSTALLATION STARTET  "
echo "=========================================="

echo "[+] Systempakete werden aktualisiert und installiert..."
pkg update -y && pkg upgrade -y
pkg install -y python python-pip git curl libxml2 libxslt rust clang build-essential

echo "[+] Virtuelle Umgebung (vavoo) wird erstellt..."
python -m venv ~/vavoo
source ~/vavoo/bin/activate

echo "[+] Pip wird aktualisiert und vxparser wird installiert..."
pip install --upgrade pip wheel setuptools
pip install git+https://github.com/Mastaaa1987/vxparser.git

echo "[+] Automatischer Start wird konfiguriert..."
touch ~/.bashrc
if ! grep -q "source ~/vavoo/bin/activate" ~/.bashrc; then
    echo "source ~/vavoo/bin/activate && vxparser" >> ~/.bashrc
fi

echo "=========================================="
echo "  INSTALLATION ERFOLGREICH ABGESCHLOSSEN! "
echo "=========================================="
echo "vxparser startet automatisch, sobald Sie Termux neu starten."

#!/data/data/com.termux/files/usr/bin/bash

echo "=========================================="
echo "Vavoo / VXParser Installation wird gestartet..."
echo "=========================================="

# Systempakete aktualisieren und Abhängigkeiten installieren
echo "[1/5] Systempakete werden installiert..."
apt update && apt full-upgrade -y
pkg install -y python python-pip git curl libxml2 libxslt rust clang build-essential binutils maturin

# Virtuelle Umgebung erstellen
echo "[2/5] Virtuelle Python-Umgebung wird eingerichtet..."
deactivate 2>/dev/null
rm -rf ~/vavoo
python -m venv ~/vavoo
source ~/vavoo/bin/activate

# Architektur prüfen (32-Bit ARM Fix für pydantic-core)
ARCH=$(uname -m)
echo "[3/5] Architektur erkannt: $ARCH"
if [[ "$ARCH" == "armv7l" || "$ARCH" == "armv8l" || "$ARCH" == "arm" ]]; then
    echo "32-Bit ARM erkannt -> Installiere leichtgewichtiges pydantic<2 (ohne Rust-Kompilierung)..."
    pip install --no-build-isolation "pydantic<2"
fi

# VXParser installieren
echo "[4/5] VXParser wird installiert..."
pip install --no-build-isolation git+https://github.com/Mastaaa1987/vxparser.git

# Autostart in .bashrc einrichten
echo "[5/5] Autostart wird konfiguriert..."
if ! grep -q "vavoo/bin/activate" ~/.bashrc; then
    echo "" >> ~/.bashrc
    echo "# Vavoo Autostart" >> ~/.bashrc
    echo "source ~/vavoo/bin/activate && vxparser" >> ~/.bashrc
fi

echo "=========================================="
echo "Installation abgeschlossen! VXParser startet..."
echo "=========================================="
vxparser

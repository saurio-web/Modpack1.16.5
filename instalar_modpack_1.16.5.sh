#!/bin/bash

# Detener el script si ocurre algún error
set -e

# --- CONFIGURACIÓN ---
MC_VERSION="1.16.5"
FABRIC_INSTALLER_URL="https://maven.fabricmc.net/net/fabricmc/fabric-installer/1.1.2/fabric-installer-1.1.2.jar"
MODPACK_URL="https://download1532.mediafire.com/y1ydvli42kkgC2jgNOYEsDInyKvdgqUftP37gIfuW659DB2We6TeQwEnc8tFRLd_T53ux5uGdvriB8QJ-b-jFA23UQ7GARc5dBi5Gpwy-OQuTkAbPu3wcneK78Ha1iNA_-iRKh47557h7gTmSXYu2ZTSIHvYGqH1rU3I_nOptxZuykc/tunpssjcbqfdp6q/MODpack.zip.tar.gz"
FILE_NAME="MODpack.zip.tar.gz"

echo "=== INICIANDO INSTALACIÓN PARA MINECRAFT $MC_VERSION ==="

# 1. Descargar el MODpack desde MediaFire
echo "[1/4] Descargando MODpack..."
wget -O "$FILE_NAME" "$MODPACK_URL"

# 2. Descomprimir el archivo comprimido
echo "[2/4] Descomprimiendo $FILE_NAME..."
tar -xzvf "$FILE_NAME"

# Eliminar el archivo comprimido descargado para ahorrar espacio
rm "$FILE_NAME"

# 3. Descargar e instalar Fabric Client (versión 1.1.2 para Minecraft 1.16.5)
echo "[3/4] Descargando e instalando el instalador de Fabric..."
wget -O fabric-installer.jar "$FABRIC_INSTALLER_URL"

echo "Ejecutando el instalador para Minecraft $MC_VERSION..."
java -jar fabric-installer.jar client -minecraftversion "$MC_VERSION" -noprofile

# Limpiar el archivo JAR del instalador
rm fabric-installer.jar

# 4. Mostrar el contenido de la carpeta descomprimida
echo "[4/4] Verificando la carpeta MODpack..."
if [ -d "MODpack" ]; then
    ls -lh MODpack/
fi

echo "================================================="
echo "¡Instalación completada con éxito!"
echo "================================================="

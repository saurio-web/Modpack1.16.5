#!/bin/bash

set -e

MC_VERSION="1.16.5"
FABRIC_INSTALLER_URL="https://maven.fabricmc.net/net/fabricmc/fabric-installer/1.1.2/fabric-installer-1.1.2.jar"
FILE_NAME="MODpack.zip.tar.gz"
MINECRAFT_DIR="$HOME/.minecraft"

echo "=== INICIANDO INSTALACIÓN PARA MINECRAFT $MC_VERSION ==="

# 1. Omitimos la descarga web y usamos el archivo local
echo "[1/4] Usando el archivo local $FILE_NAME..."
if [ ! -f "$FILE_NAME" ]; then
    echo "¡Error! No se encuentra el archivo $FILE_NAME en la carpeta actual."
    exit 1
fi

# 2. Descomprimir el archivo comprimido
echo "[2/4] Descomprimiendo $FILE_NAME..."
tar -xzvf "$FILE_NAME"

# Opcional: conservar o eliminar el archivo local (aquí no se borra por seguridad)

# 3. Descargar e instalar Fabric Client
echo "[3/4] Descargando e instalando el instalador de Fabric..."
wget -O fabric-installer.jar "$FABRIC_INSTALLER_URL"

echo "Ejecutando el instalador para Minecraft $MC_VERSION..."
java -jar fabric-installer.jar client -minecraftversion "$MC_VERSION" -noprofile

rm fabric-installer.jar

# 4. Copiar el contenido de MODpack a .minecraft
echo "[4/4] Copiando archivos a $MINECRAFT_DIR..."
mkdir -p "$MINECRAFT_DIR"

if [ -d "MODpack" ]; then
    cp -r MODpack/* "$MINECRAFT_DIR/"
    rm -rf MODpack
else
    echo "Advertencia: No se encontró la carpeta MODpack para copiar."
fi

echo "================================================="
echo "¡Instalación completada con éxito!"
echo "================================================="

#!/bin/bash
VERSION=$(grep 'config/version=' project/project.godot | sed -E 's/^config\/version="([^"]+)"/v\1/')
APP_NAME="App Downloader"
APP_DIR="application/${APP_NAME}"
ARCHIVE_NAME="App_Downloader"
GLYPH_DIR="opt/muos/default/MUOS/theme/active/glyph/muxapp"

echo "Cleaning up"
rm -rf .build/ || { echo "Error: Failed to clean up .build directory"; exit 1; }
rm -f ".dist/${ARCHIVE_NAME}_${VERSION}.muxzip" || { echo "Error: Failed to clean up old archive"; exit 1; }

mkdir -p .build/"${APP_DIR}"
mkdir -p .build/"${GLYPH_DIR}"
mkdir -p .dist

echo "Building ${APP_NAME} ${VERSION}..."

echo "Copying files..."
cp -r mux_launch.sh .build/"${APP_DIR}" && echo "mux_launch.sh" || { echo "Error: Failed to copy mux_launch.sh"; exit 1; }
cp -r app/* .build/"${APP_DIR}/" && echo "app/" || { echo "Error: Failed to copy app/"; exit 1; }
cp -r appdownloader.png .build/"${GLYPH_DIR}" && echo "appdownloader.png" || { echo "Error: Failed to copy appdownloader.png"; exit 1; }

echo "Creating archive"
cd .build
zip -9qr "../.dist/${ARCHIVE_NAME}_${VERSION}.muxzip" . && echo "Archive created" || { echo "Error: Failed to create archive"; exit 1; }
cd ..

echo "Cleaning up"
rm -rf .build/ || { echo "Error: Failed to clean up .build directory"; exit 1; }

#!/usr/bin/env bash

# Exit on error
set -e

# Load configuration
if [ ! -f /etc/backup-info ]; then
    echo "Error: /etc/backup-info not found"
    echo "Please copy scripts/backup/backup-info.example to /etc/backup-info and configure it"
    exit 1
fi

source /etc/backup-info
TIMESTAMP=$(date '+%Y%m%d_%H%M%S')
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Check for rclone installation and gdrive remote
if ! command -v rclone &> /dev/null; then
    echo "Error: rclone is not installed. Please install rclone and configure Google Drive remote."
    exit 1
fi

if ! rclone listremotes | grep -q "^gdrive:"; then
    echo "Error: Google Drive remote 'gdrive:' not found in rclone config"
    echo "Please run 'rclone config' to set up Google Drive remote"
    exit 1
fi

# Create temporary directory
TEMP_DIR=$(mktemp -d)
trap 'rm -rf "$TEMP_DIR"' EXIT

# Create tar archive
echo "Creating archive..."
cd "$(dirname "${SOURCE_PATH}")"
tar -czf "${TEMP_DIR}/backup_${TIMESTAMP}.tar.gz" "$(basename "${SOURCE_PATH}")"

# Encrypt the archive
echo "Encrypting archive..."
gpg --symmetric --batch --yes --passphrase-file "${SCRIPT_DIR}/passphrase" \
    --cipher-algo AES256 \
    --output "${TEMP_DIR}/backup_${TIMESTAMP}.tar.gz.gpg" \
    "${TEMP_DIR}/backup_${TIMESTAMP}.tar.gz"

# Upload to Google Drive
echo "Uploading to Google Drive..."
rclone copy "${TEMP_DIR}/backup_${TIMESTAMP}.tar.gz.gpg" "gdrive:${GDRIVE_FOLDER}/"

# Clean up old backups (keep last 10)
echo "Cleaning up old backups..."
BACKUP_COUNT=$(rclone ls "gdrive:${GDRIVE_FOLDER}" | wc -l)
if [ "$BACKUP_COUNT" -gt 10 ]; then
    rclone ls "gdrive:${GDRIVE_FOLDER}" | sort | head -n -10 | while read -r _ name; do
        rclone delete "gdrive:${GDRIVE_FOLDER}/$name"
    done
fi

echo "Backup completed successfully"

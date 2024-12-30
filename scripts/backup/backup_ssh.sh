#!/usr/bin/env bash

# Exit on error
set -e

# Load configuration
if [ ! -f /etc/backup-info ]; then
    echo "Error: /etc/backup-info not found"
    echo "Please copy scripts/backup/backup-info.example to /etc/backup-info and configure it"
    exit 1
fi

if [ ! -f /etc/credentials-backup ]; then
    echo "Error: /etc/credentials-backup not found"
    echo "Please run setup.sh to configure backup encryption"
    exit 1
fi

source /etc/backup-info
TIMESTAMP=$(date '+%Y%m%d_%H%M%S')
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Create temporary directory
TEMP_DIR=$(mktemp -d)
trap 'rm -rf "$TEMP_DIR"' EXIT

# Create tar archive
echo "Creating archive..."
cd "$(dirname "${SOURCE_PATH}")"
tar -czf "${TEMP_DIR}/backup_${TIMESTAMP}.tar.gz" "$(basename "${SOURCE_PATH}")"

# Encrypt the archive
echo "Encrypting archive..."
gpg --symmetric --batch --yes --passphrase-file /etc/credentials-backup \
    --cipher-algo AES256 \
    --output "${TEMP_DIR}/backup_${TIMESTAMP}.tar.gz.gpg" \
    "${TEMP_DIR}/backup_${TIMESTAMP}.tar.gz"

# Send to remote
echo "Sending to remote host..."
rsync -av --no-perms \
    "${TEMP_DIR}/backup_${TIMESTAMP}.tar.gz.gpg" \
    "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_PATH}/"

echo "Backup completed successfully"

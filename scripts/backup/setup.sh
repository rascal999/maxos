#!/usr/bin/env bash

# Exit on error
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Copy example config if /etc/backup-info doesn't exist
if [ ! -f /etc/backup-info ]; then
    echo "Creating /etc/backup-info from example..."
    if [ -w /etc ]; then
        cp "${SCRIPT_DIR}/backup-info.example" /etc/backup-info
    else
        echo "Need sudo to copy backup-info to /etc"
        sudo cp "${SCRIPT_DIR}/backup-info.example" /etc/backup-info
        sudo chown root:root /etc/backup-info
        sudo chmod 644 /etc/backup-info
    fi
    echo "Please edit /etc/backup-info to configure your backup settings"
fi

# Load configuration
source /etc/backup-info

# Verify source directory exists
if [ ! -d "${SOURCE_PATH}" ]; then
    echo "Error: Source directory ${SOURCE_PATH} does not exist"
    exit 1
fi

# Check for rclone installation
if ! command -v rclone &> /dev/null; then
    echo "Warning: rclone is not installed. It is required for Google Drive backups."
    echo "Please install rclone and run 'rclone config' to set up Google Drive remote"
else
    if ! rclone listremotes | grep -q "^gdrive:"; then
        echo "Note: Google Drive remote not configured in rclone"
        echo "To enable Google Drive backups, run 'rclone config' and set up 'gdrive' remote"
    fi
fi

# Create passphrase file with secure permissions
if [ ! -f "${SCRIPT_DIR}/passphrase" ]; then
    echo "Setting up backup encryption..."
    read -s -p "Enter passphrase for backup encryption: " passphrase
    echo
    read -s -p "Confirm passphrase: " passphrase2
    echo
    
    if [ "$passphrase" != "$passphrase2" ]; then
        echo "Error: Passphrases do not match"
        exit 1
    fi
    
    echo "$passphrase" > "${SCRIPT_DIR}/passphrase"
    chmod 600 "${SCRIPT_DIR}/passphrase"
    echo "Backup encryption configured successfully"
else
    echo "Backup encryption already configured"
fi

echo "Backup system setup complete"
echo
echo "To backup your data:"
echo "1. For SSH backup:   ./backup_ssh.sh"
echo "2. For GDrive backup: ./backup_gdrive.sh"

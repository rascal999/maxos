#!/usr/bin/env bash

# Exit on error
set -e

# Check for required files
if [ ! -f /etc/backup-info ]; then
    echo "Error: /etc/backup-info not found"
    echo "This file should be managed by NixOS configuration"
    exit 1
fi

if [ ! -f /etc/credentials-backup ]; then
    echo "Error: /etc/credentials-backup not found"
    echo "This file should be managed by NixOS configuration"
    exit 1
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

echo "Backup system setup complete"
echo
echo "To backup your data:"
echo "1. For SSH backup:   ./backup_ssh.sh"
echo "2. For GDrive backup: ./backup_gdrive.sh"

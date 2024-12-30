# Backup System

Simple and secure backup system that creates encrypted archives of directories and stores them either via SSH or Google Drive.

## Features

- Creates compressed tar archives of directories
- Encrypts backups with GPG (AES-256)
- Multiple backup destinations:
  - SSH/SFTP to remote server
  - Google Drive (requires rclone)
- Timestamped backups
- Automatic cleanup of old Google Drive backups (keeps last 10)

## Requirements

NixOS configuration must provide:

1. /etc/backup-info:
   - Contains backup configuration settings
   - See backup-info.example for template
   - Permissions should be 644 (root write, all read)

2. /etc/credentials-backup:
   - Contains the encryption passphrase
   - Permissions should be 600 (root read/write only)

## Setup

1. Configure NixOS:
   - Use backup-info.example as a template for /etc/backup-info
   - Set up /etc/credentials-backup with encryption passphrase

2. Run the setup script to verify configuration:
   ```bash
   ./setup.sh
   ```

3. For Google Drive backups:
   - Install rclone
   - Run `rclone config` to set up Google Drive remote

## Usage

For SSH backup:
```bash
./backup_ssh.sh
```

For Google Drive backup:
```bash
./backup_gdrive.sh
```

## Recovery

To recover files from a backup, you'll need:
1. The backup file (ends in .tar.gz.gpg)
2. The encryption passphrase from /etc/credentials-backup

Recovery steps:
1. Copy the backup file to your recovery location
2. Create a file containing your backup passphrase:
   ```bash
   sudo cp /etc/credentials-backup /tmp/backup-key
   sudo chmod 600 /tmp/backup-key
   ```
3. Decrypt the backup:
   ```bash
   gpg --decrypt --batch --yes --passphrase-file /tmp/backup-key \
       backup_TIMESTAMP.tar.gz.gpg > backup_TIMESTAMP.tar.gz
   ```
4. Extract the archive:
   ```bash
   tar xzf backup_TIMESTAMP.tar.gz
   ```
5. Clean up:
   ```bash
   rm /tmp/backup-key
   ```

IMPORTANT: Both configuration files (/etc/backup-info and /etc/credentials-backup) are managed by NixOS configuration. Make sure to keep your NixOS configuration backed up securely as it's required to decrypt backups!

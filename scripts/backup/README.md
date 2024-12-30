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

## Setup

1. Run the setup script:
   ```bash
   ./setup.sh
   ```
   This will:
   - Create /etc/backup-info from example
   - Set up encryption passphrase
   - Check for required tools

2. Edit /etc/backup-info to configure:
   - Source directory to backup
   - SSH server details
   - Google Drive folder name

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

To recover files from a backup:

1. Copy the backup file (ends in .tar.gz.gpg)
2. Decrypt the backup:
   ```bash
   gpg --decrypt backup_TIMESTAMP.tar.gz.gpg > backup_TIMESTAMP.tar.gz
   ```
3. Extract the archive:
   ```bash
   tar xzf backup_TIMESTAMP.tar.gz
   ```

Keep your encryption passphrase safe - it's required to decrypt backups!

#!/usr/bin/env python3
import os
import sys
import tempfile
import shutil
import subprocess
import argparse
from datetime import datetime
import configparser
from pathlib import Path

def check_requirements():
    """Check if required config files exist"""
    if not os.path.exists('/etc/backup-info'):
        print("Error: /etc/backup-info not found")
        print("This file should be managed by NixOS configuration")
        sys.exit(1)
    
    if not os.path.exists('/etc/credentials-backup'):
        print("Error: /etc/credentials-backup not found")
        print("This file should be managed by NixOS configuration")
        sys.exit(1)

def load_config():
    """Load configuration from backup-info file"""
    config = {}
    with open('/etc/backup-info', 'r') as f:
        for line in f:
            line = line.strip()
            if line and not line.startswith('#') and '=' in line:
                key, value = line.split('=', 1)
                config[key.strip()] = value.strip().strip('"')
    return config

def create_archive(temp_dir, source_path):
    """Create tar archive of source directory"""
    print("Creating archive...")
    timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
    archive_name = f"backup_{timestamp}.tar.gz"
    archive_path = os.path.join(temp_dir, archive_name)
    
    source_dir = os.path.dirname(source_path)
    source_base = os.path.basename(source_path)
    
    subprocess.run([
        'tar', '-czf', archive_path, '-C', source_dir, source_base
    ], check=True)
    
    return archive_path, timestamp

def encrypt_archive(archive_path):
    """Encrypt archive using GPG"""
    print("Encrypting archive...")
    encrypted_path = f"{archive_path}.gpg"
    
    subprocess.run([
        'gpg', '--symmetric', '--batch', '--yes',
        '--passphrase-file', '/etc/credentials-backup',
        '--cipher-algo', 'AES256',
        '--output', encrypted_path,
        archive_path
    ], check=True)
    
    return encrypted_path

def backup_to_ssh(encrypted_path, config):
    """Send backup to SSH destination"""
    print("Sending to remote host...")
    remote_dest = f"{config['REMOTE_USER']}@{config['REMOTE_HOST']}:{config['REMOTE_PATH']}/"
    
    # Upload file
    subprocess.run([
        'rsync', '-av', '--no-perms',
        encrypted_path, remote_dest
    ], check=True)
    
    # Cleanup old backups
    print("Cleaning up old SSH backups...")
    cleanup_cmd = f"cd {config['REMOTE_PATH']} && ls -t backup_*.tar.gz.gpg | tail -n +11 | xargs -r rm --"
    subprocess.run([
        'ssh',
        f"{config['REMOTE_USER']}@{config['REMOTE_HOST']}",
        cleanup_cmd
    ], check=True)

def check_rclone():
    """Verify rclone is installed and configured"""
    if shutil.which('rclone') is None:
        print("Error: rclone is not installed. Please install rclone and configure Google Drive remote.")
        sys.exit(1)
    
    result = subprocess.run(['rclone', 'listremotes'], 
                          capture_output=True, text=True, check=True)
    if 'gdrive:' not in result.stdout:
        print("Error: Google Drive remote 'gdrive:' not found in rclone config")
        print("Please run 'rclone config' to set up Google Drive remote")
        sys.exit(1)

def backup_to_gdrive(encrypted_path, config):
    """Send backup to Google Drive"""
    print("Uploading to Google Drive...")
    gdrive_path = f"gdrive:{config['GDRIVE_FOLDER']}/"
    
    # Upload file
    subprocess.run([
        'rclone', 'copy', encrypted_path, gdrive_path
    ], check=True)
    
    # Cleanup old backups
    print("Cleaning up old GDrive backups...")
    result = subprocess.run([
        'rclone', 'ls', gdrive_path
    ], capture_output=True, text=True, check=True)
    
    files = result.stdout.splitlines()
    if len(files) > 10:
        files.sort()
        for file_line in files[:-10]:
            filename = file_line.split()[-1]
            subprocess.run([
                'rclone', 'delete', f"{gdrive_path}{filename}"
            ], check=True)

def main():
    parser = argparse.ArgumentParser(description='Backup files to SSH and/or Google Drive')
    parser.add_argument('--ssh', action='store_true', help='Backup to SSH destination')
    parser.add_argument('--gdrive', action='store_true', help='Backup to Google Drive')
    
    args = parser.parse_args()
    
    if not (args.ssh or args.gdrive):
        parser.error("At least one of --ssh or --gdrive must be specified")
    
    # Check requirements and load config
    check_requirements()
    config = load_config()
    
    if not config.get('SOURCE_PATH'):
        print("Error: SOURCE_PATH not configured in /etc/backup-info")
        sys.exit(1)
    
    # Verify destination-specific requirements
    if args.ssh:
        required = ['REMOTE_USER', 'REMOTE_HOST', 'REMOTE_PATH']
        missing = [key for key in required if not config.get(key)]
        if missing:
            print(f"Error: Missing SSH configuration in /etc/backup-info: {', '.join(missing)}")
            sys.exit(1)
    
    if args.gdrive:
        check_rclone()
        gdrive_folder = config.get('GDRIVE_FOLDER')
        if not gdrive_folder:
            print("Error: GDRIVE_FOLDER not configured in /etc/backup-info")
            print("It must be set to 'backups' to match the Google Drive backup folder")
            sys.exit(1)
        if gdrive_folder != 'backups':
            print("Error: GDRIVE_FOLDER must be set to 'backups' in /etc/backup-info")
            print(f"Current value: {gdrive_folder}")
            sys.exit(1)
    
    # Create temporary directory
    with tempfile.TemporaryDirectory() as temp_dir:
        # Create and encrypt archive
        archive_path, timestamp = create_archive(temp_dir, config['SOURCE_PATH'])
        encrypted_path = encrypt_archive(archive_path)
        
        # Perform backups
        if args.ssh:
            backup_to_ssh(encrypted_path, config)
        
        if args.gdrive:
            backup_to_gdrive(encrypted_path, config)
    
    print("Backup completed successfully")

if __name__ == '__main__':
    main()

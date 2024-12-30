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
import traceback

def send_notification(title, message, urgency="normal"):
    """Send desktop notification using notify-send with consistent styling"""
    # Format title and message for plain text
    formatted_title = title.upper()  # Use uppercase instead of bold
    formatted_message = message.replace("\n", "  \n")  # Add extra space for better readability
    
    # Get SUDO_USER or default to 'user'
    user = os.environ.get('SUDO_USER', 'user')
    
    # Build notify-send command to run as user
    notify_cmd = [
        'sudo', '-u', user,
        'notify-send',
        '--app-name=Backup',
        f'--urgency={urgency}',
        '--hint=string:x-dunst-stack-tag:backup',  # Stack notifications from same backup run
        formatted_title,
        formatted_message
    ]
    
    # Debug print
    print("Executing notify-send command:", file=sys.stderr)
    print(f"Command: {' '.join(notify_cmd)}", file=sys.stderr)
    print(f"Title: {formatted_title}", file=sys.stderr)
    print(f"Message: {formatted_message}", file=sys.stderr)
    print(f"Urgency: {urgency}", file=sys.stderr)
    print(f"Running as user: {user}", file=sys.stderr)
    
    try:
        # Set DISPLAY and DBUS_SESSION_BUS_ADDRESS for the user
        env = os.environ.copy()
        env['DISPLAY'] = ':0'
        env['DBUS_SESSION_BUS_ADDRESS'] = f'unix:path=/run/user/{os.getuid()}/bus'
        subprocess.run(notify_cmd, env=env, check=True)
    except subprocess.CalledProcessError as e:
        print(f"notify-send failed with error: {e}", file=sys.stderr)
        # If notify-send fails, try notify-desktop as fallback
        notify_desktop_cmd = [
            'sudo', '-u', user,
            'notify-desktop',
            '--app-name=Backup',
            '--',  # Prevent treating message starting with - as an option
            formatted_title,
            formatted_message
        ]
        print("Trying fallback notify-desktop command:", file=sys.stderr)
        print(f"Command: {' '.join(notify_desktop_cmd)}", file=sys.stderr)
        try:
            subprocess.run(notify_desktop_cmd, check=True)
        except subprocess.CalledProcessError:
            # If both fail, just print to stderr
            print(f"{title}: {message}", file=sys.stderr)

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

    try:
        # Check requirements and load config first
        check_requirements()
        config = load_config()
        
        # Notify backup start
        destinations = []
        if args.ssh:
            destinations.append("SSH")
        if args.gdrive:
            destinations.append("Google Drive")
        dest_str = " and ".join(destinations)
        send_notification(
            "Backup Starting",
            f"Starting backup of {config.get('SOURCE_PATH', 'unknown source')}\nDestinations: {dest_str}",
            "low"  # Use low urgency (teal) for start notification
        )
        
        if not config.get('SOURCE_PATH'):
            raise ValueError("SOURCE_PATH not configured in /etc/backup-info")
        
        # Verify destination-specific requirements
        if args.ssh:
            required = ['REMOTE_USER', 'REMOTE_HOST', 'REMOTE_PATH']
            missing = [key for key in required if not config.get(key)]
            if missing:
                raise ValueError(f"Missing SSH configuration in /etc/backup-info: {', '.join(missing)}")
        
        if args.gdrive:
            check_rclone()
            gdrive_folder = config.get('GDRIVE_FOLDER')
            if not gdrive_folder:
                raise ValueError("GDRIVE_FOLDER not configured in /etc/backup-info\nIt must be set to 'backups' to match the Google Drive backup folder")
            if gdrive_folder != 'backups':
                raise ValueError(f"GDRIVE_FOLDER must be set to 'backups' in /etc/backup-info\nCurrent value: {gdrive_folder}")
        
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
        
        # Notify success
        send_notification(
            "Backup Complete",
            f"Successfully backed up {config.get('SOURCE_PATH', 'unknown source')}\nDestinations: {dest_str}",
            "normal"  # Use normal urgency for success (pink color)
        )
        print("Backup completed successfully")

    except Exception as e:
        # Get full error details
        error_msg = str(e)
        if not error_msg:
            error_msg = traceback.format_exc()
        
        # Notify failure
        send_notification(
            "Backup Failed",
            error_msg,
            "critical"
        )
        print(f"Error: {error_msg}", file=sys.stderr)
        sys.exit(1)

if __name__ == '__main__':
    main()

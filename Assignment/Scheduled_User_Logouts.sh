#!/bin/bash

LOGFILE="$HOME/Assignment/logout_logs/logout_$(date +%Y-%m-%d).txt"
BACKUP_DIR="$HOME/Assignment/logout_backups/$(date +%Y-%m-%d)"
mkdir -p "$(dirname "$LOGFILE")"
mkdir -p "$BACKUP_DIR"

echo "[$(date)] Starting scheduled logout..." >> "$LOGFILE"

# Loop through each non-root logged-in user
who | awk '{print $1}' | sort | uniq | while read user; do
    if [ "$user" != "root" ]; then
        USER_HOME=$(eval echo "~$user")

        # Backup important files (like open editors, etc.) if needed
        echo "[$(date)] Backing up files for $user..." >> "$LOGFILE"
        tar czf "$BACKUP_DIR/${user}_backup.tar.gz" "$USER_HOME/Documents" "$USER_HOME/Desktop" 2>> "$LOGFILE"

        # Find and terminate all processes for the user
        echo "[$(date)] Logging out user: $user" >> "$LOGFILE"
        pkill -KILL -u "$user" && echo "[$(date)] $user logged out." >> "$LOGFILE" || echo "[$(date)] Failed to log out $user" >> "$LOGFILE"
    fi
done

echo "[$(date)] Logout process completed." >> "$LOGFILE"

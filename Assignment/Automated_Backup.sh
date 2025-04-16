#!/bin/bash

STUDENT_RECORDS_DIR="$HOME/Student_Records"  # Use the home directory
BACKUP_DIR="$HOME/Student_Records_Backups"    # Define the backup directory
BACKUP_FILE="$BACKUP_DIR/student_records_backup_$(date +%Y-%m-%d).tar.gz"

# Create the backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Create the backup using tar
tar -czf "$BACKUP_FILE" "$STUDENT_RECORDS_DIR" 2>/dev/null

if [ $? -eq 0 ]; then
    echo "Backup successful: $BACKUP_FILE"
else
    echo "Backup failed!"
fi

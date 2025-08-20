#!/usr/bin/env bash
"./../"

# === CONFIGURATION ===
PROJECT_DIR="/home/kashan/Documents/Personal/devops_techzeen/devops_midterm_project/"  # <-- change this to your project directory
BACKUP_DIR="/backups/repo"
DAYS_TO_KEEP=7
SLACK_NOTIFY_SCRIPT="/home/kashan/Documents/Personal/devops_techzeen/devops_midterm_project/notifier/slack_notify.sh"   # <-- set this to the path of file-2

# === SCRIPT ===
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="$BACKUP_DIR/server_backup_$TIMESTAMP.zip"

# make sure backup directory exists
mkdir -p "$BACKUP_DIR"

# create zip backup, excluding node_modules, .env, and logs
cd "$PROJECT_DIR"
if zip -r "$BACKUP_FILE" . -x "node_modules/*" ".env" "logs/*"; then
  echo "Backup created at: $BACKUP_FILE"
  
  # send success message to Slack
  echo "Backup succeeded: $BACKUP_FILE" | bash "$SLACK_NOTIFY_SCRIPT"
else
  echo "Backup failed" >&2
  echo "Backup failed on host $(hostname)." | bash "$SLACK_NOTIFY_SCRIPT"
  exit 1
fi

# delete backups older than N days
find "$BACKUP_DIR" -type f -mtime +$DAYS_TO_KEEP -name "*.zip" -exec rm {} \;
echo "Old backups (>$DAYS_TO_KEEP days) cleaned up."

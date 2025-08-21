# DevOps Midterm Project

A robust monitoring and backup system for MERN stack applications, featuring automated Slack notifications and scheduled backups.

## 📋 Overview

This project implements a comprehensive monitoring and backup solution consisting of two main components:

- **Slack Notification System**: Real-time error alerts from your Node.js application
- **Automated Backup System**: Scheduled backups with retention policy and success/failure notifications

## 🛠️ Prerequisites

- Ubuntu 24.04
- Node.js v18.20.5+
- Slack workspace with webhook permissions
- Bash shell

## ⚙️ Configuration

### 1. Slack Webhook Setup

Create the configuration directory and file:

\`\`\`bash
sudo mkdir -p /etc/mern-alert
sudo nano /etc/mern-alert/config
\`\`\`

Add your Slack webhook URL:

\`\`\`bash
SLACK_WEBHOOK_URL="https://hooks.slack.com/services/your/webhook/url"
\`\`\`

### 2. Backup Script Configuration

Edit the `backup.sh` file and update these variables:

\`\`\`bash
PROJECT_DIR="/path/to/your/project"        # Update this path
BACKUP_DIR="/backups/repo"                 # Backup storage location
DAYS_TO_KEEP=7                            # Retention period in days
SLACK_NOTIFY_SCRIPT="/path/to/slack_notify.sh"  # Path to notifier script
\`\`\`

## 🚀 Installation & Usage

### Slack Notifier Setup

1. Make the script executable:
   \`\`\`bash
   chmod +x slack_notify.sh
   \`\`\`

2. Test the notification system:
   \`\`\`bash
   echo "Test message" | ./slack_notify.sh
   \`\`\`

### Backup System Setup

1. Make the backup script executable:
   \`\`\`bash
   chmod +x backup.sh
   \`\`\`

2. Run a manual backup test:
   \`\`\`bash
   ./backup.sh
   \`\`\`

### Node.js Integration

1. Install dependencies:
   \`\`\`bash
   npm install
   \`\`\`

2. Start the server:
   \`\`\`bash
   npm start
   \`\`\`

3. Trigger a test error by visiting:
   \`\`\`
   http://localhost:3000/boom
   \`\`\`

## 🔧 Automated Backups with Cron

Set up daily automated backups by adding to your crontab:

\`\`\`bash
crontab -e
\`\`\`

Add this line to run daily at 2 AM:

\`\`\`
0 2 * * * /path/to/your/backup.sh
\`\`\`

## 📦 Backup Restoration

To restore from a backup:

1. Navigate to your project directory:
   \`\`\`bash
   cd /path/to/your/project
   \`\`\`

2. Unzip the backup file:
   \`\`\`bash
   unzip /backups/repo/server_backup_YYYY-MM-DD_HH-MM-SS.zip
   \`\`\`

3. Reinstall dependencies:
   \`\`\`bash
   npm install
   \`\`\`

## 📱 Slack Notification Examples

You'll receive notifications for:

- Application errors with stack traces
- Backup successes with file locations
- Backup failures with hostname information

## 📁 Project Structure

\`\`\`
devops_midterm_project/
├── notifier/
│   └── slack_notify.sh     # Slack webhook handler
├── backup.sh               # Backup automation script
├── alert.js                # Node.js error handler
├── server.js               # Express server with error handling
├── package.json            # Project dependencies
└── README.md               # This file
\`\`\`

## 🐛 Troubleshooting

### Slack notifications not working:
- Verify webhook URL in `/etc/mern-alert/config`
- Check script permissions: `chmod +x slack_notify.sh`

### Backup failures:
- Verify directory paths in `backup.sh`
- Ensure sufficient disk space in backup location

### Node.js errors:
- Confirm Node.js version: `node -v`
- Install dependencies: `npm install`

## 🤝 Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## 📄 License

This project is licensed under the [ISC License](https://choosealicense.com/licenses/isc/).

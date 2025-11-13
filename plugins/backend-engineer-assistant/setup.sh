#!/bin/bash

# Backend Engineer Assistant Plugin - Environment Setup Script
# This script helps configure the required environment variables for the plugin

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "===================================="
echo "Backend Engineer Assistant Setup"
echo "===================================="
echo ""
echo "This script will help you configure environment variables for:"
echo "  - GitHub MCP"
echo "  - Jira MCP"
echo "  - Context7 (Laravel) MCP"
echo ""
echo "The variables will be added directly to your shell profile."
echo ""

# Function to prompt for input with default value
prompt_input() {
    local var_name=$1
    local prompt_text=$2
    local default_value=$3
    local current_value="${!var_name}"

    if [ -n "$current_value" ]; then
        echo "Current value for $var_name: $current_value"
    fi

    if [ -n "$default_value" ]; then
        read -p "$prompt_text [$default_value]: " input
        echo "${input:-$default_value}"
    else
        read -p "$prompt_text: " input
        echo "$input"
    fi
}

# Function to prompt for sensitive input (hidden)
prompt_secret() {
    local var_name=$1
    local prompt_text=$2
    local current_value="${!var_name}"

    if [ -n "$current_value" ]; then
        echo "Current value for $var_name: ********"
        read -p "Keep current value? (y/n): " keep
        if [[ $keep =~ ^[Yy]$ ]]; then
            echo "$current_value"
            return
        fi
    fi

    read -s -p "$prompt_text: " input
    echo ""
    echo "$input"
}

echo "===================================="
echo "GitHub Configuration"
echo "===================================="
echo "You need a GitHub Personal Access Token with 'repo' and 'read:org' scopes"
echo ""
echo "How to find it:"
echo "  1. Check 1Password for 'GitHub Personal Access Token' in Engineering notes"
echo "  2. Or create a new one at: https://github.com/settings/tokens"
echo "     - Click 'Generate new token (classic)'"
echo "     - Select scopes: 'repo' and 'read:org'"
echo "     - Generate and copy the token"
echo ""

BE_GITHUB_TOKEN=$(prompt_secret "BE_GITHUB_TOKEN" "GitHub Personal Access Token")

echo ""
echo "===================================="
echo "Jira Configuration"
echo "===================================="
echo "You need your Jira URL, email, and API token"
echo ""
echo "How to find it:"
echo "  1. Check 1Password for 'Jira API Credentials' in Engineering notes"
echo "  2. Or create a new API token at: https://id.atlassian.com/manage-profile/security/api-tokens"
echo "     - Click 'Create API token'"
echo "     - Give it a label (e.g., 'Claude Code')"
echo "     - Copy the token immediately (you won't see it again)"
echo ""

BE_JIRA_URL=$(prompt_input "BE_JIRA_URL" "Jira URL (e.g., https://your-domain.atlassian.net)" "https://musora.atlassian.net")
BE_JIRA_EMAIL=$(prompt_input "BE_JIRA_EMAIL" "Jira Email" "$USER@musora.com")
BE_JIRA_API_TOKEN=$(prompt_secret "BE_JIRA_API_TOKEN" "Jira API Token")

echo ""
echo "===================================="
echo "Laravel/Context7 Configuration"
echo "===================================="
echo "Specify the path to your primary Laravel project"
echo ""
echo "How to find it:"
echo "  1. This is the local path to your main Laravel codebase"
echo "  2. Example: /Users/yourname/projects/musora-api"
echo "  3. The Context7 MCP uses this to understand your Laravel project structure"
echo ""

BE_LARAVEL_PROJECT_PATH=$(prompt_input "BE_LARAVEL_PROJECT_PATH" "Laravel Project Path" "$HOME/projects/laravel")

# Detect shell and determine profile file
SHELL_NAME=$(basename "$SHELL")
case "$SHELL_NAME" in
    bash)
        PROFILE_FILE="$HOME/.bashrc"
        ;;
    zsh)
        PROFILE_FILE="$HOME/.zshrc"
        ;;
    fish)
        PROFILE_FILE="$HOME/.config/fish/config.fish"
        echo ""
        echo "Note: Fish shell uses different syntax. You'll need to manually adapt the commands."
        echo ""
        ;;
    *)
        PROFILE_FILE="$HOME/.profile"
        ;;
esac

echo ""
echo "===================================="
echo "Setup Complete!"
echo "===================================="
echo ""
echo "Detected shell: $SHELL_NAME"
echo "Profile file: $PROFILE_FILE"
echo ""
echo "The following environment variables will be added:"
echo ""
echo "export BE_GITHUB_TOKEN=\"***hidden***\""
echo "export BE_JIRA_URL=\"$BE_JIRA_URL\""
echo "export BE_JIRA_EMAIL=\"$BE_JIRA_EMAIL\""
echo "export BE_JIRA_API_TOKEN=\"***hidden***\""
echo "export BE_LARAVEL_PROJECT_PATH=\"$BE_LARAVEL_PROJECT_PATH\""
echo ""

read -p "Add these environment variables to $PROFILE_FILE? (y/n): " confirm

if [[ $confirm =~ ^[Yy]$ ]]; then
    # Check if already added and remove old section
    if grep -q "# Claude Code Backend Engineer Assistant" "$PROFILE_FILE" 2>/dev/null; then
        echo "Removing existing configuration..."
        # Create temp file without the old section
        sed '/# Claude Code Backend Engineer Assistant/,/# End Claude Code Backend Engineer Assistant/d' "$PROFILE_FILE" > "${PROFILE_FILE}.tmp"
        mv "${PROFILE_FILE}.tmp" "$PROFILE_FILE"
    fi

    # Add new configuration
    cat >> "$PROFILE_FILE" << EOF

# Claude Code Backend Engineer Assistant
# Generated on $(date)
export BE_GITHUB_TOKEN="$BE_GITHUB_TOKEN"
export BE_JIRA_URL="$BE_JIRA_URL"
export BE_JIRA_EMAIL="$BE_JIRA_EMAIL"
export BE_JIRA_API_TOKEN="$BE_JIRA_API_TOKEN"
export BE_LARAVEL_PROJECT_PATH="$BE_LARAVEL_PROJECT_PATH"
# End Claude Code Backend Engineer Assistant
EOF

    echo ""
    echo "✓ Environment variables added to $PROFILE_FILE"
    echo ""
    echo "To apply the changes:"
    echo "  1. Restart your terminal, or"
    echo "  2. Run: source $PROFILE_FILE"
    echo ""

    # Export to current session
    export BE_GITHUB_TOKEN="$BE_GITHUB_TOKEN"
    export BE_JIRA_URL="$BE_JIRA_URL"
    export BE_JIRA_EMAIL="$BE_JIRA_EMAIL"
    export BE_JIRA_API_TOKEN="$BE_JIRA_API_TOKEN"
    export BE_LARAVEL_PROJECT_PATH="$BE_LARAVEL_PROJECT_PATH"

    echo "✓ Variables are also set for this terminal session"
else
    echo ""
    echo "Environment variables NOT saved."
    echo ""
    echo "To add them manually, add these lines to your $PROFILE_FILE:"
    echo ""
    echo "export BE_GITHUB_TOKEN=\"$BE_GITHUB_TOKEN\""
    echo "export BE_JIRA_URL=\"$BE_JIRA_URL\""
    echo "export BE_JIRA_EMAIL=\"$BE_JIRA_EMAIL\""
    echo "export BE_JIRA_API_TOKEN=\"$BE_JIRA_API_TOKEN\""
    echo "export BE_LARAVEL_PROJECT_PATH=\"$BE_LARAVEL_PROJECT_PATH\""
fi

echo ""
echo "You can re-run this script anytime to update your configuration."
echo ""

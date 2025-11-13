# Quick Setup Guide

This guide will help you quickly set up the Musora Claude Code Plugin Marketplace.

## Prerequisites

- Claude Code CLI installed and configured
- Node.js and npm installed (for MCP servers)
- Access to GitHub, Jira, and Laravel projects

## Step 1: Clone or Access the Marketplace

If hosted on GitHub:
```bash
git clone https://github.com/musora/claude-code-plugin-marketplace.git
```

Or use the local path if already available.

## Step 2: Set Up Environment Variables

Copy the example environment file:
```bash
cp .env.example ~/.claude-code-marketplace.env
```

Edit the file with your credentials:
```bash
# Edit with your preferred editor
nano ~/.claude-code-marketplace.env
# or
vim ~/.claude-code-marketplace.env
```

Add the variables to your shell profile (`~/.bashrc`, `~/.zshrc`, etc.):
```bash
# Load Claude Code marketplace environment variables
if [ -f ~/.claude-code-marketplace.env ]; then
    export $(cat ~/.claude-code-marketplace.env | grep -v '^#' | xargs)
fi
```

Reload your shell:
```bash
source ~/.bashrc  # or source ~/.zshrc
```

## Step 3: Add Marketplace to Claude Code

```bash
/plugin marketplace add /path/to/claude-code-plugin-marketplace
```

Or if on GitHub:
```bash
/plugin marketplace add railroadmedia/claude-code-plugin-marketplace
```

## Step 4: Install the Backend Engineer Assistant Plugin

```bash
/plugin install backend-engineer-assistant@musora-engineering
```

Or use the interactive menu:
```bash
/plugin
```

Select "Browse Plugins" and install from the list.

## Step 5: Verify Installation

Check installed plugins:
```bash
/plugin
```

Try a command:
```bash
/api-design
```

## Getting API Tokens

### GitHub Personal Access Token

1. Go to https://github.com/settings/tokens
2. Click "Generate new token (classic)"
3. Select scopes:
   - `repo` (Full control of private repositories)
   - `read:org` (Read org and team membership)
4. Generate and copy the token
5. Set as `GITHUB_TOKEN` environment variable

### Jira API Token

1. Go to https://id.atlassian.com/manage-profile/security/api-tokens
2. Click "Create API token"
3. Give it a label (e.g., "Claude Code")
4. Copy the token
5. Set the following environment variables:
   - `JIRA_URL` - Your Jira instance URL (e.g., https://musora.atlassian.net)
   - `JIRA_EMAIL` - Your Jira account email
   - `JIRA_API_TOKEN` - The token you just created

### Laravel Project Path

Set the path to your Laravel project:
```bash
LARAVEL_PROJECT_PATH=/path/to/your/laravel/project
```

This allows the Context7 MCP to understand your Laravel codebase.

## Team Setup (Optional)

To automatically install this marketplace for your entire team:

1. Create or edit `.claude/settings.json` in your project:
```json
{
  "extraKnownMarketplaces": [
    {
      "source": "railroadmedia/claude-code-plugin-marketplace"
    }
  ],
  "plugins": [
    "backend-engineer-assistant@musora-engineering"
  ]
}
```

2. Commit this file to your repository

3. When team members trust the folder, the marketplace and plugin will be automatically installed

## Troubleshooting

### Plugin Not Found
- Verify the marketplace was added: `/plugin marketplace list`
- Try updating: `/plugin marketplace update musora-engineering`

### MCP Servers Not Working
- Check environment variables are set: `echo $GITHUB_TOKEN`
- Verify npm can access MCP packages: `npm info @modelcontextprotocol/server-github`
- Check Claude Code logs for connection errors

### Commands Not Available
- Verify plugin is installed and enabled: `/plugin`
- Try reinstalling: `/plugin uninstall backend-engineer-assistant` then `/plugin install backend-engineer-assistant@musora-engineering`

### Permission Errors
- Ensure tokens have correct scopes
- Verify Jira URL is correct (include https://)
- Check that your account has access to the required resources

## Testing Your Setup

Try each component:

1. **GitHub MCP**: `/review-pr` - Ask to review a PR
2. **Jira MCP**: `/create-jira-ticket` - Ask to create a ticket
3. **Laravel MCP**: `/laravel-endpoint` - Ask to generate an endpoint
4. **General**: `/api-design` - Ask to design an API

## Next Steps

- Read the full README.md for detailed documentation
- Check CONTRIBUTING.md to learn how to add new plugins
- Explore each slash command to see what's available
- Customize environment variables for your projects

## Support

For help or questions:
- Check the README.md troubleshooting section
- Review Claude Code documentation: https://code.claude.com/docs
- Contact Musora Engineering team

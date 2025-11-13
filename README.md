# Claude Code Plugin Marketplace

Musora's internal marketplace for distributing Claude Code plugins and MCP servers across engineering teams.

## Overview

This marketplace provides a centralized way to discover, install, and manage Claude Code plugins that enhance development workflows with integrations for GitHub, Jira, Laravel, and more.

## Quick Start

### Adding the Marketplace

Add this marketplace to your Claude Code installation:

```bash
/plugin marketplace add /path/to/claude-code-plugin-marketplace
```

Or if hosted on GitHub:

```bash
/plugin marketplace add railroadmedia/claude-code-plugin-marketplace
```

### Installing Plugins

Install the backend engineer assistant plugin:

```bash
/plugin install backend-engineer-assistant@musora-engineering
```

Or use the interactive menu:

```bash
/plugin
```

Then select "Browse Plugins" and choose from available plugins.

## Available Plugins

### Backend Engineer Assistant

A comprehensive plugin for backend engineers working with Laravel, GitHub, and Jira.

**Features:**
- GitHub MCP integration for PR reviews, issue management, and repository operations
- Jira MCP integration for ticket creation and project management
- Context7 (Laravel) MCP for Laravel-specific code understanding and generation
- Custom slash commands for common backend engineering tasks

**Slash Commands:**
- `/review-pr` - Review GitHub pull requests with detailed feedback
- `/create-jira-ticket` - Create well-formatted Jira tickets
- `/laravel-endpoint` - Generate complete Laravel API endpoints
- `/debug-laravel` - Debug Laravel issues with context awareness
- `/api-design` - Design RESTful APIs following best practices

## Environment Setup

### Quick Setup (Recommended)

Each plugin includes a setup script to help configure environment variables:

```bash
cd plugins/backend-engineer-assistant
./setup.sh
```

The setup script will:
- Interactively prompt for each required credential
- Show where to find credentials in 1Password
- Add environment variables directly to your shell profile
- Export variables to your current terminal session

### Manual Setup

Before using the plugins, configure the required environment variables:

#### GitHub MCP
```bash
export BE_GITHUB_TOKEN="your_github_personal_access_token"
```

#### Jira MCP
```bash
export BE_JIRA_URL="https://your-domain.atlassian.net"
export BE_JIRA_EMAIL="your-email@musora.com"
export BE_JIRA_API_TOKEN="your_jira_api_token"
```

#### Context7 (Laravel) MCP
```bash
export BE_LARAVEL_PROJECT_PATH="/path/to/your/laravel/project"
```

Check 1Password Engineering notes for team credentials.

Note: All variables use the `BE_` prefix to avoid conflicts with other environment variables.

## Team Configuration

To automatically install this marketplace for your team, add to your project's `.claude/settings.json`:

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

## Creating New Plugins

1. Create a new directory under `plugins/`
2. Add `.claude-plugin/plugin.json` with metadata
3. Add optional components:
   - `commands/` - Slash commands (markdown files)
   - `.mcp.json` - MCP server configurations
   - `agents/` - Custom agents
   - `skills/` - Agent capabilities
   - `hooks/` - Event handlers

4. Register the plugin in `.claude-plugin/marketplace.json`

Example plugin structure:
```
plugins/your-plugin/
├── .claude-plugin/
│   └── plugin.json
├── commands/
│   └── your-command.md
└── .mcp.json
```

## Getting API Tokens

### GitHub Token
1. Go to GitHub Settings > Developer settings > Personal access tokens
2. Generate new token with `repo` and `read:org` scopes
3. Set as `BE_GITHUB_TOKEN` environment variable

### Jira Token
1. Go to https://id.atlassian.com/manage-profile/security/api-tokens
2. Create API token
3. Set `BE_JIRA_URL`, `BE_JIRA_EMAIL`, and `BE_JIRA_API_TOKEN` environment variables

## Support

For issues or questions, contact the Musora Engineering team or create an issue at https://github.com/railroadmedia/claude-code-plugin-marketplace/issues 

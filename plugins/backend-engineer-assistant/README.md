# Backend Engineer Assistant Plugin

A comprehensive Claude Code plugin designed for backend engineers working with Laravel, GitHub, and Jira.

## Features

### MCP Server Integrations

This plugin includes three powerful MCP (Model Context Protocol) servers:

1. **GitHub MCP** - Direct integration with GitHub for:
   - Pull request reviews and analysis
   - Issue management
   - Repository operations
   - Code search across repositories

2. **Jira MCP** - Jira integration for:
   - Ticket creation and management
   - Sprint planning
   - Issue tracking
   - Project management

3. **Context7 (Laravel) MCP** - Laravel-specific tooling:
   - Laravel codebase understanding
   - Artisan command suggestions
   - Laravel best practices
   - Framework-aware code generation

### Custom Slash Commands

#### `/example-command`
Example command for copying and setting up new commands.

## Installation

Install this plugin from the Musora marketplace:

```bash
/plugin install backend-engineer-assistant@musora-engineering
```

## Configuration

### Quick Setup (Recommended)

Run the interactive setup script:

```bash
cd plugins/backend-engineer-assistant
./setup.sh
```

The script will:
- Prompt you for each required environment variable
- Provide instructions on where to find credentials in 1Password
- Add the environment variables directly to your shell profile (~/.bashrc, ~/.zshrc, etc.)
- Export the variables to your current terminal session

### Manual Setup

Alternatively, set up the following environment variables manually:

```bash
# GitHub
export BE_GITHUB_TOKEN="your_github_personal_access_token"

# Jira
export BE_JIRA_URL="https://your-domain.atlassian.net"
export BE_JIRA_EMAIL="your-email@musora.com"
export BE_JIRA_API_TOKEN="your_jira_api_token"

# Laravel/Context7
export BE_LARAVEL_PROJECT_PATH="/path/to/your/laravel/project"
```

Check 1Password Engineering notes for existing credentials.

Note: All variables are prefixed with `BE_` to avoid conflicts with other environment variables on your machine.

## Usage Examples

### Review a Pull Request
```
/review-pr
```
Claude will use the GitHub MCP to fetch the PR details and provide a comprehensive review.

### Create a Jira Ticket
```
/create-jira-ticket
```
Describe your feature or bug, and Claude will help format a professional Jira ticket.

### Generate a Laravel API Endpoint
```
/laravel-endpoint
```
Specify your requirements, and Claude will generate a complete, tested API endpoint following Laravel best practices.

### Debug a Laravel Issue
```
/debug-laravel
```
Describe the issue, and Claude will use Context7 to understand your Laravel codebase and help identify the problem.

### Design an API
```
/api-design
```
Describe your requirements, and Claude will help design a RESTful API with proper structure and best practices.

## Requirements

- Claude Code CLI
- Node.js and npm (for MCP servers)
- Access to GitHub, Jira, and Laravel projects as needed

## Troubleshooting

### MCP Server Not Connecting
- Verify environment variables are set correctly
- Check that npm can access the MCP server packages
- Ensure tokens have the required permissions

### Commands Not Working
- Verify the plugin is enabled: `/plugin`
- Reinstall the plugin if needed
- Check Claude Code logs for errors

## Contributing

To add new commands or features to this plugin:

1. Add new command files to the `commands/` directory
2. Update the plugin version in `.claude-plugin/plugin.json`
3. Test the changes locally
4. Submit for review to the Musora engineering team

## Support

For issues or questions about this plugin, contact the Musora Engineering team.

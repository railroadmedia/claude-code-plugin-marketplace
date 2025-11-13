# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This is an internal Claude Code plugin marketplace for Musora Engineering that distributes plugins and MCP server configurations. It follows the official Claude Code marketplace specification, using JSON-based catalogs for plugin discovery and distribution.

## Architecture

### Marketplace Structure

The marketplace is a **JSON catalog system** (not a Node.js application):

- **`.claude-plugin/marketplace.json`** - Root marketplace catalog that lists all available plugins. This is the entry point that users add to Claude Code via `/plugin marketplace add`
- **`plugins/[plugin-name]/`** - Individual plugin directories, each self-contained
- **No build system required** - The marketplace is consumed directly by Claude Code CLI

### Plugin Architecture

Each plugin in `plugins/` follows this structure:

1. **`.claude-plugin/plugin.json`** - Required metadata (name, version, author, description)
2. **`commands/*.md`** - Optional slash commands (filename becomes command name)
3. **`.mcp.json`** - Optional MCP server configuration with environment variable interpolation using `${VAR_NAME}` syntax
4. **`agents/`, `skills/`, `hooks/`** - Optional additional Claude Code features

### Key Design Principle

**Command markdown files are prompts to Claude**, not executable scripts. The markdown content tells Claude what to do when the command is invoked. For example, `/review-pr` contains instructions for Claude to analyze a PR and provide feedback using the GitHub MCP.

## Working with This Repository

### Testing Plugin Changes Locally

After modifying a plugin, users must reinstall it to see changes:

```bash
/plugin uninstall plugin-name
/plugin install plugin-name@musora-engineering
```

### Adding a New Plugin

1. Create directory: `plugins/your-plugin-name/`
2. Add required file: `plugins/your-plugin-name/.claude-plugin/plugin.json`
3. Add optional components (commands, MCP config, etc.)
4. Register plugin in `.claude-plugin/marketplace.json` by adding an entry to the `plugins` array
5. Update root `.env.example` if new environment variables are needed

### Naming Conventions

- **Plugins**: kebab-case (e.g., `backend-engineer-assistant`)
- **Commands**: kebab-case, verb-first when possible (e.g., `review-pr`, `create-jira-ticket`)
- **Environment variables**: SCREAMING_SNAKE_CASE with service prefix (e.g., `GITHUB_TOKEN`, `JIRA_API_TOKEN`)

### Version Management

Follow semver in **both** locations when updating plugins:
1. `plugins/[plugin-name]/.claude-plugin/plugin.json`
2. `.claude-plugin/marketplace.json` (in the plugins array entry)

### MCP Server Configuration Pattern

MCP servers in `.mcp.json` use this structure:

```json
{
  "mcpServers": {
    "server-name": {
      "command": "npx",
      "args": ["-y", "@package/name"],
      "env": {
        "API_KEY": "${ENV_VAR_NAME}"
      }
    }
  }
}
```

The `${VAR_NAME}` syntax tells Claude Code to interpolate environment variables at runtime.

### Standard Plugin Categories

Use these categories in plugin.json:
- `development` - General dev tools
- `testing` - Testing/QA
- `deployment` - CI/CD
- `documentation` - Doc generation
- `productivity` - Workflow tools
- `analysis` - Code analysis

## Current Plugins

### backend-engineer-assistant

Integrates three MCP servers (GitHub, Jira, Context7/Laravel) with five custom commands. The MCP servers provide tools that Claude can use, while the commands provide pre-written prompts for common tasks.

**Required environment variables (all prefixed with `BE_` to avoid conflicts):**
- `BE_GITHUB_TOKEN` - GitHub PAT with `repo` and `read:org` scopes
- `BE_JIRA_URL`, `BE_JIRA_EMAIL`, `BE_JIRA_API_TOKEN` - Jira credentials
- `BE_LARAVEL_PROJECT_PATH` - Path to Laravel project for Context7 MCP

## Important Notes

- This repository contains **configuration files only**, not executable code
- Users need Node.js/npm for MCP servers to run (via `npx`)
- Claude Code handles all plugin installation, loading, and command execution
- Slash commands are discovered automatically from markdown filenames in `commands/`
- Never commit sensitive tokens or credentials - always use environment variable interpolation

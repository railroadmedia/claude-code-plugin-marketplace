# Contributing to the Musora Claude Code Marketplace

Thank you for contributing to our internal plugin marketplace! This guide will help you create and add new plugins.

## Creating a New Plugin

### 1. Plugin Structure

Create a new directory under `plugins/` with the following structure:

```
plugins/your-plugin-name/
├── .claude-plugin/
│   └── plugin.json          # Required: Plugin metadata
├── commands/                 # Optional: Slash commands
│   └── command-name.md
├── .mcp.json                # Optional: MCP server configuration
├── agents/                   # Optional: Custom agents
├── skills/                   # Optional: Agent skills
├── hooks/                    # Optional: Event hooks
│   └── hooks.json
└── README.md                # Recommended: Plugin documentation
```

### 2. Plugin Metadata (Required)

Create `.claude-plugin/plugin.json`:

```json
{
  "name": "your-plugin-name",
  "description": "Brief description of what your plugin does",
  "version": "1.0.0",
  "author": "Your Name or Team",
  "keywords": ["relevant", "keywords"],
  "category": "development"
}
```

### 3. Adding Slash Commands

Create markdown files in the `commands/` directory. Each file becomes a slash command:

**File:** `commands/example-command.md`
```markdown
# Command Title

Brief description of what this command does.

Detailed instructions for Claude on how to execute this command.
Include any specific requirements, steps, or output format.
```

The command will be available as `/example-command`.

### 4. Configuring MCP Servers

If your plugin needs MCP servers, create `.mcp.json`:

```json
{
  "mcpServers": {
    "server-name": {
      "command": "npx",
      "args": ["-y", "@org/mcp-server-package"],
      "env": {
        "API_KEY": "${API_KEY_ENV_VAR}"
      }
    }
  }
}
```

Use `${VAR_NAME}` for environment variables that users need to configure.

### 5. Register in Marketplace

Add your plugin to `.claude-plugin/marketplace.json`:

```json
{
  "name": "your-plugin-name",
  "source": "./plugins/your-plugin-name",
  "description": "Brief description",
  "version": "1.0.0",
  "author": "Your Name",
  "category": "development",
  "keywords": ["relevant", "keywords"]
}
```

### 6. Documentation

Create a `README.md` in your plugin directory with:
- Overview of features
- Installation instructions
- Configuration requirements
- Usage examples
- Troubleshooting tips

### 7. Environment Variables

If your plugin requires environment variables:
1. Document them in your plugin's README
2. Add examples to the root `.env.example`
3. Use clear naming conventions (e.g., `SERVICE_NAME_API_KEY`)

## Plugin Categories

Use one of these standard categories:
- `development` - General development tools
- `testing` - Testing and QA tools
- `deployment` - CI/CD and deployment tools
- `documentation` - Documentation generation
- `productivity` - Workflow optimization
- `analysis` - Code analysis and metrics

## Naming Conventions

### Plugin Names
- Use kebab-case: `backend-engineer-assistant`
- Be descriptive but concise
- Avoid generic names

### Command Names
- Use kebab-case: `review-pr`, `create-ticket`
- Start with a verb when possible
- Keep under 20 characters

### Environment Variables
- Use SCREAMING_SNAKE_CASE
- Always prefix with `BE_` to avoid conflicts: `BE_JIRA_API_TOKEN`
- Include service name after prefix: `BE_GITHUB_TOKEN` not `BE_TOKEN`

## Testing Your Plugin

### Local Testing

1. Add the marketplace locally:
```bash
/plugin marketplace add /path/to/claude-code-plugin-marketplace
```

2. Install your plugin:
```bash
/plugin install your-plugin-name@musora-engineering
```

3. Test all commands and features

4. Make changes and reinstall:
```bash
/plugin uninstall your-plugin-name
/plugin install your-plugin-name@musora-engineering
```

### Checklist

Before submitting your plugin:

- [ ] Plugin metadata is complete and accurate
- [ ] All commands work as expected
- [ ] MCP servers connect successfully
- [ ] Environment variables are documented
- [ ] README includes usage examples
- [ ] No sensitive data in configuration files
- [ ] Version number follows semver
- [ ] Plugin is registered in marketplace.json

## Common Patterns

### MCP Server Integration

Most MCP servers follow this pattern:

```json
{
  "mcpServers": {
    "service-name": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-name"],
      "env": {
        "API_KEY": "${SERVICE_API_KEY}"
      }
    }
  }
}
```

### Command Templates

**Analysis Command:**
```markdown
# Analyze [Something]

Analyze [thing] and provide insights on [aspects].

Please provide:
1. Overview of [thing]
2. Key findings
3. Recommendations
4. Action items
```

**Generation Command:**
```markdown
# Generate [Something]

Generate [thing] following [standards/practices].

Please create:
1. [Component 1]
2. [Component 2]
3. [Component 3]
```

## Finding MCP Servers

Search for MCP servers:
- Official list: https://github.com/modelcontextprotocol/servers
- npm registry: Search for `@modelcontextprotocol/server-*`
- Community servers: Various GitHub repositories

## Versioning

Follow semantic versioning (semver):
- `1.0.0` - Initial release
- `1.0.1` - Bug fixes
- `1.1.0` - New features (backward compatible)
- `2.0.0` - Breaking changes

Increment version in both:
- `.claude-plugin/plugin.json`
- `.claude-plugin/marketplace.json`

## Getting Help

- Check existing plugins for examples
- Review Claude Code documentation
- Ask the Musora Engineering team
- Test thoroughly before sharing

## Example: Minimal Plugin

Here's a minimal working plugin:

**Directory structure:**
```
plugins/hello-world/
├── .claude-plugin/
│   └── plugin.json
└── commands/
    └── hello.md
```

**plugin.json:**
```json
{
  "name": "hello-world",
  "description": "A simple example plugin",
  "version": "1.0.0",
  "author": "Musora Engineering"
}
```

**commands/hello.md:**
```markdown
# Say Hello

Say hello to the user in a friendly way!
```

**In marketplace.json:**
```json
{
  "name": "hello-world",
  "source": "./plugins/hello-world",
  "description": "A simple example plugin",
  "version": "1.0.0"
}
```

That's it! Users can now run `/hello` after installing the plugin.

## Questions?

Contact the Musora Engineering team or refer to the official Claude Code documentation at https://code.claude.com/docs

# Cipher MCP Integration with Claude Code

## Overview
This document provides context for Claude Code about the Cipher MCP server integration. Cipher is a memory-enabled AI assistant that runs as an MCP (Model Context Protocol) server.

## Current Status (Updated: 2025-08-04)
- **Cipher Package**: `@byterover/cipher` v0.2.0 installed locally
- **Ollama**: Running with llama3.2 and mxbai-embed-large models
- **MCP Settings**: Configured correctly in `~/.claude/mcp-settings.json`
- **Claude Code Version**: 1.0.67 (Claude Code)
- **Issue**: MCP servers not loading in Claude Code despite correct configuration and multiple restarts

## Current Setup

### MCP Configuration
- **Location**: `~/.claude/mcp-settings.json`
- **Server Name**: `cipher`
- **Config File**: `/Users/batibat/Documents/dbt-mcp/cipher-mcp-only.yml`
- **Working Directory**: `/Users/batibat/Documents/dbt-mcp`
- **Package**: `@byterover/cipher` (not @modelcontextprotocol/server-cipher)

### Cipher Configuration
```yaml
# cipher-mcp-only.yml
llm:
  provider: ollama
  model: llama3.2
  maxIterations: 50

embedding:
  type: ollama
  model: mxbai-embed-large
  baseUrl: http://localhost:11434

systemPrompt:
  enabled: true
  content: |
    You are an expert coding assistant with persistent memory capabilities.
    You help users with software engineering tasks and remember important context across sessions.
```

### Available Tools
When Cipher MCP is running, you have access to:
- **ask_cipher**: Send questions to Cipher and get responses with memory context

## How to Use

1. **Check MCP Status**: Run `/mcp` in Claude Code to see if cipher is listed
2. **Use Cipher**: When you need to access Cipher's memory or capabilities, use the `ask_cipher` tool
3. **Example Usage**:
   ```
   User: "Ask cipher about the project structure we discussed yesterday"
   Claude: [Uses ask_cipher tool to query Cipher's memory]
   ```

## Troubleshooting

### If Cipher is not available:
1. Check if Ollama is running: `ollama list`
2. Verify the config file exists: `/Users/batibat/Documents/dbt-mcp/cipher-mcp-only.yml`
3. Check MCP settings: `cat ~/.claude/mcp-settings.json`
4. **IMPORTANT**: Restart Claude Code completely (close and reopen the application)
5. Verify cipher package is installed: `ls node_modules/@byterover/cipher`
6. Test cipher directly: `./test-cipher-mcp.sh`

### Common Issues:
- **JSON parsing error**: Usually means Cipher is taking too long to initialize
- **Cipher not listed in /mcp**: Claude Code MUST be restarted after MCP configuration
- **Connection refused**: Ollama may not be running on port 11434
- **Package not found**: Install with `npm install` in the project directory
- **Wrong package name**: Use `@byterover/cipher`, not `@modelcontextprotocol/server-cipher`
- **MCP servers not loading despite restarts**: This appears to be a persistent issue with Claude Code v1.0.67

### Alternative Configuration Attempts (All Failed):
1. **Standard npx configuration**: Uses npx to launch cipher
2. **Full path configuration**: Uses absolute paths to node and cipher binary
3. **Test echo server**: Simple echo command to test MCP loading
4. **Environment variables**: OLLAMA_BASE_URL set to http://localhost:11434/v1

### Verified Working:
- Cipher server starts correctly when run manually: `env OLLAMA_BASE_URL=http://localhost:11434/v1 npx cipher --mode mcp -a cipher-mcp-only.yml`
- MCP settings file exists and has correct permissions: `~/.claude/mcp-settings.json`
- Node/npx paths are valid: `/Users/batibat/.nvm/versions/node/v20.15.0/bin/`

## Key Information for Claude Code

When starting a new session:
1. Cipher maintains persistent memory across sessions
2. You can ask Cipher about previous conversations and context
3. Cipher is specialized for coding assistance with memory capabilities
4. The dbt-mcp project also includes Lightdash integration tools (separate from Cipher)

## Project Context

This is part of the dbt-mcp project which includes:
- Enhanced dbt MCP server with Lightdash integration
- Cipher memory server for persistent context
- Various tools for data analysis and visualization

Current working directory: `/Users/batibat/Documents/dbt-mcp`
Branch: `feature/lightdash-integration`
# Deploying Enhanced dbt-mcp to LibreChat (Docker)

## Overview

This guide explains how to deploy your enhanced dbt-mcp server with Lightdash integration to LibreChat running in Docker.

## Key Considerations

### 1. Network Access
- **Problem**: `localhost:3000` won't work from inside Docker container
- **Solution**: Use `host.docker.internal:3000` (on Mac/Windows) or actual IP address

### 2. File Paths
- **Problem**: Local file paths like `/Users/batibat/Documents/...` don't exist in Docker
- **Solution**: Either disable dbt CLI features or mount volumes

### 3. Code Availability
- **Problem**: Your enhanced dbt-mcp code needs to be accessible
- **Solution**: Multiple options below

## Deployment Options

### Option 1: Using UVX with Local Path (Development)

1. Make sure your code is committed:
```bash
cd /Users/batibat/Documents/dbt-mcp
git add -A
git commit -m "Enhanced dbt-mcp with Lightdash integration"
```

2. Update LibreChat's docker-compose.yml to mount your code:
```yaml
services:
  api:
    volumes:
      - ./librechat.yaml:/app/librechat.yaml
      - /Users/batibat/Documents/dbt-mcp:/dbt-mcp:ro  # Add this line
```

3. Update librechat.yaml:
```yaml
mcpServers:
  dbt-mcp-enhanced:
    type: stdio
    command: python
    args:
      - -m
      - pip
      - install
      - /dbt-mcp
      - &&
      - python
      - -m
      - dbt_mcp
    env:
      LIGHTDASH_API_URL: http://host.docker.internal:3000/api/v1
      # ... rest of config
```

### Option 2: Build Custom Docker Image (Production)

1. Create a Dockerfile in LibreChat directory:
```dockerfile
FROM ghcr.io/danny-avila/librechat-dev:latest

# Install enhanced dbt-mcp
COPY --from=build /Users/batibat/Documents/dbt-mcp /tmp/dbt-mcp
RUN cd /tmp/dbt-mcp && pip install . && rm -rf /tmp/dbt-mcp
```

2. Update docker-compose.yml:
```yaml
services:
  api:
    build: .
    # ... rest of config
```

### Option 3: Publish to PyPI or GitHub (Recommended for Teams)

1. Publish to GitHub:
```bash
cd /Users/batibat/Documents/dbt-mcp
git push origin feature/lightdash-integration
```

2. Update librechat.yaml:
```yaml
mcpServers:
  dbt-mcp-enhanced:
    type: stdio
    command: uvx
    args:
      - --from
      - git+https://github.com/yourusername/dbt-mcp.git@feature/lightdash-integration
      - dbt-mcp
    env:
      # ... config
```

## Testing the Integration

1. **Restart LibreChat**:
```bash
cd /Users/batibat/Documents/LibreChat
docker-compose down
docker-compose up -d
```

2. **Check logs**:
```bash
docker-compose logs -f api | grep -i mcp
```

3. **Test in LibreChat UI**:
- Open LibreChat
- Select a model that supports tools/MCP
- Try commands like:
  - "List all Lightdash spaces"
  - "Show me available explores"
  - "List metrics with their sources"

## Troubleshooting

### Common Issues:

1. **"Cannot connect to Lightdash"**
   - Check if Lightdash is accessible from Docker: `docker exec librechat-api curl http://host.docker.internal:3000`
   - Try using your machine's IP instead of host.docker.internal

2. **"Module not found: dbt_mcp"**
   - Ensure the volume mount is correct
   - Check if the Python path includes your code

3. **"Authentication failed"**
   - Verify your API key is still valid
   - Check if the key has the necessary permissions

### Debug Commands:

```bash
# Test MCP server directly
docker exec -it librechat-api bash
cd /app
python -m dbt_mcp --help

# Test Lightdash connection
curl -H "Authorization: ApiKey YOUR_KEY" http://host.docker.internal:3000/api/v1/projects
```

## Environment Variables Reference

| Variable | Description | Example |
|----------|-------------|---------|
| LIGHTDASH_API_URL | Lightdash API endpoint | http://host.docker.internal:3000/api/v1 |
| LIGHTDASH_API_KEY | Your personal access token | ldpat_xxx... |
| LIGHTDASH_PROJECT_ID | UUID of your Lightdash project | 9ee4e9bc-... |
| LIGHTDASH_DEFAULT_SPACE_ID | Default space for charts | 9317484c-... |
| LIGHTDASH_DEFAULT_CHART_TYPE | Default chart type | table |
| DISABLE_LIGHTDASH | Disable Lightdash features | false |

## Available Tools

Once deployed, these tools will be available in LibreChat:

1. **lightdash_list_spaces** - List all Lightdash spaces
2. **lightdash_list_charts** - List charts in a space
3. **lightdash_get_chart** - Get chart details
4. **lightdash_create_chart** - Create chart from data
5. **lightdash_list_explores** - List available explores
6. **lightdash_get_explore** - Get explore details
7. **lightdash_run_query** - Execute query and save as chart
8. **list_metrics_enhanced** - List metrics from both sources

## Next Steps

1. Test each tool individually
2. Create some sample charts
3. Document common workflows for your team
4. Consider setting up proper CI/CD for updates
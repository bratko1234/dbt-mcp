# dbt-mcp-lightdash

Enhanced MCP (Model Context Protocol) server for dbt with Lightdash integration, enabling natural language interaction with your data warehouse through visualization and chart management.

## Features

- ✅ All original dbt MCP functionality (semantic layer, CLI tools, discovery)
- 📊 **Lightdash Integration**: Query, create, and manage charts
- 🤖 **Smart Prompts**: Pre-built workflows for common data tasks
- 📚 **Resources**: Quick access to Lightdash metadata
- 🔧 **Enhanced Tools**: 9 new Lightdash tools for complete BI workflow

## Installation

```bash
pip install dbt-mcp-lightdash
```

## Quick Start

### 1. Set Environment Variables

```bash
# dbt Configuration
export DBT_HOST=cloud.getdbt.com
export DBT_TOKEN=your_dbt_token
export DBT_PROD_ENV_ID=your_env_id

# Lightdash Configuration
export LIGHTDASH_API_URL=https://your-lightdash.com/api/v1
export LIGHTDASH_API_KEY=your_api_key
export LIGHTDASH_PROJECT_ID=your_project_uuid
export LIGHTDASH_DEFAULT_SPACE_ID=your_space_uuid
```

### 2. Run the Server

```bash
dbt-mcp
```

### 3. Use with LibreChat

Add to your LibreChat configuration:

```json
{
  "mcpServers": {
    "dbt-lightdash": {
      "command": "dbt-mcp",
      "env": {
        "DBT_HOST": "${DBT_HOST}",
        "DBT_TOKEN": "${DBT_TOKEN}",
        "LIGHTDASH_API_URL": "${LIGHTDASH_API_URL}",
        "LIGHTDASH_API_KEY": "${LIGHTDASH_API_KEY}",
        "LIGHTDASH_PROJECT_ID": "${LIGHTDASH_PROJECT_ID}"
      }
    }
  }
}
```

## Lightdash Tools

### Query & Analysis
- `lightdash_run_metric_query` - Execute queries and optionally save as charts
- `list_metrics_enhanced` - View all metrics with metadata from both dbt and Lightdash

### Chart Management
- `lightdash_create_chart` - Create new charts from query results
- `lightdash_list_charts` - List all saved charts
- `lightdash_get_chart` - Get chart details and configuration

### Data Discovery
- `lightdash_list_spaces` - List available spaces
- `lightdash_list_explores` - List all queryable data models
- `lightdash_get_explore` - Get fields for a specific explore
- `lightdash_get_user` - Get user and organization info

## MCP Prompts

Pre-built workflows for common tasks:

- **lightdash-metric-analysis** - Turn business questions into queries
- **lightdash-dashboard-builder** - Plan complete dashboards
- **lightdash-chart-optimization** - Improve existing charts
- **lightdash-data-exploration** - Explore data for insights

## MCP Resources

Quick read-only access to metadata:

- `lightdash://spaces` - All available spaces
- `lightdash://explores` - All data models
- `lightdash://metrics` - Metrics summary
- `lightdash://charts` - All saved charts

## Example Usage

```python
# In your MCP client or LibreChat:

# 1. Explore available data
"What metrics are available for revenue analysis?"

# 2. Run a query
"Show me monthly revenue for the last 12 months"

# 3. Save as chart
"Save this as 'Monthly Revenue Trend' in the Finance space"

# 4. Build a dashboard
"Help me create an executive dashboard for daily monitoring"
```

## Requirements

- Python >= 3.10
- dbt Cloud or Core setup
- Lightdash instance with API access
- MCP-compatible client (LibreChat, Claude Desktop, etc.)

## License

Apache License 2.0

## Credits

Built on top of the official [dbt-labs/dbt-mcp](https://github.com/dbt-labs/dbt-mcp) project.
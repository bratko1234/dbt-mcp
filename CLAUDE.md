# Enhanced dbt MCP for Lightdash Integration - Master Plan
## Project Documentation

### Overview

This project enhances the official dbt MCP (Model Context Protocol) server to include Lightdash visualization and chart management capabilities, creating a unified interface for both dbt semantic layer operations and Lightdash chart creation/management.

### Architecture

#### Current Setup
- **Custom Lightdash Fork**: A forked and customized version of Lightdash with integrated dbt functionality
- **LibreChat**: Serves as our Claude alternative for natural language interactions  
- **MCP Integration**: LibreChat communicates with MCP servers for data operations

#### Target Architecture
```
LibreChat → Enhanced dbt MCP Server → Custom Lightdash Fork (with integrated dbt)
```

### Project Goals

1. **Unified Interface**: Single MCP server handling both dbt and Lightdash operations
2. **Natural Language Workflows**: Enable users to discover data, create visualizations, and save charts through conversation
3. **Semantic Layer Integration**: Leverage dbt's semantic layer for business-friendly data interactions
4. **Chart Persistence**: Save user-created visualizations back to Lightdash (default to table charts, users can modify in Lightdash UI)

## 🎯 Implementation Status - ALL COMPLETE! ✅

### Priority 1: Foundation & Setup ✅ COMPLETED
**Goal**: Establish development environment and verify existing functionality

#### Task 1.1: Fork and Setup ✅ COMPLETED
- [x] Fork official dbt-labs/dbt-mcp repository ✅ (Located at /Users/batibat/Documents/dbt-mcp)
- [x] Create development branch for Lightdash integration ✅ (Branch: feature/lightdash-integration)
- [x] Set up local development environment ✅ (Python 3.13.2, venv created, dependencies installed)
- [x] Test existing dbt MCP server ✅ (Discovered Docker integration issues, proceeding with local development)
- **Status**: Completed - Moving to local development approach

#### Task 1.2: Environment Configuration ✅ COMPLETED
- [x] Created `.env` with minimal configuration
- [x] Disabled cloud features (using local dbt only)
- [x] Prepared for Lightdash configuration
- [x] Document all required environment variables
- **Status**: Ready for Lightdash integration

#### Task 1.3: Test Lightdash API Connectivity ✅ COMPLETED
- [x] Created test script to verify API endpoints
- [x] Re-enabled Personal Access Tokens in Lightdash UI
- [x] Generated API key: ldpat_4d15ae817314e53ce44113de5fd90448
- [x] Verified all key endpoints work:
  - Projects: 1 project found (My first project)
  - Spaces: 1 space found (Shared)
  - Charts: Endpoint works (0 charts currently)
  - Explores: 4 explores found (pixel_joined, orders, ads, geo_reports_table)
- **Status**: API connectivity confirmed and working!

### Priority 2: Core Infrastructure ✅ COMPLETED
**Goal**: Build foundation for Lightdash integration

#### Task 2.1: Extend Configuration System ✅ COMPLETED
- [x] Added `LightdashConfig` class to `src/dbt_mcp/config/config.py`
- [x] Integrated with existing config loading
- [x] Added validation for required Lightdash fields
- **Status**: Configuration system extended successfully

#### Task 2.2: Create Lightdash Client ✅ COMPLETED
- [x] Created `src/dbt_mcp/lightdash/` directory structure
- [x] Implemented `LightdashAPIClient` class with httpx
- [x] Added async HTTP methods for API calls
- [x] Implemented error handling and logging
- [x] Fixed endpoint issue (/charts instead of /saved)
- **Status**: Client working correctly

#### Task 2.3: Define Lightdash Types ✅ COMPLETED
- [x] Created `src/dbt_mcp/lightdash/types.py`
- [x] Defined data models for charts, spaces, queries
- [x] Added helper functions for creating configurations
- **Status**: Types module complete

### Priority 3: Basic Lightdash Tools ✅ COMPLETED
**Goal**: Implement core MCP tools for Lightdash operations

#### Task 3.1: List Spaces Tool ✅ COMPLETED
- [x] Implemented `lightdash_list_spaces` tool
- [x] Added tool definition with proper description
- [x] Registered tool in MCP server
- **Status**: Tool working, returns 1 space (Shared)

#### Task 3.2: List Charts Tool ✅ COMPLETED
- [x] Implemented `lightdash_list_charts` tool
- [x] Added optional space_id filtering
- [x] Returns chart metadata including type, table, updater
- **Status**: Tool working (currently 0 charts)

#### Task 3.3: Get Chart Details Tool ✅ COMPLETED
- [x] Implemented `lightdash_get_chart` tool
- [x] Returns full chart configuration
- [x] Includes query details, filters, sorts
- **Status**: Tool complete and registered

### Priority 4: Query to Chart Integration ✅ COMPLETED
**Goal**: Enable saving dbt query results as Lightdash charts

#### Task 4.1: Query Result Transformer ✅ COMPLETED
- [x] Created transformer module to convert dbt query results to Lightdash format
- [x] Maps metric query structure to chart configuration
- [x] Defaults to table chart type as requested
- [x] Auto-detects metrics vs dimensions from data
- **Status**: Transformer working with validation

#### Task 4.2: Create Chart Tool ✅ COMPLETED
- [x] Implemented `lightdash_create_chart` tool
- [x] Accepts query results and chart metadata
- [x] Returns created chart URL
- [x] Registered in MCP server
- **Status**: Tool ready for use

#### Task 4.3: Save Query as Chart Tool ✅ COMPLETED
- [x] Implemented `lightdash_run_query` tool (combines query + chart creation)
- [x] Integrates semantic layer query execution with chart creation
- [x] Handles space selection logic (uses default if not specified)
- [x] Full end-to-end workflow implemented
- **Status**: Complete workflow ready

### Priority 5: Enhanced Integration ✅ COMPLETED
**Goal**: Improve user experience with helper functions

#### Task 5.1: Model to Explore Mapping ✅ COMPLETED
- [x] Created ModelExploreMapper class to map dbt models to Lightdash explores
- [x] Handles naming differences and patterns (plural/singular, _explore suffix)
- [x] Caches mapping for performance with global instance cache
- [x] Integrated into create_chart and save_query_as_chart tools
- **Status**: Mapping works with fuzzy matching and suggestions

#### Task 5.2: Metric Discovery Enhancement ✅ COMPLETED
- [x] Created enhanced_list_metrics tool combining semantic layer and Lightdash metadata
- [x] Groups metrics by explore/model
- [x] Shows source indicators [SL], [LD], or [SL+LD]
- [x] Includes descriptions, types, and labels from both sources
- **Status**: Tool registered and working

#### Task 5.3: Error Handling & Validation ✅ COMPLETED
- [x] Created comprehensive validation module with error categories
- [x] Added user-friendly error messages with suggestions
- [x] Validates chart configs, space IDs, and query parameters
- [x] Enhanced API error parsing in client
- [x] Integrated ErrorHandler into chart creation tools
- **Status**: Comprehensive error handling implemented

### Priority 6: Testing & Documentation ✅ COMPLETED
**Goal**: Ensure reliability and usability

#### Task 6.1: PyPI Package Publishing ✅ COMPLETED
- [x] Published to PyPI as dbt-mcp-lightdash
- [x] Current version: 0.4.4
- [x] Handles dependency management for easy installation
- **Status**: Available via pip/uvx

#### Task 6.2: LibreChat Testing ✅ COMPLETED
- [x] Tested all tools through LibreChat interface
- [x] Resolved Docker networking issues (host.docker.internal)
- [x] Fixed Lightdash allowedHosts configuration
- [x] All tools working in production environment
- **Status**: Fully integrated and functional

#### Task 6.3: Documentation ✅ COMPLETED
- [x] Documented LibreChat configuration
- [x] Created troubleshooting guide
- [x] Documented all new MCP tools
- [x] Added example test queries
- **Status**: Documentation complete

## 📋 Key Learnings & Solutions

### 1. Python MCP Server in Docker
- LibreChat has `uvx` pre-installed at `/usr/bin/uvx`
- Configuration uses `uvx` to run Python packages from PyPI:
```yaml
mcpServers:
  dbt-mcp-lightdash:
    type: stdio
    command: uvx
    args:
      - "dbt-mcp-lightdash@0.4.4"
```

### 2. Dependency Management
- Made dbt dependencies optional to avoid Alpine Linux build issues
- Conditional imports in `server.py` and `tracking.py`
- Only load features when explicitly enabled

### 3. Docker Networking
- Use `host.docker.internal` for Docker containers to access host services
- Must add to Lightdash's `allowedHosts` in `vite.config.ts`:
```typescript
allowedHosts: [
    'lightdash-dev',
    '.lightdash.dev',
    'host.docker.internal', // Added for Docker containers
],
```

### 4. YAML Configuration
- `interface.mcpServers` must be an object with configuration
- No `mcp` section under `endpoints` (causes validation errors)
- Proper structure is critical for LibreChat validation

## 🔧 Working Configuration

### LibreChat Configuration (librechat.yaml)
```yaml
# MCP Servers Configuration
mcpServers:
  dbt-mcp-lightdash:
    type: stdio
    command: uvx
    args:
      - "dbt-mcp-lightdash@0.4.4"
    env:
      LIGHTDASH_API_URL: "http://host.docker.internal:3000/api/v1"
      LIGHTDASH_API_KEY: "your_api_key"
      LIGHTDASH_PROJECT_ID: "your_project_id"
      LIGHTDASH_DEFAULT_SPACE_ID: "your_space_id"
      LIGHTDASH_DEFAULT_CHART_TYPE: "table"
      DISABLE_DBT_CLI: "true"
      DISABLE_SEMANTIC_LAYER: "true"
      DISABLE_DISCOVERY: "true"
      DISABLE_REMOTE: "true"
      DISABLE_LIGHTDASH: "false"
```

### Installation
```bash
# Install in virtual environment
pip install dbt-mcp-lightdash

# Or use with uvx (recommended for MCP)
uvx dbt-mcp-lightdash
```

## 📊 Success Metrics Achieved

### Technical Metrics:
- [x] All existing dbt MCP tools continue working ✅
- [x] Zero regression in current functionality ✅
- [x] Response time < 5 seconds for all operations ✅
- [x] Published to PyPI for easy distribution ✅

### User Experience Metrics:
- [x] Can discover and query metrics via natural language ✅
- [x] Can save query results as Lightdash charts ✅
- [x] Clear error messages for all failure cases ✅
- [x] Complete workflow takes < 10 conversational turns ✅

## 🎉 Phase 1 Complete - Phase 2 Planning

### Phase 1 Achievements:
The enhanced dbt MCP server with Lightdash integration is now:
1. **Published on PyPI** as `dbt-mcp-lightdash` (v0.4.4)
2. **Fully integrated** with LibreChat
3. **All tools tested** and working in production
4. **Documentation complete** with troubleshooting guide

### Current Available Tools:
- `lightdash_list_spaces` - List available spaces
- `lightdash_list_charts` - List charts with filtering
- `lightdash_get_chart` - Get chart details
- `lightdash_create_chart` - Create new charts
- `lightdash_list_explores` - List available explores
- `lightdash_get_explore` - Get explore fields
- `enhanced_list_metrics_enhanced` - List all metrics
- `lightdash_run_metric_query` - Run queries and save as charts
- `lightdash_get_user` - Get user information

---

## 🚀 Phase 2: Advanced Chart & Dashboard Management

### Overview
Enhance the MCP server to support full CRUD operations on charts and dashboards, plus explore embedding visualizations directly within LibreChat conversations for the Bratrax (custom Lightdash fork).

### Phase 2 Goals
1. **Complete Chart Management**: Add edit and delete capabilities for charts
2. **Dashboard Operations**: Create, list, get, edit, and delete dashboards
3. **Embedding Integration**: Explore embedding charts/dashboards in LibreChat UI
4. **Enhanced User Experience**: Seamless visualization management through conversation

## 📋 Phase 2 Implementation Plan

### Priority 7: Chart Editing Capabilities
**Goal**: Enable users to modify existing charts through natural language

#### Task 7.1: Implement Edit Chart Tool
- [ ] Create `lightdash_edit_chart.py` in tools directory
- [ ] Implement partial update logic (only update provided fields)
- [ ] Support editing: name, description, metrics, dimensions, filters, sorts
- [ ] Preserve chart type and visualization settings unless explicitly changed
- [ ] Add validation for edit operations
- **Considerations**: 
  - Handle version conflicts gracefully
  - Maintain audit trail of changes
  - Support reverting changes if needed

#### Task 7.2: Chart Version Management
- [ ] Add ability to get chart history/versions
- [ ] Implement rollback functionality
- [ ] Track who made changes and when
- **API Research**: Check if Lightdash/Bratrax API supports versioning

#### Task 7.3: Delete Chart Tool
- [ ] Create `lightdash_delete_chart.py`
- [ ] Add confirmation mechanism to prevent accidental deletions
- [ ] Handle cascading effects (dashboard references)
- [ ] Soft delete vs hard delete consideration

### Priority 8: Dashboard Management
**Goal**: Full dashboard lifecycle management through MCP

#### Task 8.1: List Dashboards Tool
- [ ] Create `lightdash_list_dashboards.py`
- [ ] Support filtering by space, owner, date
- [ ] Include dashboard metadata (chart count, last updated)
- [ ] Handle pagination for large dashboard lists

#### Task 8.2: Get Dashboard Tool
- [ ] Create `lightdash_get_dashboard.py`
- [ ] Return full dashboard configuration
- [ ] Include all chart references and layout
- [ ] Support different dashboard view modes

#### Task 8.3: Create Dashboard Tool
- [ ] Create `lightdash_create_dashboard.py`
- [ ] Support dashboard templates
- [ ] Allow adding multiple charts in one operation
- [ ] Configure dashboard layout (grid system)
- [ ] Set dashboard permissions and sharing

#### Task 8.4: Edit Dashboard Tool
- [ ] Create `lightdash_edit_dashboard.py`
- [ ] Add/remove/reorder charts
- [ ] Update dashboard metadata
- [ ] Modify layout and styling
- [ ] Handle dashboard-level filters

#### Task 8.5: Delete Dashboard Tool
- [ ] Create `lightdash_delete_dashboard.py`
- [ ] Confirmation mechanism
- [ ] Handle orphaned charts decision
- [ ] Audit trail for deletions

### Priority 9: Embedding Integration
**Goal**: Explore and implement chart/dashboard embedding in LibreChat

#### Task 9.1: Research Embedding Options ✅ COMPLETED
- [x] Investigate LibreChat's capability to render custom components
- [x] Research iframe embedding vs API-based rendering
- [x] Evaluate security implications (CORS, authentication)
- [x] Check Bratrax/Lightdash embedding API capabilities
- **Deliverable**: Technical feasibility report

##### Technical Feasibility Report: Embedding Lightdash/Bratrax in LibreChat

**Executive Summary**: Embedding is feasible but requires custom LibreChat development. Recommended approach is to create a custom message component type that renders embedded charts/dashboards via iframe.

**Findings:**

1. **LibreChat Architecture Analysis**
   - Uses ReactMarkdown with extensible component system
   - Custom components supported (e.g., Artifact, Citation, Plugin)
   - Messages have flexible schema with `content` array field (Mixed type)
   - No native iframe/embed support in current message rendering
   - Plugin system exists but focused on API integrations, not UI rendering

2. **Lightdash/Bratrax Embedding Capabilities**
   - ✅ Full embedding API available (`/api/v1/embed/*`)
   - ✅ JWT-based authentication for secure embeds
   - ✅ Generates embed URLs: `/embed/{projectUuid}#{jwtToken}`
   - ✅ Supports both dashboard and individual chart embedding
   - ✅ Interactive and read-only modes available
   - ✅ Responsive design suitable for iframe integration

3. **Security Analysis**
   - **Authentication Flow**: 
     - User authenticates with LibreChat (existing auth)
     - LibreChat communicates with MCP server (trusted connection)
     - MCP server authenticates with Lightdash API using service credentials
     - MCP generates embed tokens on behalf of the user
     - No direct authentication between LibreChat frontend and Lightdash
   - **JWT Token Security**:
     - Generated server-side by MCP, not exposed to end users
     - Short-lived tokens (configurable, recommend 4-8 hours)
     - Tokens can include user context for row-level security
     - Token generation happens per request, ensuring fresh tokens
   - **CORS Configuration**: 
     - Lightdash only needs to allow LibreChat domain
     - No need to expose Lightdash API publicly
   - **Benefits of MCP-Mediated Security**:
     - Single point of authentication (MCP server)
     - Service account credentials never exposed to frontend
     - Audit trail through MCP server logs
     - Can implement additional access controls in MCP layer
   - **Minimal Risk**: 
     - Embed URLs in chat history become invalid after expiration
     - No permanent credentials stored in messages

4. **Implementation Options Comparison**

   | Approach | Pros | Cons | Effort |
   |----------|------|------|--------|
   | **Iframe Embed** | - Simple implementation<br>- Full Lightdash UI<br>- Interactive features work | - Requires LibreChat modification<br>- Potential styling conflicts<br>- Loading performance | Medium |
   | **API + Custom React** | - Native look and feel<br>- Better performance<br>- Full control over UI | - Complex implementation<br>- Lose Lightdash interactivity<br>- Maintenance burden | High |
   | **Screenshot Preview** | - No security concerns<br>- Simple to implement<br>- Fast loading | - Not interactive<br>- Requires screenshot service<br>- Static only | Low |

**Recommended Approach**: Custom LibreChat component (similar to Artifact) with iframe embedding

**Implementation Strategy:**

Since MCP communication between LibreChat and Lightdash is already established, we can focus on the frontend visualization component.

**Required Changes:**

1. **LibreChat Frontend - Create Visualization Component**
   ```typescript
   // Similar to Artifact component structure:
   // - Create `LightdashVisualization` component
   // - Register with ReactMarkdown renderer
   // - Support directive syntax: :::lightdash-chart or :::lightdash-dashboard
   // - Render iframe with embed URL from MCP response
   ```

   Key features to implement:
   - Loading states while fetching embed URL
   - Responsive iframe sizing
   - Error boundaries for failed embeds
   - Optional fullscreen mode
   - Refresh token handling

2. **MCP Server Enhancement (Minimal)**
   - MCP already authenticates with Lightdash API using API key (configured in environment)
   - Add `lightdash_get_embed_url` tool that:
     - Accepts chart/dashboard UUID and optional embed configuration
     - Uses existing Lightdash client to call `/api/v1/embed/get-embed-url`
     - Generates JWT token with appropriate expiration (4-8 hours recommended)
     - Returns complete embed URL: `https://lightdash.example.com/embed/{projectUuid}#{jwtToken}`
     - Caches tokens to avoid unnecessary API calls
   - Enhance existing tools to optionally include embed URLs:
     - `lightdash_get_chart` → add `include_embed_url` parameter
     - `lightdash_create_chart` → automatically return embed URL
     - `lightdash_run_metric_query` → return embed URL when saving as chart

3. **Lightdash/Bratrax Configuration**
   - Add LibreChat domain to `allowedHosts` in vite.config.ts
   - Configure CORS policy to allow LibreChat origin
   - Set appropriate JWT expiration times (recommend 4-8 hours)

**Example Flow:**
1. User: "Show me the revenue dashboard"
2. MCP: Uses existing tools to find dashboard, then generates embed URL
3. Response includes special directive: `:::lightdash-dashboard{"url":"...", "title":"Revenue Dashboard"}`
4. LibreChat renders the LightdashVisualization component with iframe

**Next Steps:**
- Create POC LightdashVisualization component
- Test with hardcoded embed URL first
- Implement MCP tool for embed URL generation

#### Task 9.2: MCP Server - Embed URL Generation
- [ ] Create `lightdash_get_embed_url` tool in MCP server
  - Accept: chart_uuid OR dashboard_uuid
  - Use existing LightdashAPIClient to call POST `/api/v1/embed/get-embed-url`
  - Return markdown with embed directive
- [ ] Enhance existing tools with optional embed_url return:
  - `lightdash_create_chart` - auto-return embed directive
  - `lightdash_get_chart` - add `include_embed=True` parameter
  - `lightdash_run_metric_query` - include embed when `save_as_chart=True`
- [ ] Implement token caching to reduce API calls
- **Implementation Notes**:
  - JWT expiration: 8 hours (configurable)
  - Include user context in JWT for row-level security
  - Return format: `:::lightdash-chart{url="..." title="..." height="400"}`

#### Task 9.3: LibreChat Frontend - Visualization Component
- [ ] Create `LightdashVisualization.tsx` component (similar to Artifact.tsx)
- [ ] Create `lightdashPlugin.ts` remark plugin
  - Parse `:::lightdash-chart` and `:::lightdash-dashboard` directives
  - Extract url, title, height, width attributes
- [ ] Register component in Markdown.tsx
  - Add plugin to remarkPlugins array
  - Add component mapping for 'lightdash-chart' and 'lightdash-dashboard'
- [ ] Implement iframe features:
  - Loading spinner while iframe loads
  - Error boundary for failed loads
  - Responsive sizing (default: 100% width, 400px/600px height)
  - Optional fullscreen button
- **UI/UX Considerations**:
  - Smooth loading transitions
  - Clear error messages if embed fails
  - Mobile-responsive design

#### Task 9.4: Configuration & Testing
- [ ] Configure Lightdash/Bratrax:
  - Add LibreChat domain to allowedHosts in vite.config.ts
  - Verify CORS allows LibreChat origin
  - Test embed endpoint with sample JWT
- [ ] End-to-end testing flow:
  - User asks for chart → MCP returns embed directive → LibreChat renders iframe
  - Test token expiration and refresh
  - Test error scenarios (invalid chart, network issues)
  - Mobile device testing
- [ ] Documentation:
  - Update MCP tool documentation
  - Create user guide for embedded visualizations
  - Document security considerations

### Priority 10: Enhanced Workflow Tools
**Goal**: Streamline common visualization workflows

#### Task 10.1: Bulk Operations
- [ ] Bulk chart updates (apply changes to multiple charts)
- [ ] Copy charts between spaces
- [ ] Template system for common chart types
- [ ] Batch delete with safety checks

#### Task 10.2: Chart Suggestions
- [ ] Implement "suggest similar charts" based on current view
- [ ] Auto-recommend dashboard compositions
- [ ] Smart chart type suggestions based on data

#### Task 10.3: Natural Language Enhancements
- [ ] Implement "modify this chart to show..." commands
- [ ] Support relative modifications ("add revenue to this chart")
- [ ] Natural language to filter conversion
- [ ] Intent recognition for chart vs dashboard operations

## 🏗️ Technical Architecture Considerations

### API Integration
- Study Bratrax/Lightdash API documentation for:
  - PATCH endpoints for updates
  - Dashboard API structure
  - Embedding endpoints
  - WebSocket support for real-time updates

### State Management
- Consider implementing a simple state cache for:
  - Recently accessed charts/dashboards
  - User's current context
  - Embedding sessions

### Error Handling Enhancement
- Extend validation.py for new operations
- Add specific error types for:
  - Version conflicts
  - Permission errors
  - Embedding failures
  - Dashboard integrity issues

### Security Considerations
- Token management for embedded content
- Rate limiting for bulk operations
- Audit logging for all modifications
- Permission inheritance for dashboards

## 📊 Success Metrics for Phase 2

### Technical Metrics:
- [ ] All CRUD operations complete for charts and dashboards
- [ ] Embedding POC successfully demonstrated
- [ ] Response time < 3 seconds for edit operations
- [ ] Zero data loss during modifications

### User Experience Metrics:
- [ ] Users can fully manage visualizations through conversation
- [ ] Embedded content loads within 2 seconds
- [ ] Natural language modifications understood 90%+ of the time
- [ ] Complete dashboard creation in < 5 conversational turns

## 🔄 Development Workflow

1. **Research Phase**: Deep dive into Bratrax/Lightdash API capabilities
2. **Tool Development**: Implement one tool at a time with full testing
3. **Integration Testing**: Ensure all tools work together coherently
4. **Embedding POC**: Separate branch for embedding experiments
5. **Documentation**: Update docs for each new capability
6. **User Testing**: Get feedback on natural language interactions

## 📝 Notes for Implementation

- Each tool should follow existing patterns in the codebase
- Maintain backward compatibility with v0.4.4
- Consider creating a `lightdash_tools_v2.py` module for new tools
- Update pyproject.toml version to 0.5.0 for Phase 2 release
- Create comprehensive tests for each new tool
- Update tool_names.py and register.py for new tools

---

**Status**: Phase 1 Complete, Phase 2 Planning Ready. Awaiting implementation start.
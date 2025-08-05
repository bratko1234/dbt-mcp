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

## 🎯 Implementation Tasks (Prioritized)

### Priority 1: Foundation & Setup ✅ Requires Approval
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
- **Status**: Ready for Lightdash integration
- [ ] Document all required environment variables
- **Test**: Verify environment loading without breaking existing functionality
- **Approval Gate**: Show configuration loading properly

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

### Priority 3: Basic Lightdash Tools (IN PROGRESS)
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

### Priority 6: Testing & Documentation ✅ Requires Approval
**Goal**: Ensure reliability and usability

#### Task 6.1: Integration Tests
- [ ] Create test suite for Lightdash client
- [ ] Test all MCP tools with mock data
- [ ] Add end-to-end workflow tests
- **Test**: All tests pass
- **Approval Gate**: Review test coverage

#### Task 6.2: LibreChat Testing
- [ ] Test all tools through LibreChat interface
- [ ] Document common workflows
- [ ] Create troubleshooting guide
- **Test**: Real-world usage scenarios
- **Approval Gate**: Demo key workflows

#### Task 6.3: Documentation
- [ ] Update README with Lightdash features
- [ ] Create setup guide for users
- [ ] Document all new MCP tools
- [ ] Add example conversations
- **Test**: Documentation clarity
- **Approval Gate**: Review documentation

## 📋 Testing Strategy

### For Each Task:
1. **Unit Test**: Test individual functions/components
2. **Integration Test**: Test with real Lightdash instance
3. **LibreChat Test**: Verify through natural language interface
4. **Approval**: Get explicit approval before proceeding

### Test Environment Requirements:
- Local Lightdash instance with test data
- Test dbt project with models and metrics
- LibreChat configured with enhanced MCP server
- Separate test space in Lightdash for experiments

## 🚦 Approval Process

### Before Starting Each Task:
1. Review task requirements together
2. Agree on implementation approach
3. Define success criteria

### After Completing Each Task:
1. Demonstrate functionality
2. Review code changes
3. Run tests together
4. Get explicit approval to proceed

### Code Review Focus:
- Maintains existing dbt MCP functionality
- Follows project coding standards
- Includes proper error handling
- Has adequate test coverage

## 📊 Success Metrics

### Technical Metrics:
- [ ] All existing dbt MCP tools continue working
- [ ] Zero regression in current functionality
- [ ] Response time < 5 seconds for all operations
- [ ] 90%+ test coverage for new code

### User Experience Metrics:
- [ ] Can discover and query metrics via natural language
- [ ] Can save query results as Lightdash charts
- [ ] Clear error messages for all failure cases
- [ ] Complete workflow takes < 10 conversational turns

## 🔧 Configuration Template

```bash
# dbt Configuration (existing)
DBT_HOST=cloud.getdbt.com
DBT_TOKEN=your_dbt_token
DBT_PROD_ENV_ID=your_env_id
DBT_PROJECT_DIR=/path/to/dbt/project

# Lightdash Configuration (new)
LIGHTDASH_API_URL=https://your-lightdash.com/api/v1
LIGHTDASH_API_KEY=your_api_key
LIGHTDASH_PROJECT_ID=your_project_uuid
LIGHTDASH_DEFAULT_SPACE_ID=your_space_uuid
LIGHTDASH_DEFAULT_CHART_TYPE=table
```

## 🚀 Next Steps

1. **Immediate**: Review and approve this master plan
2. **Task 1.1**: Fork repository and set up development environment
3. **Checkpoint**: Verify setup before proceeding to Task 1.2

---

**Note**: This document is a living guide. Update task statuses and add learnings as we progress. Each task must be tested and approved before moving to the next.
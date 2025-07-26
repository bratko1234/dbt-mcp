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

#### Task 1.1: Fork and Setup
- [x] Fork official dbt-labs/dbt-mcp repository ✅ (Located at /Users/batibat/Documents/dbt-mcp)
- [ ] Create development branch for Lightdash integration
- [ ] Set up local development environment
- **Test**: Run existing dbt MCP server, verify all tools work
- **Approval Gate**: Demo existing dbt tools functioning

#### Task 1.2: Environment Configuration
- [ ] Create `.env.lightdash` with Lightdash-specific variables
- [ ] Extend existing `.env` to include Lightdash config
- [ ] Document all required environment variables
- **Test**: Verify environment loading without breaking existing functionality
- **Approval Gate**: Show configuration loading properly

#### Task 1.3: Test Lightdash API Connectivity
- [ ] Create simple Python script to test Lightdash API endpoints
- [ ] Verify authentication with API key
- [ ] Test key endpoints: spaces, explores, charts
- **Test**: Manual API calls return expected data
- **Approval Gate**: Demonstrate successful API connections

### Priority 2: Core Infrastructure ✅ Requires Approval
**Goal**: Build foundation for Lightdash integration

#### Task 2.1: Extend Configuration System
- [ ] Add `LightdashConfig` class to `src/dbt_mcp/config/config.py`
- [ ] Integrate with existing config loading
- [ ] Add validation for required Lightdash fields
- **Test**: Config loads and validates correctly
- **Approval Gate**: Show config integration working

#### Task 2.2: Create Lightdash Client
- [ ] Create `src/dbt_mcp/lightdash/` directory structure
- [ ] Implement `LightdashAPIClient` class
- [ ] Add async HTTP methods for API calls
- [ ] Implement error handling and retries
- **Test**: Client can make authenticated requests
- **Approval Gate**: Demo basic API operations

#### Task 2.3: Define Lightdash Types
- [ ] Create `src/dbt_mcp/lightdash/types.py`
- [ ] Define data models for charts, spaces, queries
- [ ] Ensure compatibility with Lightdash API responses
- **Test**: Type validation with sample API responses
- **Approval Gate**: Review type definitions

### Priority 3: Basic Lightdash Tools ✅ Requires Approval
**Goal**: Implement core MCP tools for Lightdash operations

#### Task 3.1: List Spaces Tool
- [ ] Implement `list_lightdash_spaces()` function
- [ ] Add tool definition with proper description
- [ ] Handle pagination if needed
- **Test**: Tool returns all available spaces
- **Approval Gate**: Demo in LibreChat

#### Task 3.2: List Charts Tool
- [ ] Implement `list_lightdash_charts(space_id)` function
- [ ] Add filtering capabilities
- [ ] Return chart metadata
- **Test**: Tool returns charts for given space
- **Approval Gate**: Demo in LibreChat

#### Task 3.3: Get Chart Details Tool
- [ ] Implement `get_lightdash_chart(chart_id)` function
- [ ] Return full chart configuration
- [ ] Include query details
- **Test**: Tool returns complete chart information
- **Approval Gate**: Demo in LibreChat

### Priority 4: Query to Chart Integration ✅ Requires Approval
**Goal**: Enable saving dbt query results as Lightdash charts

#### Task 4.1: Query Result Transformer
- [ ] Create function to transform dbt query results to Lightdash format
- [ ] Map metric query structure to chart configuration
- [ ] Default to table chart type
- **Test**: Transformation produces valid chart config
- **Approval Gate**: Review transformation logic

#### Task 4.2: Create Chart Tool
- [ ] Implement `create_lightdash_chart()` function
- [ ] Accept query results and chart metadata
- [ ] Return created chart URL
- **Test**: Successfully creates chart in Lightdash
- **Approval Gate**: Demo chart creation flow

#### Task 4.3: Save Query as Chart Tool
- [ ] Implement `save_query_as_chart()` workflow function
- [ ] Combine query execution with chart creation
- [ ] Handle space selection logic
- **Test**: End-to-end query to chart workflow
- **Approval Gate**: Demo complete workflow in LibreChat

### Priority 5: Enhanced Integration ✅ Requires Approval
**Goal**: Improve user experience with helper functions

#### Task 5.1: Model to Explore Mapping
- [ ] Create function to map dbt models to Lightdash explores
- [ ] Handle naming differences
- [ ] Cache mapping for performance
- **Test**: Accurate model resolution
- **Approval Gate**: Review mapping logic

#### Task 5.2: Metric Discovery Enhancement
- [ ] Enhance `list_metrics` to include Lightdash metadata
- [ ] Add metric descriptions and types
- [ ] Group metrics by model/explore
- **Test**: Enriched metric information
- **Approval Gate**: Demo enhanced discovery

#### Task 5.3: Error Handling & Validation
- [ ] Add comprehensive error messages
- [ ] Validate chart configurations before creation
- [ ] Handle API failures gracefully
- **Test**: Error scenarios handled properly
- **Approval Gate**: Demo error handling

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
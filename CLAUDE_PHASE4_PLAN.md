# Phase 4: Semantic Intelligence Layer for Natural Language Queries
## Simplifying Data Access with Business Context

### Problem Statement
Current `lightdash_run_metric_query` tool requires LLMs to:
1. Discover available explores
2. List metrics in each explore  
3. Understand field naming conventions
4. Build complex query parameters
5. Handle time grains and filters correctly

This leads to:
- Multiple unnecessary tool calls
- Confusion about field names (created_at vs created_at_day)
- Incorrect filter syntax
- Poor user experience (too many steps)

### Solution: Semantic Catalog Approach
Build intelligence about the specific business data model directly into the tools, enabling natural language queries like "last 7 days of sales" to work immediately.

## Key Business Context

### Data Model Overview
We have 4 main explores (tables) in Lightdash:

1. **orders** - E-commerce sales data
   - Primary metrics: total_gross_revenue, total_revenue, total_net_revenue, total_estimated_profit
   - Time dimension: created_at (also has event_date)
   - Store dimension: write_key (identifies different stores: US, UK, AU, etc.)
   - Key dimensions: customer_id, platform, source_name, fulfillment_status

2. **ads** - Advertising/marketing spend
   - Primary metrics: total_cost, total_impressions, total_clicks, total_conversions
   - Time dimension: event_date
   - Key dimensions: platform, channel, campaign_name, ad_name

3. **pixel_joined** - Marketing attribution (combines pixel tracking + orders)
   - Primary metrics: total_attributed_revenue, total_spend, avg_pixel_roas
   - Time dimension: event_date
   - Store dimension: write_key
   - Key dimensions: channel, campaign_name, utm_source, device_type

4. **geo_reports_table** - Geographic lead generation
   - Primary metrics: total_lead_count, sum_total_spend, cost_per_lead
   - Time dimension: date
   - Key dimensions: country, state, supplier_name, lead_status

### Critical Business Rules
- **write_key** represents different stores (multi-brand/multi-region setup)
- **Data Security**: Lightdash automatically filters by organizationUuid - users only see their own data
  - No need to add client_id filters in MCP layer
  - Security handled at database level via `sql_where: "client_id = ${lightdash.attribute.organizationUuid}"`
- Time dimensions support grains: day, week, month, quarter, year

## Implementation Plan

### Tools to Sunset (Deprecate)
These tools will be replaced by smarter alternatives:
1. ❌ `lightdash_list_explores` - No longer needed with semantic catalog
2. ❌ `lightdash_get_explore` - Intelligence built into new tools
3. ❌ `list_metrics_enhanced` - Replaced by semantic understanding
4. ⚠️ `lightdash_run_metric_query` - Keep but enhance significantly

### New Tools to Create

#### 1. `lightdash_smart_query`
**Purpose**: Answer business questions directly without manual exploration
**Examples**:
- "last 7 days of sales" → Automatically uses orders explore with revenue metrics
- "ad spend by campaign" → Uses ads explore with cost metrics
- "ROAS last month" → Uses pixel_joined with attribution metrics

#### 2. `lightdash_store_comparison`  
**Purpose**: Compare performance across stores (using write_key)
**Examples**:
- "compare US and UK sales"
- "top performing store this month"
- "all stores revenue trend"

#### 3. `lightdash_quick_metrics`
**Purpose**: Get key business metrics instantly
**Examples**:
- "today's revenue"
- "yesterday's ad spend"
- "this month's profit"

### Enhanced Tool: `lightdash_run_metric_query`
Keep but enhance with:
- Automatic field name resolution
- Smart time grain detection
- Better filter handling
- Store context awareness

## Technical Implementation

### Step 1: Create Semantic Catalog Module
```python
# src/dbt_mcp/lightdash/semantic_catalog.py

SEMANTIC_CATALOG = {
    "sales": {
        "explore": "orders",
        "primary_metrics": ["total_gross_revenue", "total_revenue"],
        "time_dimension": "created_at",
        "store_dimension": "write_key",
        "aliases": ["revenue", "orders", "sales", "income"]
    },
    "marketing": {
        "explore": "ads",
        "primary_metrics": ["total_cost", "total_clicks"],
        "time_dimension": "event_date",
        "aliases": ["advertising", "ad spend", "campaigns"]
    },
    # ... more domains
}
```

### Step 2: Implement Smart Query Tool
- Natural language parsing
- Automatic explore selection
- Time range understanding
- Store filtering support

### Step 3: Update Existing Tools
- Enhance run_metric_query with semantic understanding
- Add deprecation warnings to tools being sunset
- Update tool registration

### Step 4: Testing & Validation
- Test common business questions
- Validate store filtering works
- Ensure backward compatibility

## Success Criteria

### Technical Metrics
- [ ] Single tool call for common queries (vs 3-5 currently)
- [ ] 95%+ accuracy in explore selection
- [ ] Correct field name resolution
- [ ] Proper time grain handling

### User Experience Metrics  
- [ ] "last 7 days of sales" works immediately
- [ ] Store comparisons work naturally
- [ ] No need for field discovery
- [ ] Clear error messages with suggestions

## Migration Strategy

### Phase 4.1: Build & Test (Week 1)
- [ ] Create semantic catalog module
- [ ] Implement smart query tool
- [ ] Test with common queries

### Phase 4.2: Integration (Week 2)
- [ ] Enhance run_metric_query
- [ ] Add store comparison tool
- [ ] Update tool registration

### Phase 4.3: Deprecation (Week 3)
- [ ] Add deprecation warnings
- [ ] Update documentation
- [ ] Release v0.9.0

## Risk Mitigation
- Keep old tools available with deprecation warnings
- Extensive testing before release
- Clear migration guide for users
- Backward compatibility maintained

## Version Plan
- Current: v0.8.3
- Target: v0.9.0 (Phase 4 - Semantic Intelligence)
- Breaking changes: None (deprecations only)

## Notes
- The semantic catalog is specific to this Lightdash instance
- Write_key mapping may need configuration per deployment
- Consider making catalog configurable via YAML in future
# Schema Enhancement Recommendations for Better LLM Understanding

## Overview
These recommendations will help LLMs better understand and use your Lightdash data by providing clearer context, better descriptions, and explicit relationships in your dbt schema.

## Critical Fixes for Current Schema

### 1. pixel_joined Model - Attribution Fields
The `pixel_joined` model has critical fields that need better documentation to prevent LLMs from using wrong field names:

```yaml
- name: model
  description: 'Attribution model type - REQUIRED FILTER. Valid values: "last_click", "first_click", "linear", "time_decay", "position_based"'
  meta:
    dimension:
      type: string
      label: Attribution Model
      description: 'Attribution model - ALWAYS filter by this (e.g., last_click, first_click)'
      
- name: attribution_window  
  description: 'Attribution lookback window - REQUIRED FILTER. Valid values: "1_day", "7_day", "14_day", "30_day", "60_day", "90_day"'
  meta:
    dimension:
      type: string
      label: Attribution Window
      description: 'Attribution window - ALWAYS filter by this (e.g., 7_day, 30_day)'

- name: channel
  description: 'Marketing channel (facebook, google, tiktok, email, sms, organic). Use this for channel filtering, NOT platform.'
  meta:
    dimension:
      type: string
      label: Marketing Channel
      description: 'Use "channel" for filtering by traffic source (e.g., facebook, google)'
```

### 2. Add ROAS Metrics with Clear Names
Add calculated ROAS metrics that are easy to find and understand:

```yaml
meta:
  metrics:
    roas_excluding_blended:
      type: number
      label: "ROAS (Attributed Only)"
      description: "Return on Ad Spend for attributed revenue only. Formula: attributed_revenue / spend"
      sql: "CASE WHEN ${total_spend} > 0 THEN ${total_attributed_revenue} / ${total_spend} ELSE 0 END"
      round: 2
      format: "percent"
      
    roas_including_blended:
      type: number
      label: "ROAS (Total Revenue)"
      description: "Return on Ad Spend including all revenue. Formula: total_revenue / spend"  
      sql: "CASE WHEN ${total_spend} > 0 THEN ${total_order_revenue} / ${total_spend} ELSE 0 END"
      round: 2
      format: "percent"
      
    nc_roas:
      type: number
      label: "New Customer ROAS"
      description: "Return on Ad Spend for new customers only"
      sql: "CASE WHEN ${total_spend} > 0 THEN ${total_new_customer_order_revenue} / ${total_spend} ELSE 0 END"
      round: 2
      format: "percent"
```

## General Schema Enhancement Patterns

### 1. Use Descriptive Labels and Descriptions
```yaml
# Bad - unclear what this means
- name: cpm
  description: 'Cost per thousand impressions'

# Good - clear and searchable
- name: cpm
  description: 'Cost Per Mille (CPM) - The cost to show your ad 1,000 times. Lower is better.'
  meta:
    dimension:
      label: "Cost per 1,000 Impressions (CPM)"
      description: "Average cost to show your ad to 1,000 people"
```

### 2. Add Common Aliases in Descriptions
```yaml
- name: channel
  description: 'Marketing channel (also called: platform, source, traffic source). Values: facebook, google, tiktok, email, sms'
  meta:
    dimension:
      type: string
      label: "Marketing Channel"
      description: "Traffic source - use 'facebook' for Meta/Facebook ads"
```

### 3. Document Required Filters
```yaml
models:
  - name: pixel_joined
    description: |
      Attribution data for marketing performance.
      
      ⚠️ REQUIRED FILTERS:
      - model: Attribution model (last_click, first_click)
      - attribution_window: Lookback window (7_day, 30_day)
      
      Without these filters, metrics aggregate ALL attribution models and windows!
```

### 4. Group Related Metrics
```yaml
meta:
  group_details:
    "ROAS Metrics": { order: 1, description: "Return on ad spend calculations" }
    "Attribution Metrics": { order: 2, description: "Conversion attribution" }
    "Customer Metrics": { order: 3, description: "Customer acquisition and value" }
    "Spend Metrics": { order: 4, description: "Advertising costs" }
```

### 5. Add Usage Examples in Descriptions
```yaml
- name: event_date
  description: |
    Date of the event. Use for time-based analysis.
    Examples:
    - Last 30 days: filter with operator "inThePast", value: 30, unit: "days"
    - Specific month: filter with operator "inDateRange", start: "2024-01-01", end: "2024-01-31"
```

### 6. Create Commonly Used Calculated Metrics
```yaml
meta:
  metrics:
    cpa:
      type: number
      label: "Cost Per Acquisition (CPA)"
      description: "Average cost to acquire a customer"
      sql: "CASE WHEN ${total_attributed_purchases} > 0 THEN ${total_spend} / ${total_attributed_purchases} ELSE 0 END"
      
    ltv_to_cac_ratio:
      type: number
      label: "LTV:CAC Ratio"
      description: "Lifetime value to customer acquisition cost ratio. Target: > 3.0"
      sql: "${customer_lifetime_value} / NULLIF(${customer_acquisition_cost}, 0)"
```

### 7. Add Dimension Value Documentation
```yaml
- name: campaign_objective
  description: |
    Facebook campaign objective.
    Common values:
    - CONVERSIONS: Optimize for purchases/signups
    - TRAFFIC: Drive website visits
    - REACH: Maximum audience exposure
    - VIDEO_VIEWS: Video engagement
    - LEAD_GENERATION: Collect leads
```

### 8. Use Consistent Naming Conventions
```yaml
# Standardize prefixes for metrics
metrics:
  total_*    # For sums (total_revenue, total_spend)
  avg_*      # For averages (avg_ctr, avg_roas)
  count_*    # For counts (count_orders, count_customers)
  rate_*     # For rates (rate_conversion, rate_bounce)
  cost_*     # For cost metrics (cost_per_click, cost_per_acquisition)
```

## Implementation Priority

### Phase 1: Critical Fixes (Do Immediately)
1. Fix `model` and `channel` field descriptions in pixel_joined
2. Add clear ROAS metric definitions
3. Document required filters for attribution data

### Phase 2: Improve Discoverability (This Week)
1. Add comprehensive descriptions to all metrics
2. Group related metrics logically
3. Add common aliases in descriptions

### Phase 3: Enhanced Context (Next Sprint)
1. Add usage examples in descriptions
2. Create calculated metrics for common analyses
3. Document dimension values where applicable

## Testing Your Schema Improvements

After implementing changes, test with these queries:
1. "What's my Facebook ROAS?" - Should use channel='facebook', not platform
2. "Show me last click attribution" - Should use model='last_click'
3. "Calculate my cost per acquisition" - Should find the CPA metric easily
4. "What's my return on ad spend?" - Should find ROAS metrics without confusion

## Example Enhanced Column Definition

Here's a complete example of an enhanced column definition:

```yaml
- name: channel
  description: |
    Marketing channel identifier.
    
    Valid values:
    - facebook (Meta/Facebook ads)
    - google (Google Ads)
    - tiktok (TikTok ads)
    - email (Email marketing)
    - sms (SMS marketing)
    - organic (Non-paid traffic)
    
    Also known as: platform, source, traffic_source
    
    Example filters:
    - Facebook only: {"field": "channel", "operator": "equals", "value": "facebook"}
    - Paid channels: {"field": "channel", "operator": "notEquals", "value": "organic"}
  meta:
    dimension:
      type: string
      label: "Marketing Channel"
      description: "Traffic source (use 'facebook' for Meta ads)"
```

## Notes for Implementation

1. **Test with LLMs**: After making changes, test with actual queries to ensure LLMs understand
2. **Version Control**: Document schema changes in CHANGELOG
3. **Team Training**: Ensure team uses consistent patterns
4. **Regular Updates**: Review and update descriptions quarterly

## Sample Query After Improvements

With these improvements, LLMs will correctly construct queries like:

```json
{
  "explore": "pixel_joined",
  "metrics": ["roas_excluding_blended", "total_attributed_purchases"],
  "group_by": ["event_date"],
  "filters": [
    {"field": "channel", "operator": "equals", "value": "facebook"},
    {"field": "model", "operator": "equals", "value": "last_click"},
    {"field": "attribution_window", "operator": "equals", "value": "7_day"},
    {"field": "event_date", "operator": "inThePast", "value": 30, "unit": "days"}
  ],
  "order_by": [{"field": "event_date", "order": "desc"}],
  "limit": 30
}
```

This will correctly return Facebook ROAS with proper attribution filtering!
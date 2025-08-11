# Phase 3: Tool Prompt Analysis

## Current State Assessment

### Tools with Good Structure (but need JSON examples):
1. **run_metric_query.md** - Has detailed examples but in narrative format
2. **create_chart.md** - Has scenarios but needs pure JSON
3. **edit_dashboard.md** - Has natural language examples only

### Tools Needing Major Enhancement:
1. **get_explore.md** - Only natural language examples
2. **list_charts.md** - Likely minimal examples
3. **create_dashboard.md** - Needs structure examples
4. **get_chart.md** - Single parameter but needs format
5. **delete_chart.md** - Needs confirmation parameter example
6. **edit_chart.md** - Needs to show metadata-only limitation

### Priority Order for Updates:

#### High Priority (Complex tools LLMs struggle with):
1. **edit_dashboard.md** - Multiple optional parameters, complex structure
2. **run_metric_query.md** - Complex query building
3. **create_chart.md** - Many parameters
4. **create_dashboard.md** - Tiles structure

#### Medium Priority (Moderate complexity):
1. **list_charts.md** - Optional filtering
2. **edit_chart.md** - Show limitations clearly
3. **get_explore.md** - Single param but important
4. **list_metrics_enhanced.md** - Filtering options

#### Low Priority (Simple tools):
1. **get_chart.md** - Single parameter
2. **delete_chart.md** - Simple confirmation
3. **list_spaces.md** - No parameters
4. **get_user.md** - No parameters

## Standardized Template Structure

```markdown
# Tool Name: [tool_name]

## Description
[Brief one-line description]

## When to Use
- [Specific use case 1]
- [Specific use case 2]
- [Specific use case 3]

## Parameters

### Required:
- `param_name` (type): Description

### Optional:
- `param_name` (type): Description with default

## JSON Examples

### Example 1: [Simple case name]
```json
{
  "param": "value"
}
```

### Example 2: [Medium complexity case]
```json
{
  "param1": "value",
  "param2": ["array", "values"]
}
```

### Example 3: [Complex case]
```json
{
  "param1": "value",
  "param2": {
    "nested": "object"
  }
}
```

## Common Mistakes to Avoid
- ❌ [Common error 1]
- ❌ [Common error 2]
- ✅ [Correct approach]

## Related Tools
- `tool_name` - When to use instead
- `tool_name` - Complementary tool
```

## Implementation Plan

### Step 1: Create template file
- Save standardized template for consistency

### Step 2: Update high-priority tools first
- Start with edit_dashboard.md as it's most complex
- Test with LLM after each update

### Step 3: Batch update remaining tools
- Group by similarity
- Maintain consistency

### Step 4: Validate improvements
- Test each tool with LLM
- Document success rate improvements
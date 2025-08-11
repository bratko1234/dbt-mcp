# Phase 3: Complete Tool Audit

## Tools and Their Prompt Status

### ✅ Already Updated (Following Best Practices):
1. `lightdash_edit_dashboard` - Complete with 7 JSON examples
2. `lightdash_get_explore` - Complete with 3 JSON examples  
3. `lightdash_run_metric_query` - Complete with 5 JSON examples

### 🔄 Has Prompt But Needs JSON Examples:
1. `lightdash_create_chart` - Has narrative examples, needs JSON
2. `lightdash_create_dashboard` - Needs structure examples
3. `lightdash_delete_chart` - Needs confirmation parameter example
4. `lightdash_delete_dashboard` - Needs confirmation parameter example
5. `lightdash_edit_chart` - Needs to show metadata-only limitation
6. `lightdash_get_chart` - Single parameter, needs format
7. `lightdash_get_dashboard` - Single parameter, needs format
8. `lightdash_list_charts` - Needs filtering examples
9. `lightdash_list_dashboards` - Needs filtering examples
10. `lightdash_list_explores` - No parameters, needs example
11. `lightdash_list_spaces` - No parameters, needs example
12. `lightdash_get_user` - No parameters, needs example
13. `lightdash_list_metrics_enhanced` - Has prompt, needs JSON examples

### ❌ Missing Prompt File:
1. `lightdash_get_embed_url` - No prompt file found!

## Action Plan

### Step 1: Create Missing Prompt
- Create `get_embed_url.md` with proper JSON examples

### Step 2: Update High Priority Tools (Complex ones)
- `create_chart.md` - Many parameters
- `create_dashboard.md` - Tiles structure
- `edit_chart.md` - Show limitations clearly

### Step 3: Update Medium Priority Tools
- `list_charts.md` - Optional filtering
- `list_dashboards.md` - Optional filtering
- `delete_chart.md` - Confirmation parameter
- `delete_dashboard.md` - Confirmation parameter

### Step 4: Update Simple Tools
- `get_chart.md` - Single parameter
- `get_dashboard.md` - Single parameter
- `list_explores.md` - No parameters
- `list_spaces.md` - No parameters
- `get_user.md` - No parameters

### Step 5: Special Cases
- `list_metrics_enhanced.md` - Complex tool, needs careful examples
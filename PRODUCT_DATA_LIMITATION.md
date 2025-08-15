# Product Data Limitation in Current Implementation

## The Problem
The current `orders` model in your dbt schema stores product information at the ORDER level, not the PRODUCT level. This means:

1. **Concatenated Products**: The `line_items_titles` field contains comma-separated product names like:
   - "Product A,Product B,Product C" (all in one field)
   
2. **No Individual Product Rows**: You can't properly analyze:
   - Individual product sales
   - Product-level quantities
   - Product performance metrics

3. **Query Results**: When you ask "what did we sell?", you get:
   - Order-level combinations of products
   - Total revenue for those combinations
   - 0 quantities (because `product_quantity_sold` is likely not properly aggregated)

## Current Workaround
The semantic catalog (v0.9.3) now:
- Recognizes product-related questions
- Uses `line_items_titles` dimension
- Includes both product and time dimensions when needed
- Returns order-level product combinations

## Proper Solution Needed
To properly answer "what products did we sell?", you need to:

### Option 1: Create a `line_items` model in dbt
```sql
-- models/line_items.sql
WITH split_items AS (
  SELECT 
    order_id,
    customer_id,
    event_date,
    platform,
    -- Split the comma-separated values
    SPLIT(line_items_titles, ',') as titles_array,
    SPLIT(line_items_skus, ',') as skus_array,
    -- Divide totals by number of items (rough approximation)
    net_revenue / ARRAY_LENGTH(SPLIT(line_items_titles, ',')) as item_revenue,
    product_quantity_sold as total_quantity
  FROM {{ ref('orders') }}
)
SELECT 
  order_id,
  customer_id,
  event_date,
  platform,
  TRIM(title) as product_title,
  TRIM(sku) as product_sku,
  item_revenue,
  1 as quantity -- Assuming 1 of each unless you have better data
FROM split_items
CROSS JOIN UNNEST(titles_array) AS title WITH OFFSET AS pos
LEFT JOIN UNNEST(skus_array) AS sku WITH OFFSET AS sku_pos
  ON pos = sku_pos
```

### Option 2: Use a different data source
If you have access to the raw Shopify line_items table, use that instead.

### Option 3: Modify the ETL pipeline
Update your data pipeline to create a proper normalized line_items table.

## Impact on Queries
Until this is fixed:
- "What did we sell?" returns order-level product combinations
- Product quantities may show as 0
- You can't get clean "top 10 products" lists
- Revenue is at the order level, not product level

## Temporary Usage
For now, when asking about products:
- "product sales last 7 days" - gives you order combinations with products
- "sales by platform" - gives you platform-level sales (works fine)
- "revenue last 7 days" - gives you daily revenue (works fine)

The tool correctly identifies product questions but is limited by the underlying data structure.
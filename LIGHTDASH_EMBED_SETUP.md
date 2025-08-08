# Lightdash/Bratrax Embedding Setup Guide

## Overview
This guide explains how to configure Lightdash/Bratrax to allow embedding charts and dashboards in LibreChat.

## 1. Configure CORS in Lightdash/Bratrax

### Frontend Configuration (vite.config.ts)
Add LibreChat domain to allowedHosts in `/packages/frontend/vite.config.ts`:

```typescript
server: {
    allowedHosts: [
        'lightdash-dev',
        '.lightdash.dev', 
        'host.docker.internal',
        'localhost:3000',        // Add this for local LibreChat
        'your-librechat-domain.com'  // Add your production domain
    ],
}
```

### Backend Configuration (App.ts)
Ensure CORS is properly configured in `/packages/backend/src/App.ts`:

```typescript
// In your Lightdash configuration
security: {
    crossOriginResourceSharingPolicy: {
        allowedDomains: [
            'http://localhost:3000',     // LibreChat local
            'https://your-librechat-domain.com'  // Production
        ]
    }
}
```

## 2. Environment Variables

Ensure your MCP server has the correct Lightdash configuration:

```bash
# In your .env or librechat.yaml
LIGHTDASH_API_URL=http://localhost:3000/api/v1
LIGHTDASH_API_KEY=your_api_key
LIGHTDASH_PROJECT_ID=your_project_id
LIGHTDASH_DEFAULT_SPACE_ID=your_space_id
```

## 3. Testing the Integration

### Step 1: Test Embed API Directly
```bash
# Get an embed URL using curl
curl -X POST http://localhost:3000/api/v1/projects/{project_id}/embed/get-embed-url \
  -H "Authorization: ApiKey your_api_key" \
  -H "Content-Type: application/json" \
  -d '{
    "content": {
      "type": "chart",
      "uuid": "your-chart-uuid"
    },
    "expiresIn": "1h"
  }'
```

### Step 2: Test in Browser
1. Copy the embed URL from the response
2. Open it in a browser to ensure it loads
3. Check browser console for CORS errors

### Step 3: Test Through MCP
In LibreChat, try:
```
Can you show me the [chart name] chart?
```

The MCP server should:
1. Find the chart
2. Generate an embed URL
3. Return markdown with the embed directive
4. LibreChat should render the iframe

## 4. Troubleshooting

### CORS Errors
If you see CORS errors in the browser console:
1. Check that LibreChat's domain is in Lightdash's allowedHosts
2. Verify the CORS configuration in Lightdash backend
3. Ensure you're using the correct protocol (http vs https)

### Authentication Errors
If embed URLs return 401/403:
1. Verify the API key is correct
2. Check that the project/chart exists
3. Ensure the API key has permission to create embed URLs

### Iframe Not Loading
If the iframe appears but content doesn't load:
1. Check browser developer tools for errors
2. Verify the embed URL hasn't expired
3. Test the URL directly in a new tab

## 5. Security Considerations

1. **Token Expiration**: Set appropriate expiration times (8h recommended)
2. **HTTPS**: Use HTTPS in production for both LibreChat and Lightdash
3. **API Key Security**: Keep API keys secure and rotate regularly
4. **Row-Level Security**: Configure user attributes in embed tokens if needed

## 6. Example Workflow

1. User asks: "Show me the revenue dashboard for last month"
2. MCP finds dashboard UUID
3. MCP generates embed URL with 8h expiration
4. MCP returns: `:::lightdash-dashboard{url="..." title="Revenue Dashboard" height="600"}`
5. LibreChat renders the LightdashVisualization component
6. Dashboard appears inline in the chat

## Next Steps

After configuration:
1. Test with a simple chart first
2. Try dashboard embedding
3. Test filter interactivity
4. Verify mobile responsiveness
5. Monitor token expiration and refresh needs
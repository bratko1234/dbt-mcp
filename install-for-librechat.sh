#!/bin/bash
# Installation script for LibreChat

# Create virtual environment
python -m venv venv
source venv/bin/activate

# Install from PyPI (once published)
# pip install dbt-mcp-lightdash

# Or install from local directory
pip install -e .

# Create wrapper script
cat > run-dbt-mcp.sh << 'EOF'
#!/bin/bash
source venv/bin/activate
exec dbt-mcp "$@"
EOF

chmod +x run-dbt-mcp.sh

echo "Installation complete!"
echo "Use ./run-dbt-mcp.sh to run the server"
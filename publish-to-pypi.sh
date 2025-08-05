#!/bin/bash
set -e

echo "🚀 Publishing dbt-mcp-lightdash to PyPI"

# Check if we're in the right directory
if [ ! -f "pyproject.toml" ]; then
    echo "❌ Error: pyproject.toml not found. Are you in the project root?"
    exit 1
fi

# Clean previous builds
echo "🧹 Cleaning previous builds..."
rm -rf dist/ build/ *.egg-info

# Install/upgrade build tools
echo "📦 Installing build tools..."
pip install --upgrade build twine

# Build the package
echo "🔨 Building package..."
python -m build

# Check the build
echo "✅ Checking package..."
twine check dist/*

# Test upload (optional)
read -p "Upload to TestPyPI first? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "📤 Uploading to TestPyPI..."
    twine upload --repository testpypi dist/*
    echo "✅ Test upload complete!"
    echo "Test install with: pip install -i https://test.pypi.org/simple/ dbt-mcp-lightdash"
    read -p "Continue to production PyPI? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 0
    fi
fi

# Production upload
echo "📤 Uploading to PyPI..."
twine upload dist/*

echo "✅ Successfully published!"
echo "Install with: pip install dbt-mcp-lightdash"
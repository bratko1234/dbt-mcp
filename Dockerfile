FROM python:3.12-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    gcc \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# Create app directory
WORKDIR /app

# Copy pyproject.toml first for better caching
COPY pyproject.toml ./
COPY README.md ./
COPY LICENSE ./

# Copy source code
COPY src/ ./src/

# Install the package
RUN pip install --no-cache-dir -e .

# Set the entrypoint
ENTRYPOINT ["dbt-mcp"]
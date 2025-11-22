#!/bin/bash
set -e

echo "🚀 Setting up AI Chat environment with MCP servers..."

# Install uv for Python package management
echo "📦 Installing uv..."
curl -LsSf https://astral.sh/uv/install.sh | sh
export PATH="$HOME/.cargo/bin:$PATH"

# Install Python dependencies
echo "📦 Installing Python dependencies..."
pip install --upgrade pip
pip install anthropic openai python-dotenv jupyter notebook ipykernel

# Clone and setup PubMed MCP server
echo "📚 Setting up PubMed MCP server..."
if [ ! -d "mcp-servers/pubmearch" ]; then
    mkdir -p mcp-servers
    cd mcp-servers
    git clone https://github.com/darkroaster/pubmearch.git
    cd pubmearch
    uv venv
    source .venv/bin/activate
    uv pip install -e .
    deactivate
    cd ../..
fi

# Clone and setup OpenFDA MCP server
echo "🏥 Setting up OpenFDA MCP server..."
if [ ! -d "mcp-servers/OpenFDA-MCP-Server" ]; then
    mkdir -p mcp-servers
    cd mcp-servers
    git clone https://github.com/Augmented-Nature/OpenFDA-MCP-Server.git
    cd OpenFDA-MCP-Server
    npm install
    npm run build
    cd ../..
fi

# Create directories for outputs
echo "📁 Creating output directories..."
mkdir -p outputs/pubmed
mkdir -p outputs/fda
mkdir -p notebooks

# Setup .env file if it doesn't exist
if [ ! -f .env ]; then
    echo "📝 Creating .env template..."
    cat > .env << 'EOF'
# PubMed API Configuration
# Get your API key from: https://www.ncbi.nlm.nih.gov/account/settings/
NCBI_USER_EMAIL=your_email@example.com
NCBI_USER_API_KEY=your_pubmed_api_key_here

# FDA API Configuration (Optional - for higher rate limits)
# Get your API key from: https://open.fda.gov/apis/authentication/
FDA_API_KEY=your_fda_api_key_here
EOF
    echo "⚠️  Please update .env with your API keys!"
fi

# Create MCP configuration
echo "⚙️  Creating MCP configuration..."
cat > .mcp.json << 'EOF'
{
  "mcpServers": {
    "pubmearch": {
      "command": "bash",
      "args": [
        "-c",
        "source mcp-servers/pubmearch/.venv/bin/activate && python -m pubmearch.server"
      ],
      "env": {
        "NCBI_USER_EMAIL": "${NCBI_USER_EMAIL}",
        "NCBI_USER_API_KEY": "${NCBI_USER_API_KEY}"
      }
    },
    "openfda": {
      "command": "node",
      "args": [
        "mcp-servers/OpenFDA-MCP-Server/build/index.js"
      ],
      "env": {
        "FDA_API_KEY": "${FDA_API_KEY}"
      }
    }
  }
}
EOF

echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "1. Update .env with your API keys"
echo "2. Restart the Codespace to load environment variables"
echo "3. Open GitHub Copilot Chat and start asking questions about PubMed or FDA data!"
echo ""
echo "Example queries:"
echo "  - 'Search PubMed for recent studies on cancer immunotherapy'"
echo "  - 'Find FDA adverse events for aspirin in 2023'"

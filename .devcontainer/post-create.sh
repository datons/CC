#!/bin/bash
set -e

echo "🚀 Setting up AI Chat environment with MCP servers..."

# Install uv for Python package management
echo "📦 Installing uv..."
curl -LsSf https://astral.sh/uv/install.sh | sh
export PATH="$HOME/.cargo/bin:$PATH"

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

echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "1. Copy .env.example to .env and add your API keys"
echo "2. Add MCP servers manually using VS Code (see README.md)"
echo "3. Restart the Codespace to load environment variables"
echo "4. Open GitHub Copilot Chat and start asking questions about PubMed or FDA data!"
echo ""
echo "Example queries:"
echo "  - 'Search PubMed for recent studies on cancer immunotherapy'"
echo "  - 'Find FDA adverse events for aspirin in 2023'"

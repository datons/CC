# AI Chat with Medical Data MCP Servers

Learn to interact with AI assistants using real-world medical and pharmaceutical data through Model Context Protocol (MCP) servers.

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/datons/CC)

## What You'll Learn

1. **Interact with AI Chat in VSCode** - Use GitHub Copilot Chat with specialized MCP servers
2. **Query PubMed** - Search and analyze medical literature using natural language
3. **Access FDA Data** - Query drug information, adverse events, recalls, and medical device data

## Quick Start

### 1. Launch in Codespaces

Click the "Open in GitHub Codespaces" button above or:

1. Fork this repository
2. Click the green "Code" button
3. Select "Create codespace on main"

The environment will automatically set up with:
- Python 3.11
- Node.js 20
- GitHub Copilot extensions
- Both MCP servers (PubMed and OpenFDA)

### 2. Configure API Keys

After the Codespace launches:

1. Copy the example environment file:
   ```bash
   cp .env.example .env
   ```

2. Edit `.env` and add your API keys:
   ```bash
   # PubMed API (Required)
   NCBI_USER_EMAIL=your_email@example.com
   NCBI_USER_API_KEY=your_api_key

   # FDA API (Optional - higher rate limits)
   FDA_API_KEY=your_fda_api_key
   ```

#### Getting API Keys

**PubMed API Key** (Required for PubMed queries):
1. Go to [NCBI Account Settings](https://www.ncbi.nlm.nih.gov/account/settings/)
2. Log in or create an account
3. Scroll to "API Keys" section
4. Click "Create API Key"

**FDA API Key** (Optional - increases rate limit):
1. Visit [openFDA Authentication](https://open.fda.gov/apis/authentication/)
2. Sign up for an API key
3. Without key: 1,000 requests/hour
4. With key: 120,000 requests/hour

### 3. Restart Codespace

After adding your API keys:
1. Click the gear icon in the bottom left
2. Select "Codespaces: Rebuild Container"

This ensures environment variables are loaded.

#### Alternative: Where to put PubMed (NCBI) and FDA credentials

You can provide PubMed (NCBI) and OpenFDA credentials in any of the following ways.

- **Temporary (current shell session):**
   ```bash
   export NCBI_USER_EMAIL="your.email@example.com"
   export NCBI_USER_API_KEY="your_ncbi_api_key"
   export FDA_API_KEY="your_fda_api_key"
   ```

- **Project `.env` (recommended for reproducible Codespaces):**
   Add the variables to a `.env` file (either at the repository root or the server subfolder):
   ```env
   NCBI_USER_EMAIL="your.email@example.com"
   NCBI_USER_API_KEY="your_ncbi_api_key"
   FDA_API_KEY="your_fda_api_key"
   ```

- **VS Code MCP server config (`.vscode/mcp.json`):**
   Inject the variables into the server `env` block for the appropriate server. Examples:
   ```jsonc
   // PubMed server entry
   "pubmed": {
      "env": {
         "NCBI_USER_EMAIL": "YOUR_NCBI_EMAIL",
         "NCBI_USER_API_KEY": "YOUR_NCBI_API_KEY"
      }
   }

   // OpenFDA server entry
   "openfda": {
      "env": {
         "FDA_API_KEY": "YOUR_FDA_API_KEY"
      }
   }
   ```

Notes:
- The PubMed MCP server requires a contact email (`NCBI_USER_EMAIL`) — NCBI requests a valid email address for API usage.
- `FDA_API_KEY` is optional for basic queries but increases rate limits when provided.
- Avoid committing long-lived keys to public repos; prefer workspace-only secrets or secret managers for shared projects.
- After changing env vars in `.vscode/mcp.json` or a `.env` file, restart the MCP server or reload the VS Code window so the changes are picked up.

### 4. Start Using AI Chat

Open GitHub Copilot Chat (Ctrl+Shift+I or Cmd+Shift+I) and try these queries:

**PubMed Examples:**
```
Search PubMed for recent studies on cancer immunotherapy from the last 3 months
```

```
Analyze research hotspots in prostate cancer treatment. Use the search query:
((prostat*[Title/Abstract]) AND (cancer[Title/Abstract]))
```

```
Show me publication trends for CRISPR gene editing over the past year
```

**FDA Examples:**
```
Find adverse events reported for aspirin in 2023
```

```
Search for drug recalls related to contamination in the last 6 months
```

```
Look up labeling information for diabetes medications manufactured by Novo Nordisk
```

```
Find all FDA-approved drugs for hypertension
```

**Referencing MCP tools in chat**

You can hint or instruct the assistant to use a specific MCP server or its tools by prefixing the server short name with a hash (`#`) anywhere in your message. Examples:

- `#pubmed` — ask the assistant to use PubMed MCP tools for searches and analysis.
- `#openfda` — ask the assistant to use OpenFDA MCP tools for FDA data.

Placing the tag at the start of your message (for example, `#pubmed Search for recent CRISPR publications`) makes the intent explicit, but it also works anywhere in the text.


## MCP Servers Included

**Adding MCP Servers in VS Code**

Follow these steps to register the included MCP servers with your editor so GitHub Copilot Chat (or other MCP-capable extensions) can communicate with them:

1. **Open Command Palette:** Press `Ctrl+Shift+P` (Windows/Linux) or `Cmd+Shift+P` (macOS).
2. **Run Add MCP Server:** Type `MCP: Add MCP Server` (or `Add MCP Server`) and select the command.
3. **Choose Connection Type:** When prompted for the connection, choose `stdio`.
e. **Provide Command:** When prompted for the command to launch the server, paste the following pattern, replacing `{path}` with the full path to the server start script or entry point:
5. **Select Target:** When prompted for the target/where to register the server, choose **`Workspace`** so the server is registered for this repository.

    ```bash
    bash -c "{path}"
    ```

    Examples:

   - PubMed (Python, using virtualenv):
      ```bash
      bash -c "source /workspaces/CC/mcp-servers/pubmearch/.venv/bin/activate && python -m pubmearch.server"
      ```

    - OpenFDA (Node):
       ```bash
       bash -c "node /workspaces/CC/mcp-servers/OpenFDA-MCP-Server/build/index.js"
       ```

Notes:
- Use the full absolute path to the server launcher so the editor can start it reliably.
- Ensure required runtimes are installed in your environment (`python3` for PubMed, `node` for OpenFDA) and any dependencies are installed.
- After adding the server, reload the VS Code window (Command Palette → `Developer: Reload Window`) if the MCP server does not appear immediately.

### 1. PubMed MCP Server
Query and analyze medical literature from PubMed.

**Features:**
- Literature search with advanced syntax
- Research hotspot analysis
- Trend tracking over time
- Publication count statistics
- Comprehensive reports

**Tools Available:**
- `search_pubmed` - Search PubMed database
- `analyze_research_keywords` - Identify research hotspots
- `analyze_publication_count` - Track publication trends
- `generate_comprehensive_analysis` - Full analysis reports

### 2. OpenFDA MCP Server
Access FDA databases for drugs and medical devices.

**Features:**
- Drug adverse event reports (FAERS)
- Drug labeling information
- Drug recalls and shortages
- FDA-approved drugs database
- Medical device data (510k, classifications, adverse events)

**Tools Available:**
- `search_drug_adverse_events` - FAERS data
- `search_drug_labels` - Product labeling
- `search_drug_ndc` - National Drug Code directory
- `search_drug_recalls` - Recall enforcement
- `search_drugs_fda` - FDA-approved drugs
- `search_drug_shortages` - Current shortages
- `search_device_510k` - Device clearances
- `search_device_adverse_events` - Device adverse events

## Project Structure

```
.
├── .devcontainer/          # Codespaces configuration
│   ├── devcontainer.json   # Container settings
│   └── post-create.sh      # Setup script
├── mcp-servers/            # MCP server installations (auto-generated)
│   ├── pubmearch/          # PubMed MCP server
│   └── OpenFDA-MCP-Server/ # FDA MCP server
├── outputs/                # Query results and reports
├── notebooks/              # Jupyter notebooks for analysis
├── .env.example            # API key template
└── README.md               # This file
```

## Advanced Usage

### Using PubMed Advanced Search Syntax

PubMed supports advanced search queries:

```
# Search in specific fields
diabetes[Title/Abstract]

# Combine terms
(prostat*[Title/Abstract]) AND (cancer[Title/Abstract]) AND (immuno*[Title/Abstract])

# Date ranges
cancer[Title] AND ("2023/01/01"[PDAT] : "2023/12/31"[PDAT])
```

### Filtering FDA Queries

FDA queries support detailed filtering:

```
Find drug adverse events for:
- Drug: aspirin
- Country: United States
- Date range: 2023-01-01 to 2023-12-31
- Serious events only: true
```

### Generating Reports

Both MCP servers can generate comprehensive analysis reports:

```
Generate a comprehensive analysis of COVID-19 vaccine research from the past 6 months
```

## Troubleshooting

### API Key Issues

**Problem:** "Authentication failed" or "Rate limit exceeded"

**Solution:**
1. Verify `.env` file contains correct API keys
2. Rebuild the container (Codespaces: Rebuild Container)
3. For PubMed, ensure email and API key are both set

### MCP Server Not Responding

**Problem:** Chat doesn't recognize PubMed/FDA queries

**Solution:**
1. Check `.mcp.json` exists in workspace root
2. Restart VSCode window (Cmd/Ctrl+Shift+P → "Reload Window")
3. Check the post-create script ran successfully:
   ```bash
   ls -la mcp-servers/
   ```

### Import Errors

**Problem:** Python modules not found

**Solution:**
```bash
pip install anthropic openai python-dotenv
```

## Learning Resources

- [Model Context Protocol Documentation](https://modelcontextprotocol.io/)
- [PubMed Search Tips](https://pubmed.ncbi.nlm.nih.gov/help/)
- [OpenFDA API Documentation](https://open.fda.gov/apis/)
- [GitHub Copilot Chat Documentation](https://docs.github.com/en/copilot/using-github-copilot/asking-github-copilot-questions-in-your-ide)

## Credits

- **PubMed MCP Server:** [darkroaster/pubmearch](https://github.com/darkroaster/pubmearch)
- **OpenFDA MCP Server:** [Augmented-Nature/OpenFDA-MCP-Server](https://github.com/Augmented-Nature/OpenFDA-MCP-Server)

## License

This educational project is provided as-is for learning purposes.

---

**Note:** This tool provides access to public medical datasets. Always consult healthcare professionals for medical decisions and drug information.

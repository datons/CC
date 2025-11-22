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

### 2. Add MCP Servers

After the Codespace launches, add the MCP servers through VS Code:

1. **Open Command Palette:** Press `Ctrl+Shift+P` (Windows/Linux) or `Cmd+Shift+P` (macOS)
2. **Run Add MCP Server:** Type `MCP: Add MCP Server` and select the command
3. **Choose Connection Type:** Select `stdio`
4. **Add PubMed Server:**
   - Command: `bash`
   - Args: `-c "source /workspaces/CC/mcp-servers/pubmearch/.venv/bin/activate && python -m pubmearch.server"`
   - Target: **Workspace**

5. **Add OpenFDA Server:**
   - Command: `bash`
   - Args: `-c "node /workspaces/CC/mcp-servers/OpenFDA-MCP-Server/build/index.js"`
   - Target: **Workspace**

### 3. Configure API Keys

After adding the servers, edit `.vscode/mcp.json` to add your API keys:

#### Getting API Keys

**PubMed API Key** (Required):
1. Go to [NCBI Account Settings](https://www.ncbi.nlm.nih.gov/account/settings/)
2. Log in or create an account
3. Scroll to "API Keys" section
4. Click "Create API Key"

**FDA API Key** (Optional - increases rate limit from 1,000 to 120,000 requests/hour):
1. Visit [openFDA Authentication](https://open.fda.gov/apis/authentication/)
2. Sign up for an API key

#### Add Keys to `.vscode/mcp.json`

Edit `.vscode/mcp.json` and add your keys to the `env` section of each server:

```json
{
  "servers": {
    "pubmed": {
      "type": "stdio",
      "command": "bash",
      "args": [
        "-c",
        "source /workspaces/CC/mcp-servers/pubmearch/.venv/bin/activate && python -m pubmearch.server"
      ],
      "env": {
        "NCBI_USER_EMAIL": "your_email@example.com",
        "NCBI_USER_API_KEY": "your_pubmed_api_key"
      }
    },
    "openfda": {
      "type": "stdio",
      "command": "bash",
      "args": [
        "-c",
        "node /workspaces/CC/mcp-servers/OpenFDA-MCP-Server/build/index.js"
      ],
      "env": {
        "FDA_API_KEY": "your_fda_api_key"
      }
    }
  }
}
```

**Note:** The PubMed server requires both `NCBI_USER_EMAIL` and `NCBI_USER_API_KEY`. The FDA API key is optional.

### 4. Start Using AI Chat

Open GitHub Copilot Chat (Ctrl+Shift+I or Cmd+Shift+I) and try these example prompts.

**Tip:** Use `#pubmed` or `#openfda` at the start of your message to tell the AI which MCP server to use.

#### PubMed Research Examples

```
#pubmed Find recent studies about diabetes treatment
```

```
#pubmed What are the latest papers on Alzheimer's disease?
```

```
#pubmed Show me research trends for COVID-19 vaccines
```

```
#pubmed Search for studies about heart disease prevention published in the last year
```

```
#pubmed Find papers about cancer immunotherapy from 2024
```

```
#pubmed What's the latest research on obesity and mental health?
```

```
#pubmed Search for studies comparing different diabetes medications
```

```
#pubmed Find research about sleep disorders and their treatments
```

#### FDA Drug & Device Examples

```
#openfda Find side effects reported for ibuprofen
```

```
#openfda What adverse events have been reported for insulin?
```

```
#openfda Show me recent drug recalls
```

```
#openfda Find all FDA-approved medications for high blood pressure
```

```
#openfda What drugs were recalled due to contamination?
```

```
#openfda Search for adverse events related to pacemakers
```

```
#openfda Find information about diabetes medications made by Novo Nordisk
```

```
#openfda What are the reported side effects of aspirin?
```

```
#openfda Show me drug shortages for antibiotics
```

```
#openfda Find recalls of medical devices in the last 6 months
```


## MCP Servers Included

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
├── .vscode/
│   └── mcp.json            # MCP server configuration (you create this)
├── mcp-servers/            # MCP server installations (auto-generated)
│   ├── pubmearch/          # PubMed MCP server
│   └── OpenFDA-MCP-Server/ # FDA MCP server
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
1. Verify `.vscode/mcp.json` contains correct API keys in the `env` section
2. For PubMed, ensure both `NCBI_USER_EMAIL` and `NCBI_USER_API_KEY` are set
3. Save the file - changes take effect immediately

### MCP Server Not Responding

**Problem:** Chat doesn't recognize PubMed/FDA queries

**Solution:**
1. Check `.vscode/mcp.json` exists and has both servers configured
2. Verify the MCP servers were installed:
   ```bash
   ls -la mcp-servers/
   ```
3. Try using the `#pubmed` or `#openfda` prefix in your message

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

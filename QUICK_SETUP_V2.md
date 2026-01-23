# NenAI MCP Quick Setup

Three ways to get started with NenAI MCP in Cursor. Choose the method that works best for you.

---

## Method 1: Interactive Setup (Recommended) ⚡

The easiest way to get started with guided prompts.

```bash
git clone https://github.com/getnenai/mcp-quickstart.git
cd mcp-quickstart
bash setup-interactive.sh
```

The script will:
- ✅ Prompt for your API key and MCP URL
- ✅ Generate a one-click install link
- ✅ Optionally open Cursor automatically
- ✅ Show you the environment variables to set

---

## Method 2: One-Click Install 🚀

If you already have your credentials, use the web generator.

### Step 1: Generate Install Link

Open `generate-install-link.html` in your browser:

```bash
open generate-install-link.html  # macOS
# or
xdg-open generate-install-link.html  # Linux
```

### Step 2: Enter Credentials

1. Enter your **API Key** (from your NenAI customer engineer)
2. Enter your **MCP Server URL** (from your NenAI customer engineer)
3. Click **Generate Install Link**

### Step 3: Set Environment Variables

Add to `~/.zshrc` or `~/.bashrc`:

```bash
export NEN_API_KEY="your_api_key_here"
export NEN_MCP_URL="your_mcp_url_here"
```

Then reload:

```bash
source ~/.zshrc  # or ~/.bashrc
```

### Step 4: Install in Cursor

Click the **"Open in Cursor"** button or paste the generated link in your browser.

### Step 5: Restart Cursor

Completely quit (⌘Q or Ctrl+Q) and reopen Cursor.

---

## Method 3: Manual Setup 🔧

For users who prefer full control.

### Step 1: Clone Repository

```bash
git clone https://github.com/getnenai/mcp-quickstart.git
cd mcp-quickstart
```

### Step 2: Set Environment Variables

Add to `~/.zshrc` or `~/.bashrc`:

```bash
export NEN_API_KEY="your_api_key_here"
export NEN_MCP_URL="your_mcp_url_here"
```

Get these from your NenAI customer engineer.

Reload your shell:

```bash
source ~/.zshrc  # or ~/.bashrc
```

### Step 3: Configure Cursor

Run the setup script:

```bash
bash setup-remote-mcp.sh
```

Or manually create `~/.cursor/mcp.json`:

```json
{
  "mcpServers": {
    "nenai": {
      "url": "${env:NEN_MCP_URL}",
      "headers": {
        "X-Api-Key": "${env:NEN_API_KEY}"
      }
    }
  }
}
```

### Step 4: Restart Cursor

Completely quit (⌘Q or Ctrl+Q) and reopen Cursor.

---

## Verification ✅

Ask the AI agent in Cursor:

> "Use nen_list_workflows to verify the MCP server is working"

You should see the MCP tools responding with your available workflows!

---

## Comparison of Methods

| Method | Pros | Cons | Best For |
|--------|------|------|----------|
| **Interactive** | Guided, automatic, beginner-friendly | Requires bash | First-time users |
| **One-Click** | Fast, visual, modern | Need web browser | Quick setup |
| **Manual** | Full control, transparent | More steps | Advanced users |

---

## Troubleshooting

### MCP tools not showing up

1. Ensure environment variables are set **before** launching Cursor
2. Restart your terminal after setting env vars
3. Completely quit Cursor (⌘Q / Ctrl+Q, not just reload)
4. Check `~/.cursor/mcp.json` exists and is valid JSON

### 401 Unauthorized

1. Verify your `NEN_API_KEY` is correct
2. Contact your NenAI customer engineer to verify key validity
3. Ensure Cursor can read the environment variables

### Environment variables not loading

**macOS/Linux:**
- Add to `~/.zshrc` (zsh) or `~/.bashrc` (bash)
- Restart terminal completely
- Launch Cursor from terminal: `open -a Cursor` (macOS)

**Important:** Cursor must be launched from an environment where the variables are set.

---

## Next Steps

### Create Your First Workflow

Ask the AI agent:

```
Create a workflow that navigates to google.com and takes a screenshot
```

The AI will:
1. Use `nen_create_workflow` to generate FSM files
2. Upload to the platform with `nen_upload`
3. Run the workflow with `nen_run`
4. Show you the results!

### Explore Sample Workflows

Check out `workflows/samples/` for examples:
- **website-login**: Navigate and log in to websites
- **get-appointments**: Extract data from web applications
- **download-documents**: Automate file downloads

### Learn FSM Authoring

Read `.cursorrules` to understand how to create sophisticated workflows with:
- State machines (LLMState, ToolState, VerificationState)
- Variables and templates
- Failure recovery
- Browser automation patterns

---

## Available MCP Tools

| Tool | Purpose |
|------|---------|
| `nen_create_workflow` | Generate FSM workflow files from natural language |
| `nen_upload` | Deploy workflow to NenAI platform |
| `nen_run` | Execute a workflow |
| `nen_status` | Check run status |
| `nen_artifacts` | Download recordings and logs |
| `nen_list_runs` | List run history |
| `nen_list_workflows` | List all workflows |
| `nen_list_deployments` | List available deployments |

See [TOOLS_REFERENCE.md](TOOLS_REFERENCE.md) for detailed documentation.

---

## Getting Help

**Need your API key?** Contact your NenAI customer engineer.

**Having issues?** Check [TROUBLESHOOTING.md](TROUBLESHOOTING.md) for detailed solutions.

**Want to contribute?** See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

---

**Happy automating! 🎉**

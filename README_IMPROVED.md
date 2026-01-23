# NenAI MCP Quickstart

[![Install MCP](.github/install-button.svg)](#quick-install)

Build computer use automations using natural language in Cursor. Author, test, and run browser automation workflows directly from your IDE.

---

## 🚀 Quick Install

**3 ways to get started** - choose what works best for you:

### Method 1: Interactive Setup (Recommended)

```bash
git clone https://github.com/getnenai/mcp-quickstart.git
cd mcp-quickstart
bash setup-interactive.sh
```

Guided setup with automatic configuration. Perfect for first-time users.

### Method 2: One-Click Install

1. Open `generate-install-link.html` in your browser
2. Enter your credentials (API key + MCP URL)
3. Click the generated link to install in Cursor

Modern, visual setup experience.

### Method 3: Manual Setup

```bash
# 1. Set environment variables
export NEN_API_KEY="your_api_key_here"
export NEN_MCP_URL="your_remote_mcp_url_here"

# 2. Configure Cursor
bash setup-remote-mcp.sh

# 3. Restart Cursor
```

Full control for advanced users.

> **Get credentials:** Contact your NenAI customer engineer for `NEN_API_KEY` and `NEN_MCP_URL`

📖 **Detailed setup instructions:** See [QUICK_SETUP_V2.md](QUICK_SETUP_V2.md)

---

## ✅ Verify Installation

After setup, ask your AI agent:

```
Use nen_list_workflows to verify the MCP server is working
```

---

## 🎯 Your First Workflow

Create a workflow with natural language:

```
Create a workflow that navigates to google.com and takes a screenshot
```

The AI will:
1. ✨ Generate FSM workflow files
2. 📤 Upload to the NenAI platform
3. ▶️ Execute the workflow
4. 📊 Show you the results

---

## 🛠️ Available MCP Tools

| Tool | Description |
|------|-------------|
| `nen_create_workflow` | Generate FSM workflow files from natural language |
| `nen_upload` | Upload workflow to NenAI platform |
| `nen_run` | Execute a workflow |
| `nen_status` | Check workflow run status |
| `nen_artifacts` | Download run artifacts (recording + logs) |
| `nen_list_runs` | List recent runs for a workflow |
| `nen_list_workflows` | List all workflows in a deployment |
| `nen_list_deployments` | List deployments available to your API key |

📚 **Full documentation:** [TOOLS_REFERENCE.md](TOOLS_REFERENCE.md)

---

## 📂 Sample Workflows

Explore ready-to-use examples in `workflows/samples/`:

| Workflow | Description |
|----------|-------------|
| **website-login** | Navigate to a website and log in with credentials |
| **get-appointments** | Extract appointment data from a web application |
| **download-documents** | Automate document downloads from websites |

---

## 📖 Documentation

| Document | Description |
|----------|-------------|
| [QUICK_SETUP_V2.md](QUICK_SETUP_V2.md) | Complete setup guide with all methods |
| [TOOLS_REFERENCE.md](TOOLS_REFERENCE.md) | Detailed MCP tools reference |
| [TROUBLESHOOTING.md](TROUBLESHOOTING.md) | Solutions to common issues |
| [INSTALLATION.md](INSTALLATION.md) | Alternative installation methods |
| [.cursorrules](.cursorrules) | FSM workflow authoring guide |
| [CONTRIBUTING.md](CONTRIBUTING.md) | Contribution guidelines |

---

## 🏗️ Workflow Structure

Workflows use a **Finite State Machine (FSM)** model with two file types:

### orchestrator.json
High-level workflow definition:
- Variables (inputs)
- States (checkpoints)
- Transitions (execution flow)
- Retry/timeout configuration

### workflow.json
Detailed state machine:
- LLMState (agentic actions)
- ToolState (deterministic actions)
- VerificationState (wait for conditions)
- CoordinateToolState (find & click)
- CallbackState (dynamic values)

📖 **Learn more:** Read [.cursorrules](.cursorrules) for the complete authoring guide

---

## 🔒 Security

✅ Credentials are provided via **environment variables**  
✅ Referenced in `mcp.json` using `${env:...}` substitution  
✅ Never committed to git  
✅ Remote MCP server uses secure HTTPS with API key authentication

See [SECURITY_IMPROVEMENTS.md](SECURITY_IMPROVEMENTS.md) for details.

---

## 🐛 Troubleshooting

| Problem | Solution |
|---------|----------|
| MCP tools not available | Restart Cursor completely (`Cmd+Q` / `Ctrl+Q`) |
| "401 Unauthorized" | Verify `NEN_API_KEY` and contact your customer engineer |
| Env vars not loading | Set vars before launching Cursor; restart terminal |

📖 **Detailed solutions:** [TROUBLESHOOTING.md](TROUBLESHOOTING.md)

---

## 💡 Tips

### Environment Setup Pattern

All workflows should start with these states:
1. Launch browser
2. Dismiss popups
3. Focus address bar
4. Type URL
5. Press Enter
6. Verify page loaded

This ensures consistent, reproducible execution.

### Best Practices

✅ Use **LLMState** for dynamic UI interactions  
✅ Use **ToolState** for exact coordinates/actions  
✅ Use **VerificationState** after critical actions  
✅ Keep `max_iterations` between 5-15  
✅ Write specific verification prompts  

---

## 🤝 Contributing

We welcome contributions! Share your workflows, improvements, and ideas.

1. Fork the repository
2. Create a feature branch
3. Add your workflow to `workflows/samples/`
4. Submit a pull request

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

---

## 📊 Workflow Lifecycle

```
1. Create    → nen_create_workflow generates FSM files
2. Review    → Edit generated files as needed
3. Upload    → nen_upload deploys to platform
4. Execute   → nen_run triggers execution
5. Monitor   → nen_status checks progress
6. Debug     → nen_artifacts downloads recordings/logs
7. Iterate   → Edit and re-upload
```

---

## 🎓 Learning Resources

### For Beginners
- Start with [QUICK_SETUP_V2.md](QUICK_SETUP_V2.md)
- Try the interactive setup
- Run sample workflows
- Ask AI to create simple workflows

### For Advanced Users
- Read [.cursorrules](.cursorrules) for FSM authoring
- Study sample workflows in detail
- Create custom state types
- Implement failure recovery

---

## 🆘 Getting Help

- **Need credentials?** Contact your NenAI customer engineer
- **Technical issues?** Check [TROUBLESHOOTING.md](TROUBLESHOOTING.md)
- **Feature requests?** Open an issue on GitHub
- **Questions?** See [DOCS_MAP.md](DOCS_MAP.md) for all documentation

---

## 📜 License

See [LICENSE](LICENSE) for details.

---

## 🌟 What's New

### Recent Improvements

✨ **Three installation methods** - interactive, one-click, manual  
✨ **Visual install generator** - beautiful web interface  
✨ **Cursor deeplink support** - one-click setup  
✨ **Interactive setup script** - guided configuration  
✨ **Improved documentation** - clearer, more organized  

See [CHANGELOG.md](CHANGELOG.md) for full history.

---

**Ready to automate?** [Get started now](#quick-install) 🚀

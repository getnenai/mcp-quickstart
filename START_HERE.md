# 🚀 START HERE: NenAI MCP Quickstart

**Welcome to the improved NenAI MCP quickstart!** This guide will get you up and running in minutes.

---

## 📋 What You Need

Before starting, get these from your **NenAI customer engineer**:
- ✅ `NEN_API_KEY` - Your authentication key
- ✅ `NEN_MCP_URL` - Your remote MCP server URL

Don't have these yet? Contact your NenAI customer engineer.

---

## ⚡ Quick Start (Choose One Method)

### Option 1: Interactive Setup (Easiest) ⭐ RECOMMENDED

Perfect for first-time users. Guided prompts walk you through everything.

```bash
bash setup-interactive.sh
```

**What happens:**
1. Script prompts for your API key
2. Script prompts for your MCP URL
3. Generates a one-click install link
4. Optionally opens Cursor automatically
5. Shows you the exact commands to run

**Time:** ~2 minutes

---

### Option 2: Visual Web Generator (Most Modern)

Beautiful web interface. No command line needed.

```bash
open generate-install-link.html  # macOS
xdg-open generate-install-link.html  # Linux
```

**What happens:**
1. Enter credentials in web form
2. Click "Generate Install Link"
3. Click "Open in Cursor" button
4. Follow on-screen instructions

**Time:** ~2 minutes

---

### Option 3: Manual Setup (Most Control)

For advanced users who want full control.

```bash
# Step 1: Set environment variables
export NEN_API_KEY="your_api_key_here"
export NEN_MCP_URL="your_mcp_url_here"

# Step 2: Run setup script
bash setup-remote-mcp.sh

# Step 3: Restart Cursor (⌘Q or Ctrl+Q)
```

**Time:** ~5 minutes

---

## 🔐 Important: Environment Variables

**All methods require setting environment variables permanently.**

Add these to your shell profile (`~/.zshrc` or `~/.bashrc`):

```bash
export NEN_API_KEY="your_api_key_here"
export NEN_MCP_URL="your_mcp_url_here"
```

Then reload your shell:

```bash
source ~/.zshrc  # if using zsh
source ~/.bashrc  # if using bash
```

**Why?** Environment variables keep your credentials secure and separate from configuration files.

---

## ✅ Verify Installation

After setup, completely restart Cursor (⌘Q or Ctrl+Q), then ask the AI:

```
Use nen_list_workflows to verify the MCP server is working
```

**Expected response:** List of workflows in your deployment.

If you see the MCP tools working, you're all set! 🎉

---

## 🎯 Your First Workflow

Now create your first automation with natural language:

```
Create a workflow that navigates to google.com and takes a screenshot
```

The AI will:
1. Generate FSM workflow files
2. Upload to the NenAI platform
3. Execute the workflow
4. Show you the results

---

## 📚 Next Steps

### Learn More
- **[QUICK_SETUP_V2.md](QUICK_SETUP_V2.md)** - Detailed setup guide
- **[TOOLS_REFERENCE.md](TOOLS_REFERENCE.md)** - All MCP tools explained
- **[.cursorrules](.cursorrules)** - FSM workflow authoring guide

### Explore Examples
- `workflows/samples/website-login/` - Website authentication
- `workflows/samples/get-appointments/` - Data extraction
- `workflows/samples/download-documents/` - File automation

### Get Help
- **Issues?** See [TROUBLESHOOTING.md](TROUBLESHOOTING.md)
- **Questions?** Check [README_IMPROVED.md](README_IMPROVED.md)
- **Feedback?** Contact your NenAI customer engineer

---

## 🛠️ Available Tools

Once connected, you can use these MCP tools:

| Tool | Purpose |
|------|---------|
| `nen_create_workflow` | Generate workflow files from natural language |
| `nen_upload` | Deploy workflow to platform |
| `nen_run` | Execute a workflow |
| `nen_status` | Check run status |
| `nen_artifacts` | Download recordings & logs |
| `nen_list_runs` | View run history |
| `nen_list_workflows` | List all workflows |
| `nen_list_deployments` | List deployments |

---

## 🐛 Troubleshooting

### MCP tools not showing up
- ✅ Ensure environment variables are set
- ✅ Restart terminal after setting env vars
- ✅ Completely quit Cursor (⌘Q / Ctrl+Q)
- ✅ Check `~/.cursor/mcp.json` exists

### 401 Unauthorized
- ✅ Verify `NEN_API_KEY` is correct
- ✅ Contact customer engineer to check key validity
- ✅ Ensure Cursor can read environment variables

### Environment variables not loading
- ✅ Add to `~/.zshrc` (zsh) or `~/.bashrc` (bash)
- ✅ Restart terminal completely
- ✅ Launch Cursor from terminal: `open -a Cursor`

**More help:** [TROUBLESHOOTING.md](TROUBLESHOOTING.md)

---

## 📂 Repository Structure

```
mcp-quickstart/
├── START_HERE.md                  ← You are here
├── QUICK_SETUP_V2.md             ← Detailed setup guide
├── README_IMPROVED.md            ← Full documentation
├── setup-interactive.sh           ← Interactive setup
├── generate-install-link.html     ← Web generator
├── generate-deeplink.sh           ← CLI generator
├── setup-remote-mcp.sh            ← Manual setup
├── workflows/
│   ├── samples/                   ← Example workflows
│   └── my_workflows/              ← Your workflows here
└── .cursorrules                   ← FSM authoring guide
```

---

## 🎓 Learning Path

### For Beginners
1. **Start:** Run `bash setup-interactive.sh`
2. **Verify:** Use `nen_list_workflows`
3. **Create:** Ask AI to create a simple workflow
4. **Learn:** Study sample workflows
5. **Explore:** Read `.cursorrules` for FSM patterns

### For Advanced Users
1. **Setup:** Use any method you prefer
2. **Study:** Read [CURSOR_DEEPLINK_ANALYSIS.md](CURSOR_DEEPLINK_ANALYSIS.md)
3. **Customize:** Modify FSM templates
4. **Contribute:** Share workflows back to community

---

## 🌟 What's New

This quickstart now includes:

✨ **Three installation methods** - Choose what works for you  
✨ **Visual install generator** - Beautiful web interface  
✨ **Interactive setup** - Guided configuration  
✨ **Cursor deeplink support** - One-click installation  
✨ **Comprehensive docs** - Clear, organized guides  
✨ **Professional design** - Modern UX  

See [IMPROVEMENTS_SUMMARY.md](IMPROVEMENTS_SUMMARY.md) for details.

---

## 🤝 Getting Help

### Documentation
- **Setup:** [QUICK_SETUP_V2.md](QUICK_SETUP_V2.md)
- **Tools:** [TOOLS_REFERENCE.md](TOOLS_REFERENCE.md)
- **Problems:** [TROUBLESHOOTING.md](TROUBLESHOOTING.md)
- **Overview:** [README_IMPROVED.md](README_IMPROVED.md)

### Support
- **Credentials:** Contact your NenAI customer engineer
- **Technical:** Check troubleshooting docs
- **Feedback:** Open GitHub issues

---

## 🎯 Quick Command Reference

```bash
# Interactive setup
bash setup-interactive.sh

# Generate deeplink
bash generate-deeplink.sh

# Manual setup
export NEN_API_KEY="..."
export NEN_MCP_URL="..."
bash setup-remote-mcp.sh

# Open web generator
open generate-install-link.html

# Verify installation (in Cursor)
# Ask AI: "Use nen_list_workflows to verify the MCP server is working"
```

---

## ✅ Setup Checklist

Use this to track your progress:

- [ ] Got `NEN_API_KEY` from customer engineer
- [ ] Got `NEN_MCP_URL` from customer engineer
- [ ] Chose installation method (interactive/web/manual)
- [ ] Set environment variables in shell profile
- [ ] Reloaded shell: `source ~/.zshrc`
- [ ] Ran setup script or generated deeplink
- [ ] Completely restarted Cursor (⌘Q or Ctrl+Q)
- [ ] Verified with `nen_list_workflows`
- [ ] Created first workflow
- [ ] Reviewed sample workflows

**All done?** You're ready to automate! 🚀

---

## 🔗 Quick Links

| Resource | Link |
|----------|------|
| **Setup Guide** | [QUICK_SETUP_V2.md](QUICK_SETUP_V2.md) |
| **Main README** | [README_IMPROVED.md](README_IMPROVED.md) |
| **Tools Reference** | [TOOLS_REFERENCE.md](TOOLS_REFERENCE.md) |
| **Troubleshooting** | [TROUBLESHOOTING.md](TROUBLESHOOTING.md) |
| **FSM Guide** | [.cursorrules](.cursorrules) |
| **Improvements** | [IMPROVEMENTS_SUMMARY.md](IMPROVEMENTS_SUMMARY.md) |
| **Technical Analysis** | [CURSOR_DEEPLINK_ANALYSIS.md](CURSOR_DEEPLINK_ANALYSIS.md) |

---

**Ready to get started?** Pick a method above and let's go! 🎉

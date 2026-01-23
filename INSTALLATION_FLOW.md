# Installation Flow Diagram

Visual guide showing the three installation paths and how they work.

---

## 🎯 Overview

```
┌─────────────────────────────────────────────────────────┐
│              NenAI MCP Quickstart                       │
│         Choose Your Installation Method                 │
└─────────────────────────────────────────────────────────┘
                           │
           ┌───────────────┼───────────────┐
           │               │               │
           ▼               ▼               ▼
    ┌─────────────┐ ┌─────────────┐ ┌─────────────┐
    │ Interactive │ │    Web      │ │   Manual    │
    │   Setup     │ │  Generator  │ │   Setup     │
    └─────────────┘ └─────────────┘ └─────────────┘
```

---

## Method 1: Interactive Setup 🎯

```
START
  │
  ├─► Run: bash setup-interactive.sh
  │
  ├─► Prompts for API key
  │    └─► Validates input
  │
  ├─► Prompts for MCP URL
  │    └─► Validates input
  │
  ├─► Generates base64 config
  │
  ├─► Creates deeplink
  │    └─► cursor://anysphere.cursor-deeplink/mcp/install?...
  │
  ├─► Offers to open Cursor
  │    ├─► Yes → Opens automatically
  │    └─► No  → Shows link to copy
  │
  ├─► Shows env var commands
  │    └─► export NEN_API_KEY="..."
  │    └─► export NEN_MCP_URL="..."
  │
  └─► DONE (2 minutes)
```

**User Flow:**
1. Run script → 2. Answer prompts → 3. Click open → 4. Restart Cursor → ✅ Done

---

## Method 2: Web Generator 🌐

```
START
  │
  ├─► Open: generate-install-link.html
  │
  ├─► Browser displays beautiful form
  │    ├─► Input: API Key field
  │    └─► Input: MCP URL field
  │
  ├─► Click: "Generate Install Link"
  │    └─► JavaScript generates deeplink
  │         └─► Base64 encodes config
  │
  ├─► Displays results:
  │    ├─► Deeplink in copyable box
  │    ├─► "Copy Link" button
  │    ├─► "Open in Cursor" button
  │    └─► Env var commands
  │
  ├─► Click: "Open in Cursor"
  │    └─► Browser opens cursor:// URL
  │         └─► Cursor launches/focuses
  │
  └─► DONE (2 minutes)
```

**User Flow:**
1. Open HTML → 2. Fill form → 3. Generate → 4. Click open → 5. Restart Cursor → ✅ Done

---

## Method 3: Manual Setup 🔧

```
START
  │
  ├─► Set environment variables
  │    └─► export NEN_API_KEY="..."
  │    └─► export NEN_MCP_URL="..."
  │
  ├─► Run: bash setup-remote-mcp.sh
  │
  ├─► Script validates env vars
  │    ├─► Missing? → Error + instructions
  │    └─► Present? → Continue
  │
  ├─► Creates ~/.cursor/mcp.json
  │    └─► {
  │         "mcpServers": {
  │           "nenai": {
  │             "url": "${env:NEN_MCP_URL}",
  │             "headers": {
  │               "X-Api-Key": "${env:NEN_API_KEY}"
  │             }
  │           }
  │         }
  │       }
  │
  ├─► Shows success message
  │
  └─► DONE (5 minutes)
```

**User Flow:**
1. Export vars → 2. Run script → 3. Restart Cursor → ✅ Done

---

## Configuration Flow 🔄

```
┌──────────────────────────────────────────────────────┐
│              Any Installation Method                  │
└──────────────────────────────────────────────────────┘
                        │
                        ▼
┌──────────────────────────────────────────────────────┐
│  Environment Variables (set by user)                  │
│  • NEN_API_KEY = "actual_api_key"                    │
│  • NEN_MCP_URL = "https://mcp.getnen.ai/"           │
└──────────────────────────────────────────────────────┘
                        │
                        ▼
┌──────────────────────────────────────────────────────┐
│  ~/.cursor/mcp.json (created by script/deeplink)     │
│  {                                                    │
│    "mcpServers": {                                   │
│      "nenai": {                                      │
│        "url": "${env:NEN_MCP_URL}",                 │
│        "headers": {                                  │
│          "X-Api-Key": "${env:NEN_API_KEY}"         │
│        }                                             │
│      }                                               │
│    }                                                 │
│  }                                                   │
└──────────────────────────────────────────────────────┘
                        │
                        ▼
┌──────────────────────────────────────────────────────┐
│  Cursor reads mcp.json on startup                     │
│  Substitutes ${env:...} with actual values           │
└──────────────────────────────────────────────────────┘
                        │
                        ▼
┌──────────────────────────────────────────────────────┐
│  MCP Server Connection Established                    │
│  ✅ 8 MCP tools available in Cursor                  │
└──────────────────────────────────────────────────────┘
```

---

## Security Flow 🔒

```
USER CREDENTIALS
      │
      ├─► Stored in: ~/.zshrc or ~/.bashrc
      │    └─► export NEN_API_KEY="secret"
      │    └─► export NEN_MCP_URL="https://..."
      │
      ├─► Referenced in: ~/.cursor/mcp.json
      │    └─► "${env:NEN_API_KEY}" (placeholder)
      │    └─► "${env:NEN_MCP_URL}" (placeholder)
      │
      ├─► Substituted by: Cursor at runtime
      │    └─► Reads environment variables
      │    └─► Replaces placeholders
      │    └─► Never stores actual values
      │
      └─► Result: Secure, rotatable, separate

✅ Credentials never in version control
✅ Credentials never in config files
✅ Easy to rotate (just change env var)
✅ Standard practice (12-factor app)
```

---

## Deeplink Generation Flow 🔗

```
INPUTS
  ├─► NEN_API_KEY (env var or prompt)
  └─► NEN_MCP_URL (env var or prompt)
        │
        ▼
CREATE CONFIG OBJECT
  {
    "url": "${env:NEN_MCP_URL}",
    "headers": {
      "X-Api-Key": "${env:NEN_API_KEY}"
    }
  }
        │
        ▼
JSON.stringify()
  {"url":"${env:NEN_MCP_URL}","headers":{"X-Api-Key":"${env:NEN_API_KEY}"}}
        │
        ▼
BASE64 ENCODE
  eyJ1cmwiOiIke2Vudjp...
        │
        ▼
CREATE DEEPLINK
  cursor://anysphere.cursor-deeplink/mcp/install?name=nenai&config=eyJ1cmwiOiIke2Vudjp...
        │
        ▼
USE DEEPLINK
  ├─► Click in browser → Opens Cursor
  ├─► Cursor prompts: "Install MCP server?"
  ├─► User confirms
  └─► Cursor writes to ~/.cursor/mcp.json
```

---

## Troubleshooting Flow 🐛

```
PROBLEM: MCP tools not showing
    │
    ├─► Check: Are env vars set?
    │    ├─► No  → Set them + restart terminal
    │    └─► Yes → Continue
    │
    ├─► Check: Does ~/.cursor/mcp.json exist?
    │    ├─► No  → Run setup script
    │    └─► Yes → Continue
    │
    ├─► Check: Was Cursor restarted?
    │    ├─► No  → Quit (⌘Q) + Reopen
    │    └─► Yes → Continue
    │
    ├─► Check: Valid JSON in mcp.json?
    │    ├─► No  → Re-run setup
    │    └─► Yes → Continue
    │
    └─► Still broken? → Check TROUBLESHOOTING.md
```

---

## Complete User Journey 🗺️

```
ENTRY POINT
    │
    ├─► Discovers NenAI MCP
    │
    ├─► Reads START_HERE.md
    │    └─► Understands 3 methods
    │
    ├─► Gets credentials from customer engineer
    │    ├─► NEN_API_KEY
    │    └─► NEN_MCP_URL
    │
    ├─► Chooses installation method
    │    ├─► Interactive → bash setup-interactive.sh
    │    ├─► Web       → open generate-install-link.html
    │    └─► Manual    → bash setup-remote-mcp.sh
    │
    ├─► Completes setup (2-5 minutes)
    │
    ├─► Restarts Cursor
    │
    ├─► Verifies with nen_list_workflows
    │    ├─► Works? → Success! ✅
    │    └─► Fails? → TROUBLESHOOTING.md
    │
    ├─► Creates first workflow
    │    └─► "Create a workflow that..."
    │
    ├─► Explores sample workflows
    │    ├─► website-login
    │    ├─► get-appointments
    │    └─► download-documents
    │
    ├─► Reads FSM authoring guide
    │    └─► .cursorrules
    │
    └─► Builds production workflows! 🚀
```

---

## Time Comparison ⏱️

```
BEFORE (Manual Only):
├─► Read docs             → 3 min
├─► Find setup info       → 2 min
├─► Set env vars          → 2 min
├─► Manually create JSON  → 2 min
├─► Fix JSON errors       → 1 min
└─► Restart + verify      → 1 min
    TOTAL: ~10 minutes ❌

AFTER (Interactive):
├─► Run script            → 30 sec
├─► Answer prompts        → 30 sec
├─► Click open            → 10 sec
└─► Restart + verify      → 1 min
    TOTAL: ~2 minutes ✅
    
Improvement: 80% faster! 🚀
```

---

## Decision Tree 🌳

```
Do you have credentials?
    │
    ├─► NO  → Contact NenAI customer engineer
    │
    └─► YES → Continue
            │
            Do you prefer GUI or CLI?
                │
                ├─► GUI → Use Web Generator
                │        └─► open generate-install-link.html
                │
                └─► CLI → Comfortable with shell?
                         │
                         ├─► NO  → Use Interactive
                         │        └─► bash setup-interactive.sh
                         │
                         └─► YES → Want guidance or control?
                                  │
                                  ├─► Guidance → Interactive
                                  │              └─► bash setup-interactive.sh
                                  │
                                  └─► Control  → Manual
                                                 └─► bash setup-remote-mcp.sh
```

---

## Tool Availability Flow 🛠️

```
AFTER SUCCESSFUL SETUP
    │
    ├─► nen_create_workflow
    │    └─► Generate FSM files from natural language
    │
    ├─► nen_upload
    │    └─► Deploy workflow to NenAI platform
    │
    ├─► nen_run
    │    └─► Execute a workflow
    │
    ├─► nen_status
    │    └─► Check run status
    │
    ├─► nen_artifacts
    │    └─► Download recordings/logs
    │
    ├─► nen_list_runs
    │    └─► View run history
    │
    ├─► nen_list_workflows
    │    └─► List all workflows
    │
    └─► nen_list_deployments
         └─► List deployments
```

---

## Success Criteria ✅

```
YOU'RE READY TO GO WHEN:

✅ Environment variables set in shell profile
✅ ~/.cursor/mcp.json exists and is valid
✅ Cursor has been restarted completely
✅ MCP tools visible in Cursor
✅ nen_list_workflows returns results
✅ Can create workflows with AI
✅ Understand basic FSM structure

THEN YOU CAN:
🚀 Build automations
📊 Extract data
🔄 Automate workflows
🎯 Solve business problems
```

---

## File Structure 📁

```
mcp-quickstart/
│
├── START_HERE.md          ← Start here!
├── QUICK_SETUP_V2.md      ← Detailed guide
├── README_IMPROVED.md     ← Full docs
│
├── Setup Tools:
│   ├── setup-interactive.sh       (Interactive)
│   ├── generate-install-link.html (Web)
│   ├── generate-deeplink.sh       (CLI)
│   └── setup-remote-mcp.sh        (Manual)
│
├── Documentation:
│   ├── IMPROVEMENTS_SUMMARY.md
│   ├── CURSOR_DEEPLINK_ANALYSIS.md
│   ├── EXECUTIVE_SUMMARY.md
│   ├── NEW_FILES_SUMMARY.md
│   ├── WHATS_NEW.md
│   ├── INSTALLATION_FLOW.md (this file)
│   └── TROUBLESHOOTING.md
│
├── Visual Assets:
│   └── .github/install-button.svg
│
└── Workflows:
    ├── samples/           (Examples)
    └── my_workflows/      (Your workflows)
```

---

## Summary

**Three paths, one goal:** Fast, secure NenAI MCP setup.

**Choose based on:**
- Preference (GUI vs CLI)
- Experience level (beginner vs advanced)
- Context (guided vs control)

**All paths lead to:**
- ✅ 2-5 minute setup
- ✅ Secure credentials
- ✅ Working MCP server
- ✅ Ready to automate

**Get started:** [START_HERE.md](START_HERE.md) 🚀

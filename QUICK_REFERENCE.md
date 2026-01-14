# NenAI MCP Quick Reference

## 🚀 Quick Start Commands

```bash
# Initial setup
npm install              # Creates .env, shows next steps
npm run verify           # Check if everything is configured

# During development
npm run clean            # Remove test workflows
```

## 📝 Essential Files

| File | Purpose |
|------|---------|
| `.env` | Your API credentials (keep secret!) |
| `.cursorrules` | FSM workflow authoring guide |
| `workflows/my_workflows/` | Your custom workflows |
| `workflows/samples/` | Example workflows to learn from |

## 🔧 Cursor MCP Configuration

Add to `~/.cursor/mcp.json`:

```json
{
  "mcpServers": {
    "nen": {
      "command": "npx",
      "args": ["@nen/mcp-server"],
      "cwd": "/FULL/PATH/TO/mcp-quickstart"
    }
  }
}
```

**Get your path:** Run `pwd` in the mcp-quickstart directory

**After editing:** Restart Cursor completely (Cmd+Q or File > Exit)

## 🤖 AI Agent Commands

### First-time verification
```
"Use list_runs to verify the MCP server is working"
```

### Create a workflow
```
"Create a workflow that navigates to google.com and takes a screenshot"
```

### More examples
```
"Create a workflow that:
- Opens example.com
- Fills in a login form with ${USERNAME} and ${PASSWORD}
- Takes a screenshot of the dashboard"
```

## 🔍 Available MCP Tools

| Tool | What it does |
|------|--------------|
| `create_workflow` | Generate workflow from description |
| `update_workflow` | Upload changes to NenAI |
| `create_run` | Execute a workflow |
| `get_run_status` | Check if run completed |
| `get_run_logs` | View execution logs |
| `get_run_video` | Get recording URL |
| `list_runs` | List recent executions |

## 🔐 Environment Variables

```bash
# Required in .env file
NEN_API_KEY=sk_xxxxxxxxxxxxx
NEN_DEPLOYMENT_ID=dep_xxxxxxxxxxxxx
```

**Format rules:**
- ✅ No quotes: `NEN_API_KEY=sk_xxx`
- ❌ With quotes: `NEN_API_KEY="sk_xxx"`
- ❌ Extra spaces: `NEN_API_KEY= sk_xxx`

## 🏗️ FSM State Types

| State Type | When to use |
|------------|-------------|
| **LLMState** | Let AI figure out how to do something |
| **ToolState** | Execute specific action (click, type) |
| **VerificationState** | Wait for condition to be true |
| **CoordinateToolState** | Find element, then act on it |
| **CallbackState** | Generate dynamic values (TOTP, time) |

## ⚠️ Common Issues

### MCP server not found
```bash
# Check Cursor logs
View > Output > Model Context Protocol

# Verify installation
npx @nen/mcp-server --version
```

### Authentication errors
```bash
# Check .env format
cat .env

# Restart Cursor after editing .env
Cmd+Q (macOS) or File > Exit
```

### Workflow creation fails
```
# Start simple
"Create a workflow that takes a screenshot"

# Validate JSON
node -e "JSON.parse(require('fs').readFileSync('workflows/my_workflows/your-workflow/workflow.json'))"
```

## 📚 Documentation Quick Links

- **Detailed Setup:** [README.md](README.md)
- **Troubleshooting:** [TROUBLESHOOTING.md](TROUBLESHOOTING.md)
- **Sample Workflows:** [workflows/samples/](workflows/samples/)
- **FSM Guide:** [.cursorrules](.cursorrules)

## 🆘 Getting Help

1. Run diagnostics:
   ```bash
   npm run verify
   ```

2. Check troubleshooting guide:
   ```bash
   cat TROUBLESHOOTING.md | grep -i "your error"
   ```

3. Contact support:
   - Email: hello@nen.ai
   - Include output of `npm run verify`

## 🎯 Best Practices

### Workflow Design
1. ✅ Start with browser launch and navigation
2. ✅ Use verification after critical actions
3. ✅ One clear goal per state
4. ✅ Descriptive state IDs
5. ✅ Set reasonable max_iterations (5-15)

### Development
1. ✅ Test with simple workflows first
2. ✅ Use sample workflows as templates
3. ✅ Clean up test workflows: `npm run clean`
4. ✅ Verify setup after changes: `npm run verify`

### Security
1. ✅ Never commit `.env` file
2. ✅ Rotate API keys if exposed
3. ✅ Use variables for sensitive data: `${PASSWORD}`
4. ✅ Keep credentials in .env only

## 📊 Workflow Variables

### Defining inputs
```
"Create a workflow with inputs ${SEARCH_TERM} and ${MAX_RESULTS}"
```

### Using in states
```json
{
  "type": "ToolState",
  "tool": "type_text",
  "params": {
    "text": "${SEARCH_TERM}"
  }
}
```

## 🔄 Typical Workflow

```
1. Launch browser
2. Navigate to URL
3. Wait for page load (VerificationState)
4. Interact with elements (ToolState/LLMState)
5. Verify success (VerificationState)
6. Extract/screenshot data
7. End state
```

## ⌨️ Useful Commands

```bash
# View sample workflow
cat workflows/samples/get-appointments/workflow.json | jq

# Count your workflows
ls -1 workflows/my_workflows/ | wc -l

# Find workflow by name
find workflows/my_workflows -name "*search*"

# Check Node.js version
node --version  # Need >= 18.0.0

# Update MCP server
npm update @nen/mcp-server
```

---

**Need more details?** Check [README.md](README.md) for comprehensive documentation.

**Have an issue?** See [TROUBLESHOOTING.md](TROUBLESHOOTING.md) for solutions.

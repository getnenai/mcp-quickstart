# Documentation Overview

Welcome to the NenAI MCP Quickstart! This guide will help you navigate the documentation.

---

## 📚 Documentation Structure

| Document | Purpose | When to Use |
|----------|---------|-------------|
| **[README.md](README.md)** | Quick start and overview | First time setup, getting oriented |
| **[INSTALLATION.md](INSTALLATION.md)** | Detailed installation guide | Setting up the MCP server in your IDE |
| **[TOOLS_REFERENCE.md](TOOLS_REFERENCE.md)** | MCP tools documentation | Learning what each tool does |
| **[.cursorrules](.cursorrules)** | FSM authoring guide | Creating and editing workflows |
| **[CONTRIBUTING.md](CONTRIBUTING.md)** | Contribution guidelines | Adding new workflows or improving docs |
| **[CHANGELOG.md](CHANGELOG.md)** | Version history | Seeing what's changed |

---

## 🚀 Getting Started Path

Follow this path for the smoothest onboarding:

### 1. Installation (15 minutes)
→ **[INSTALLATION.md](INSTALLATION.md)**
- Clone repository
- Configure the **remote** MCP server in your IDE
- Verify installation works

### 2. First Workflow (30 minutes)
→ **[README.md - Quick Start](README.md#quick-start)**
- Ask AI to create a simple workflow
- Review generated FSM files
- Run your first workflow
- Check execution status and logs

### 3. Learn the Tools (1 hour)
→ **[TOOLS_REFERENCE.md](TOOLS_REFERENCE.md)**
- Understand what each MCP tool does
- Study example usage patterns
- Practice with the sample workflows
- Learn the typical workflow lifecycle

### 4. Master FSM Authoring (2-3 hours)
→ **[.cursorrules](.cursorrules)**
- Learn state types (LLM, Tool, Verification)
- Study environment normalization patterns
- Understand variable system
- Review failure recovery strategies
- Study common pitfalls and solutions

### 5. Explore Examples (1 hour)
→ **[workflows/samples/](workflows/samples/)**
- Review get-appointments workflow
- Study download-documents workflow
- Understand how patterns are applied
- Adapt patterns to your use cases

### 6. Build Complex Workflows (ongoing)
→ **[CONTRIBUTING.md](CONTRIBUTING.md)**
- Apply best practices
- Test thoroughly
- Share your workflows
- Contribute improvements

---

## 🎯 Quick Reference by Task

### "I want to install the MCP server"
→ **[INSTALLATION.md](INSTALLATION.md)**
- Platform-specific instructions (macOS, Windows, Linux)
- IDE-specific setup (Cursor, Windsurf, Claude Desktop)
- Troubleshooting common installation issues

### "I want to create a workflow"
1. **Generate:** Ask AI agent to create workflow ([README.md](README.md#quick-start))
2. **Understand:** Review FSM authoring guide ([.cursorrules](.cursorrules))
3. **Refine:** Apply best practices ([CONTRIBUTING.md](CONTRIBUTING.md#workflow-best-practices))

### "I want to know what a tool does"
→ **[TOOLS_REFERENCE.md](TOOLS_REFERENCE.md)**
- Find the tool name
- Read parameters and examples
- Copy and adapt the example

### "My workflow isn't working"
1. **Check status/logs:** Use `get_run_status` and `nen_logs`
2. **Review guide:** Check common pitfalls in [.cursorrules](.cursorrules)
3. **Get help:** See troubleshooting in [INSTALLATION.md](INSTALLATION.md#troubleshooting)

### "The MCP server isn't connecting"
→ **[INSTALLATION.md - Troubleshooting](INSTALLATION.md#troubleshooting)**
- Verify installation steps
- Check API key configuration
- Restart IDE completely
- Review error messages

### "I want to contribute"
→ **[CONTRIBUTING.md](CONTRIBUTING.md)**
- Workflow development guidelines
- Testing requirements
- Submission process
- Code standards

---

## 📖 Document Details

### README.md
**Purpose:** Landing page and quick start guide

**Key sections:**
- Quick start (6 steps from clone to first workflow)
- Available MCP tools overview
- Troubleshooting basics
- What's next section
- Resources and links

**Read this if:** You're new and want to get started quickly.

---

### INSTALLATION.md
**Purpose:** Comprehensive setup guide for all platforms

**Key sections:**
- Prerequisites
- Step-by-step installation
- IDE-specific configuration (Cursor, Windsurf, Claude Desktop)
- Verification steps
- Detailed troubleshooting
- Advanced configuration

**Read this if:** You need help installing or your MCP server isn't working.

---

### TOOLS_REFERENCE.md
**Purpose:** Complete reference for Nen MCP tools

**Key sections:**
- Tool overview table
- Detailed docs for each tool
  - `nen_create_workflow` - Generate workflows
  - `nen_upload` - Deploy to platform
  - `nen_run` - Execute workflows
  - `get_run_status` - Check execution status
  - `list_runs` - View run history
- Typical workflow patterns
- Tips and best practices

**Read this if:** You want to understand what each tool does and see examples.

---

### .cursorrules
**Purpose:** Comprehensive FSM authoring guide for AI agents

**Key sections:**
- Workflow structure
- State types (LLM, Tool, Verification, CoordinateToolState, CallbackState)
- Variable system
- Failure recovery
- Environment normalization pattern
- FSM and orchestrator templates
- Common pitfalls and solutions

**Read this if:** You're creating or editing workflows and need to understand FSM patterns.

---

### CONTRIBUTING.md
**Purpose:** Guidelines for contributing workflows and documentation

**Key sections:**
- Development setup
- Workflow best practices
- Code standards
- Testing workflows
- Submission process
- PR guidelines

**Read this if:** You want to contribute a workflow or improve documentation.

---

### CHANGELOG.md
**Purpose:** Track changes and versions

**Contents:**
- Version history
- Added features
- Changed functionality
- Planned enhancements

**Read this if:** You want to see what's new or changed.

---

## 💡 Tips for Success

### For Beginners
1. **Start with README.md** - Don't skip the quick start
2. **Follow the order** - Installation → First workflow → Tools → FSM authoring
3. **Use the AI agent** - Let it generate initial workflows
4. **Study examples** - The samples/ directory has working patterns
5. **Ask for help** - Reference docs are comprehensive

### For Advanced Users
1. **.cursorrules is your bible** - Master the FSM patterns
2. **Test incrementally** - Small changes, frequent tests
3. **Use verification states** - Wait for UI, don't rush
4. **Review run logs** - Logs show what actually happened
5. **Contribute back** - Share your workflows and patterns

### For Troubleshooters
1. **Logs first** - Usually fastest signal on failures
2. **Check state transitions** - Review workflow_runner_flow.json
3. **Compare successful runs** - What changed?
4. **Read error messages carefully** - They're usually accurate
5. **Restart your IDE** - Environment-variable changes require a full restart

---

## 🔗 External Resources

### Model Context Protocol (MCP)
- Official spec: https://modelcontextprotocol.io
- Learn how MCP servers work
- Understand the protocol

### NenAI Platform
- Contact your customer engineer for:
  - API keys
  - Organization setup
  - Platform access
  - Technical support

---

## 📝 Documentation Feedback

Found an issue or have a suggestion?
- Open an issue on GitHub
- Submit a PR to improve docs
- Contact your customer engineer

---

## 🎓 Learning Path Summary

```
Week 1: Basics
├─ Day 1-2: Install and verify setup
├─ Day 3-4: Create first simple workflow
└─ Day 5-7: Run, monitor, and debug

Week 2: Intermediate
├─ Day 1-3: Study FSM authoring guide
├─ Day 4-5: Create complex multi-step workflow
└─ Day 6-7: Implement error handling and verification

Week 3: Advanced
├─ Day 1-3: Master all state types
├─ Day 4-5: Build production-ready workflows
└─ Day 6-7: Contribute to samples

Ongoing: Expert
├─ Create workflow libraries
├─ Optimize performance
├─ Share patterns with community
└─ Help others learn
```

---

Happy automating! 🤖

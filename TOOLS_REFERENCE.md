# MCP Tools Quick Reference

Quick reference guide for all NenAI MCP server tools.

---

## Tool Overview

| Tool | Purpose | Requires API Key |
|------|---------|------------------|
| `create_workflow` | Generate workflow FSM files | No |
| `update_workflow` | Deploy workflow to S3 | Yes |
| `create_run` | Execute workflow | Yes |
| `get_run_status` | Check run status | Yes (DynamoDB) |
| `get_run_logs` | Fetch execution logs | Yes (SSH) |
| `get_run_video` | Get video recording URL | Yes |
| `list_runs` | List workflow runs | Yes (DynamoDB) |
| `list_workflows` | List all workflows in deployment | Yes (DynamoDB) |

---

## create_workflow

Generate FSM workflow files from natural language descriptions.

### Parameters

```typescript
{
  description: string;           // What the workflow should achieve
  inputs: Array<{               // Input parameters
    name: string;               // Variable name (UPPER_SNAKE_CASE)
    description: string;        // Human-readable description
    exampleValue?: string;      // Example value
  }>;
  outputs: Array<{              // Expected outputs
    name: string;               // Output identifier
    type: 'json' | 'file' | 'screenshot' | 'text';
    description: string;        // What this output contains
  }>;
  workflowName?: string;        // Optional custom name
  outputPath?: string;          // Where to save files (default: ./workflows/generated)
}
```

### Example Usage

**Simple Example (via AI agent):**
> "Create a workflow that navigates to google.com and takes a screenshot"

**Detailed Example:**
```typescript
create_workflow({
  description: "Search for a patient in the hospital system and export their appointment history",
  inputs: [
    {
      name: "PATIENT_NAME",
      description: "Full name of the patient",
      exampleValue: "John Doe"
    },
    {
      name: "DATE_RANGE_START",
      description: "Start date for appointment history",
      exampleValue: "2024-01-01"
    }
  ],
  outputs: [
    {
      name: "appointments_json",
      type: "json",
      description: "List of appointments with dates and providers"
    },
    {
      name: "confirmation_screenshot",
      type: "screenshot",
      description: "Screenshot showing the export was successful"
    }
  ]
})
```

### Generated Files

- `orchestrator.json` - High-level workflow definition
- `01_step_name.json` - Individual FSM state files
- `02_another_step.json`
- etc.

### Best Practices

1. **Be specific in descriptions** - Include details about the application, expected UI, and success criteria
2. **Use descriptive variable names** - `PATIENT_NAME` not `name`, `LOGIN_URL` not `url`
3. **Define all inputs** - Include URLs, credentials, search terms, dates, etc.
4. **Specify outputs clearly** - What data structure? What file format?
5. **Review and edit** - Generated workflows are starting points; customize for your needs

---

## update_workflow

Upload workflow files to S3 and register in DynamoDB.

### Parameters

```typescript
{
  localPath: string;        // Path to local workflow directory
  orgName: string;          // Organization name (e.g., 'puppilot')
  orgId: string;            // Organization UUID
  deploymentName: string;   // Deployment name (e.g., 'pulse')
  workflowId: string;       // Workflow UUID
}
```

### Example Usage

```typescript
nen_upload({
  localPath: "./workflows/my_workflows/patient-search",
  orgName: "myorg",
  orgId: "550e8400-e29b-41d4-a716-446655440000",
  deploymentName: "production",
  workflowId: "123e4567-e89b-12d3-a456-426614174000"
})
```

### Requirements

- Valid AWS credentials with S3 write access
- Workflow files in the local directory
- Organization and deployment must exist in DynamoDB

### Success Response

```json
{
  "success": true,
  "message": "Workflow uploaded successfully to s3://nenai-customers/...",
  "s3Path": "s3://nenai-customers/myorg/production/workflows/..."
}
```

---

## create_run

Trigger workflow execution on the NenAI platform.

### Parameters

```typescript
{
  workflowId: string;       // Workflow UUID
  orgId: string;            // Organization UUID
  deploymentName: string;   // Deployment name
  input: Record<string, any>; // Input variables as key-value pairs
}
```

### Example Usage

```typescript
nen_run({
  workflowId: "123e4567-e89b-12d3-a456-426614174000",
  orgId: "550e8400-e29b-41d4-a716-446655440000",
  deploymentName: "production",
  input: {
    PATIENT_NAME: "John Doe",
    DATE_OF_BIRTH: "1990-01-15",
    SEARCH_TYPE: "name"
  }
})
```

### Requirements

- Valid `NEN_API_KEY` environment variable
- Workflow must be uploaded to S3 via `nen_upload`
- All required input variables must be provided

### Success Response

```json
{
  "success": true,
  "runId": "run-abc123",
  "messageId": "msg-xyz789",
  "status": "queued"
}
```

### Common Errors

| Error | Cause | Solution |
|-------|-------|----------|
| 401 Unauthorized | Invalid API key | Check `NEN_API_KEY` |
| 404 Not Found | Workflow doesn't exist | Use `nen_upload` first |
| 400 Bad Request | Missing required inputs | Check workflow variables |

---

## get_run_status

Check the status of a running or completed workflow.

### Parameters

```typescript
{
  runId?: string;           // Run identifier
  messageId?: string;       // Message identifier (alternative to runId)
}
```

### Example Usage

```typescript
nen_status({
  messageId: "msg-xyz789"
})
```

### Response

```json
{
  "success": true,
  "status": "completed",
  "startTime": "2026-01-14T10:30:00Z",
  "endTime": "2026-01-14T10:35:23Z",
  "progress": {
    "currentState": "final_verification",
    "completedStates": 15,
    "totalStates": 15
  },
  "output": {
    "appointments_json": { ... },
    "confirmation_screenshot": "s3://..."
  }
}
```

### Possible Statuses

- `queued` - Waiting to start
- `running` - Currently executing
- `completed` - Successfully finished
- `failed` - Encountered an error
- `timeout` - Exceeded maximum execution time

---

## get_run_logs

Fetch execution logs from the workflow container.

### Parameters

```typescript
{
  messageId: string;        // Message identifier
  tail?: number;            // Number of recent lines (default: 100)
}
```

### Example Usage

```typescript
nen_logs({
  messageId: "msg-xyz789",
  tail: 200
})
```

### Requirements

- SSH access to the execution environment
- Valid SSH configuration in `~/.ssh/config`

### Response

```json
{
  "success": true,
  "logs": "2026-01-14 10:30:05 [INFO] Starting workflow...\n2026-01-14 10:30:07 [INFO] State: launch_browser\n..."
}
```

### Use Cases

- Debugging workflow failures
- Monitoring real-time execution
- Understanding state transitions
- Identifying errors and warnings

---

## get_run_video

Download run artifacts (videos, logs, state files) from the execution environment.

### Parameters

```typescript
{
  messageId: string;        // Message identifier
  localPath?: string;       // Where to save artifacts (default: ./artifacts)
}
```

### Example Usage

```typescript
nen_artifacts({
  messageId: "msg-xyz789",
  localPath: "./debug/run-xyz789"
})
```

### Requirements

- SSH access to the execution environment
- `rsync` installed locally
- Sufficient disk space for video files

### Downloaded Files

```
artifacts/
├── recording.mp4                    # Video recording of execution
├── workflow.log                     # Complete execution log
├── execution_state.json             # Final status
├── progress_events.jsonl            # Timestamped events
├── workflow_runner_flow.json        # State transitions
└── workflow_runner_summary.json     # Summary statistics
```

### Use Cases

- **Debugging:** Watch video to see what went wrong
- **Verification:** Confirm workflow completed correctly
- **Analysis:** Review state transitions and timings
- **Documentation:** Show examples of workflow execution

---

## list_runs

List recent workflow runs.

### Parameters

```typescript
{
  workflowId?: string;      // Filter by workflow (optional)
  limit?: number;           // Max results (default: 10)
}
```

### Example Usage

```typescript
nen_list_runs({
  workflowId: "123e4567-e89b-12d3-a456-426614174000",
  limit: 20
})
```

### Response

```json
{
  "success": true,
  "runs": [
    {
      "runId": "run-abc123",
      "messageId": "msg-xyz789",
      "workflowId": "123e4567-...",
      "status": "completed",
      "startTime": "2026-01-14T10:30:00Z",
      "endTime": "2026-01-14T10:35:23Z"
    },
    ...
  ]
}
```

### Use Cases

- Finding a specific run to debug
- Monitoring workflow execution history
- Identifying patterns in failures
- Tracking execution times

---

## list_workflows

List all workflows in a deployment.

### Parameters

```typescript
{
  deploymentId?: string;    // Optional: Deployment UUID (uses NEN_DEPLOYMENT_ID from env if not provided)
  orgId?: string;           // Optional: Filter by organization UUID
  limit?: number;           // Optional: Max workflows to return (default: 50)
}
```

### Example Usage

```typescript
// List all workflows (uses NEN_DEPLOYMENT_ID from environment)
list_workflows({})

// Specify deployment explicitly
list_workflows({
  deploymentId: "dbad9c3b-d6bd-437b-884d-f9c69676d174"
})

// Filter by organization and limit results
list_workflows({
  deploymentId: "dbad9c3b-d6bd-437b-884d-f9c69676d174",
  orgId: "f303bc4a-81fc-4e37-b4cc-1449b3782260",
  limit: 20
})
```

### Response

```typescript
{
  success: true,
  data: {
    workflows: [
      {
        workflowId: "abc123...",
        orgId: "org456...",
        orgName: "acme-corp",
        workflowName: "patient-search",
        deploymentId: "deploy789...",
        s3WorkflowPath: "v1234567890",
        createdAt: "2026-01-14T10:30:00.000Z",
        updatedAt: "2026-01-14T12:45:00.000Z",
        publishedAt: "2026-01-14T12:45:00.000Z"
      }
    ],
    count: 1
  }
}
```

### Common Use Cases

- Discovering available workflows in your deployment
- Finding a workflow ID to use with `create_run`
- Checking when workflows were last updated
- Seeing all workflows for a specific organization

### Typical Workflow

```
1. list_workflows({}) → Get all available workflows
2. Copy workflow ID from results
3. list_runs({ workflowId: "..." }) → See recent runs
4. create_run({ workflowId: "..." }) → Trigger new run
```

---

## Typical Workflow

### 1. Create

```
Agent: "Create a workflow that searches for patients and downloads their records"
↓
Uses: create_workflow
↓
Output: FSM files in ./workflows/my_workflows/patient-search/
```

### 2. Review & Edit

```
Developer: Reviews generated FSM files
↓
Edits: Adjusts message templates, adds verification states
↓
Commits: Saves changes
```

### 3. Upload

```
Agent: "Upload the patient-search workflow"
↓
Uses: update_workflow
↓
Result: Workflow available on platform
```

### 4. Execute

```
Agent: "Run the patient-search workflow for John Doe"
↓
Uses: create_run with input { PATIENT_NAME: "John Doe" }
↓
Response: runId and messageId
```

### 5. Monitor

```
Agent: "Check the status of that run"
↓
Uses: get_run_status with messageId
↓
Response: Current state and progress
```

### 6. Debug (if needed)

```
Agent: "Get the logs for that run"
↓
Uses: get_run_logs with messageId
↓
Review: Identifies issue in state "search_patient"

Agent: "Get the video recording"
↓
Uses: get_run_video with messageId
↓
Watch: Sees wrong button was clicked
```

### 7. Iterate

```
Developer: Edits FSM files to fix issue
↓
Agent: "Upload the updated workflow"
↓
Uses: update_workflow (overwrites previous version)
↓
Agent: "Run it again"
↓
Uses: create_run with same input
```

---

## Tips & Best Practices

### Creating Workflows

- **Start simple:** Get basic navigation working before adding complex logic
- **Add verification states:** Wait for UI to be ready before proceeding
- **Use descriptive IDs:** `login_to_dashboard` not `step1`
- **Set reasonable iterations:** 5-10 for most states, 15-20 for complex searches

### Running Workflows

- **Test with known data:** Use test patients/accounts first
- **Monitor first runs:** Watch logs in real-time
- **Keep inputs consistent:** Use the same test data when iterating

### Debugging

- **Check logs first:** Often faster than downloading video
- **Use artifacts for visual issues:** When logs aren't clear about what happened
- **Compare successful runs:** What was different?
- **Iterate quickly:** Small changes, frequent tests

### Organization

- **Use consistent naming:** `{org}-{app}-{action}` pattern
- **Group related workflows:** By application or use case
- **Document inputs:** Add descriptions and examples
- **Version control:** Commit FSM files to git

---

## Getting Help

### Documentation
- `.cursorrules` - Comprehensive FSM authoring guide
- `INSTALLATION.md` - Setup and troubleshooting
- `README.md` - Overview and quick start

### Support
Contact your NenAI customer engineer with:
- Tool name and parameters used
- Full error message
- Expected vs actual behavior
- Workflow ID and run ID (if applicable)

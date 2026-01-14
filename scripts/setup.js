#!/usr/bin/env node

import { writeFileSync, existsSync, mkdirSync, readFileSync } from 'fs';
import { join } from 'path';
import { homedir } from 'os';

const ENV_TEMPLATE = `# NenAI API Credentials
# Get your credentials from your customer engineer or request access at hello@nen.ai

NEN_API_KEY=
NEN_DEPLOYMENT_ID=
`;

const MCP_CONFIG_TEMPLATE = {
  mcpServers: {
    nen: {
      command: "npx",
      args: ["@nen/mcp-server"],
      cwd: process.cwd()
    }
  }
};

console.log('🚀 Setting up NenAI MCP Quickstart...\n');

// Create .env file if it doesn't exist
const envPath = '.env';
if (!existsSync(envPath)) {
  writeFileSync(envPath, ENV_TEMPLATE);
  console.log('✅ Created .env file');
  console.log('   → Edit .env and add your NEN_API_KEY and NEN_DEPLOYMENT_ID\n');
} else {
  console.log('✅ .env file already exists\n');
}

// Create workflows directory structure
const dirs = [
  'workflows',
  'workflows/my_workflows',
  'workflows/samples'
];

dirs.forEach(dir => {
  if (!existsSync(dir)) {
    mkdirSync(dir, { recursive: true });
  }
});
console.log('✅ Created workflows directories\n');

// Handle Cursor MCP configuration
const cursorConfigPath = join(homedir(), '.cursor', 'mcp.json');
let needsManualConfig = false;

if (!existsSync(cursorConfigPath)) {
  // Create new mcp.json with nen server
  writeFileSync(cursorConfigPath, JSON.stringify(MCP_CONFIG_TEMPLATE, null, 2));
  console.log(`✅ Created ${cursorConfigPath}`);
  console.log('   → NenAI MCP server configured\n');
} else {
  // Check if nen server is already configured
  try {
    const existingConfig = JSON.parse(readFileSync(cursorConfigPath, 'utf8'));
    
    if (existingConfig.mcpServers && existingConfig.mcpServers.nen) {
      console.log('✅ NenAI MCP server already configured in Cursor\n');
    } else {
      needsManualConfig = true;
      console.log('⚠️  Cursor mcp.json exists but NenAI server not configured\n');
    }
  } catch (error) {
    needsManualConfig = true;
    console.log('⚠️  Could not parse existing mcp.json\n');
  }
}

// Display next steps
console.log('📝 Next steps:\n');
console.log('1. Add your API credentials to .env file');

if (needsManualConfig) {
  console.log(`2. Add the "nen" server to ${cursorConfigPath}:\n`);
  console.log(JSON.stringify(MCP_CONFIG_TEMPLATE.mcpServers.nen, null, 2));
  console.log('\n3. Restart Cursor');
  console.log('4. Ask the AI: "Use list_runs to verify the MCP server is working"\n');
} else {
  console.log('2. Restart Cursor');
  console.log('3. Ask the AI: "Use list_runs to verify the MCP server is working"\n');
}

console.log('💡 Run "npm run verify" to check your setup\n');

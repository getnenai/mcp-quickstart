#!/usr/bin/env node

import { writeFileSync, existsSync, mkdirSync } from 'fs';
import { join } from 'path';

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

// Display MCP configuration instructions
const cursorConfigPath = join(process.env.HOME || '~', '.cursor', 'mcp.json');

console.log('📝 Next steps:\n');
console.log('1. Add your API credentials to .env file');
console.log(`2. Add this to ${cursorConfigPath}:\n`);
console.log(JSON.stringify(MCP_CONFIG_TEMPLATE, null, 2));
console.log('\n3. Restart Cursor');
console.log('4. Ask the AI: "Use list_runs to verify the MCP server is working"\n');
console.log('💡 Run "npm run verify" to check your setup\n');

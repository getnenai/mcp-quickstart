#!/usr/bin/env node

import { existsSync, readFileSync } from 'fs';
import { join } from 'path';
import { execSync } from 'child_process';

console.log('🔍 Verifying NenAI MCP Quickstart setup...\n');

let hasErrors = false;
let hasWarnings = false;

// Check Node.js version
console.log('📦 Checking Node.js version...');
const nodeVersion = process.version;
const nodeMajor = parseInt(nodeVersion.slice(1).split('.')[0]);
if (nodeMajor >= 18) {
  console.log(`   ✅ Node.js ${nodeVersion} (>= 18.0.0)\n`);
} else {
  console.log(`   ❌ Node.js ${nodeVersion} is too old. Need >= 18.0.0\n`);
  hasErrors = true;
}

// Check npm version
console.log('📦 Checking npm version...');
try {
  const npmVersion = execSync('npm --version', { encoding: 'utf8' }).trim();
  console.log(`   ✅ npm ${npmVersion}\n`);
} catch (error) {
  console.log('   ❌ npm not found\n');
  hasErrors = true;
}

// Check .env file
console.log('🔑 Checking .env file...');
const envPath = '.env';
if (!existsSync(envPath)) {
  console.log('   ❌ .env file not found\n');
  hasErrors = true;
} else {
  const envContent = readFileSync(envPath, 'utf8');
  const hasApiKey = envContent.includes('NEN_API_KEY=') && !envContent.match(/NEN_API_KEY=\s*$/m);
  const hasDeploymentId = envContent.includes('NEN_DEPLOYMENT_ID=') && !envContent.match(/NEN_DEPLOYMENT_ID=\s*$/m);
  
  if (hasApiKey && hasDeploymentId) {
    console.log('   ✅ .env file exists with credentials\n');
  } else {
    console.log('   ⚠️  .env file exists but missing credentials:');
    if (!hasApiKey) console.log('      - NEN_API_KEY is empty');
    if (!hasDeploymentId) console.log('      - NEN_DEPLOYMENT_ID is empty');
    console.log('');
    hasWarnings = true;
  }
}

// Check workflows directory
console.log('📁 Checking workflows directory...');
if (existsSync('workflows/my_workflows')) {
  console.log('   ✅ workflows/my_workflows directory exists\n');
} else {
  console.log('   ⚠️  workflows/my_workflows directory not found\n');
  hasWarnings = true;
}

// Check MCP server installation
console.log('🔌 Checking MCP server installation...');
try {
  execSync('npx @nen/mcp-server --version', { encoding: 'utf8', stdio: 'pipe' });
  console.log('   ✅ @nen/mcp-server is installed\n');
} catch (error) {
  console.log('   ⚠️  @nen/mcp-server may not be installed or accessible\n');
  hasWarnings = true;
}

// Check Cursor MCP config
console.log('🎯 Checking Cursor MCP configuration...');
const cursorConfigPath = join(process.env.HOME || '~', '.cursor', 'mcp.json');
if (existsSync(cursorConfigPath)) {
  try {
    const config = JSON.parse(readFileSync(cursorConfigPath, 'utf8'));
    if (config.mcpServers && config.mcpServers.nen) {
      const cwd = config.mcpServers.nen.cwd;
      if (cwd === process.cwd()) {
        console.log('   ✅ Cursor MCP config exists and points to this directory\n');
      } else {
        console.log(`   ⚠️  Cursor MCP config exists but cwd mismatch:`);
        console.log(`      Config: ${cwd}`);
        console.log(`      Current: ${process.cwd()}\n`);
        hasWarnings = true;
      }
    } else {
      console.log('   ⚠️  Cursor MCP config exists but missing "nen" server\n');
      hasWarnings = true;
    }
  } catch (error) {
    console.log('   ⚠️  Cursor MCP config exists but has invalid JSON\n');
    hasWarnings = true;
  }
} else {
  console.log(`   ⚠️  Cursor MCP config not found at ${cursorConfigPath}\n`);
  hasWarnings = true;
}

// Summary
console.log('═══════════════════════════════════════════════════\n');
if (hasErrors) {
  console.log('❌ Setup has errors that must be fixed\n');
  process.exit(1);
} else if (hasWarnings) {
  console.log('⚠️  Setup is mostly complete but has warnings\n');
  console.log('Next steps:');
  console.log('1. Add your NEN_API_KEY and NEN_DEPLOYMENT_ID to .env');
  console.log('2. Add MCP server config to ~/.cursor/mcp.json');
  console.log('3. Restart Cursor');
  console.log('4. Ask the AI: "Use list_runs to verify the MCP server is working"\n');
} else {
  console.log('✅ All checks passed! Your setup looks good.\n');
  console.log('Next: Ask the AI in Cursor to create a workflow:\n');
  console.log('  "Create a workflow that navigates to google.com and takes a screenshot"\n');
}

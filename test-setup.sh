#!/bin/bash
# Test script to validate MCP setup without starting Cursor

set -e

echo "🧪 Testing NenAI MCP Setup..."
echo ""

TESTS_PASSED=0
TESTS_FAILED=0

# Helper functions
pass() {
    echo "✅ $1"
    TESTS_PASSED=$((TESTS_PASSED + 1))
}

fail() {
    echo "❌ $1"
    TESTS_FAILED=$((TESTS_FAILED + 1))
}

# Test 1: Check .env exists
echo "Test 1: .env file exists"
if [ -f ".env" ]; then
    pass ".env file found"
else
    fail ".env file missing"
fi

# Test 2: Check .env has NEN_API_KEY
echo "Test 2: .env contains NEN_API_KEY"
if [ -f ".env" ] && grep -q "^NEN_API_KEY=" .env && ! grep -q "^NEN_API_KEY=$" .env && ! grep -q "^NEN_API_KEY=your_api_key" .env; then
    pass "NEN_API_KEY is set in .env"
else
    fail "NEN_API_KEY not properly set in .env"
fi

# Test 3: Check wrapper script exists
echo "Test 3: Wrapper script exists"
if [ -f "start-mcp-server.sh" ]; then
    pass "start-mcp-server.sh found"
else
    fail "start-mcp-server.sh missing"
fi

# Test 4: Check wrapper is executable
echo "Test 4: Wrapper script is executable"
if [ -x "start-mcp-server.sh" ]; then
    pass "start-mcp-server.sh is executable"
else
    fail "start-mcp-server.sh is not executable (run: chmod +x start-mcp-server.sh)"
fi

# Test 5: Check mcp.json exists
echo "Test 5: mcp.json configuration exists"
if [ -f "$HOME/.cursor/mcp.json" ]; then
    pass "~/.cursor/mcp.json found"
else
    fail "~/.cursor/mcp.json missing (run: ./setup-mcp.sh)"
fi

# Test 6: Check mcp.json references wrapper
echo "Test 6: mcp.json references wrapper script"
if [ -f "$HOME/.cursor/mcp.json" ] && grep -q "start-mcp-server.sh" "$HOME/.cursor/mcp.json"; then
    pass "mcp.json correctly references wrapper"
else
    fail "mcp.json doesn't reference wrapper (run: ./setup-mcp.sh)"
fi

# Test 7: Check mcp.json does NOT contain secrets
echo "Test 7: mcp.json does not contain API keys"
if [ -f "$HOME/.cursor/mcp.json" ] && ! grep -q "NEN_API_KEY" "$HOME/.cursor/mcp.json"; then
    pass "mcp.json does not contain secrets"
else
    fail "mcp.json contains API key! This is a security issue."
fi

# Test 8: Check node_modules exists
echo "Test 8: Dependencies installed"
if [ -d "node_modules/@nen/mcp-server" ]; then
    pass "MCP server package installed"
else
    fail "Dependencies missing (run: npm install)"
fi

# Test 9: Validate wrapper script can load .env
echo "Test 9: Wrapper script validation"
if bash -n start-mcp-server.sh 2>/dev/null; then
    pass "Wrapper script has valid syntax"
else
    fail "Wrapper script has syntax errors"
fi

# Summary
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Test Results:"
echo "  Passed: $TESTS_PASSED"
echo "  Failed: $TESTS_FAILED"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

if [ $TESTS_FAILED -eq 0 ]; then
    echo "🎉 All tests passed! Your setup is ready."
    echo ""
    echo "Next steps:"
    echo "  1. Restart Cursor (Cmd+Q or Ctrl+Q)"
    echo "  2. Ask AI: 'Use list_workflows to verify MCP server'"
    exit 0
else
    echo "⚠️  Some tests failed. Please fix the issues above."
    exit 1
fi

"""
Workflow: Test MCP Integration

Simple test workflow to verify NenAI MCP integration is working correctly.
This workflow opens a browser and navigates to a website to confirm basic functionality.
"""
from nen.workflow import agent, validate


def handler(payload: dict) -> dict:
    """
    Test workflow to verify MCP integration.
    
    Args:
        payload: Input parameters with keys:
            - WEBSITE_URL (optional): URL to navigate to (defaults to example.com)
    
    Returns:
        dict with:
            - success (bool): Whether the test was successful
            - message (str): Test result message
    """
    # Get input with default
    url = payload.get("WEBSITE_URL", "https://example.com")
    
    # Step 1: Open browser
    agent("Open Firefox")
    if not validate("Is Firefox open?", timeout=10):
        return {
            "success": False,
            "error": "Failed to open Firefox",
            "message": "MCP integration test failed at browser launch"
        }
    
    # Step 2: Navigate to URL
    agent(f"Navigate to {url}")
    if not validate(f"Is {url} loaded?", timeout=20):
        return {
            "success": False,
            "error": "Failed to load website",
            "message": "MCP integration test failed at navigation"
        }
    
    # Test successful
    return {
        "success": True,
        "message": "MCP integration test completed successfully",
        "url_visited": url
    }

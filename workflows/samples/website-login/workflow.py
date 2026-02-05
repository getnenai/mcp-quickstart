"""
Workflow: Website Login

Navigate to a website and log in with provided credentials.
A simple, reusable login workflow.
"""
from nen.workflow import agent, validate, keyboard


def handler(payload: dict) -> dict:
    """
    Log into a website with username and password.
    
    Args:
        payload: Input parameters
            - WEB_URL: URL of the website to log in to (e.g., 'https://example.com/login')
            - USERNAME: Username or email for login
            - PASSWORD: Password for login
    
    Returns:
        dict with:
            - success: bool
            - error: str (if success is False)
    """
    # Get inputs
    web_url = payload.get("WEB_URL", "")
    username = payload.get("USERNAME", "")
    password = payload.get("PASSWORD", "")
    
    if not web_url or not username or not password:
        return {
            "success": False,
            "error": "Missing required parameters: WEB_URL, USERNAME, PASSWORD"
        }
    
    # Environment Setup: Launch browser and navigate
    agent("Open Firefox or Chromium browser")
    if not validate("Is the browser open?", timeout=10):
        return {"success": False, "error": "Failed to open browser"}
    
    # Dismiss any startup popups
    agent("Close any welcome messages, popups, or dialogs if they appear", max_iterations=5)
    
    agent("Click the address bar at the top of the browser")
    keyboard.type(web_url)
    keyboard.press("Return")
    
    if not validate("Is the webpage loading or loaded?", timeout=30):
        return {"success": False, "error": f"Failed to load {web_url}"}
    
    # Authentication: Login to the website
    agent(f"Click the username or email field and type '{username}'", max_iterations=5)
    
    agent("Click the password field", max_iterations=3)
    keyboard.type(password, interval=0.01)
    
    agent("Click the Login or Sign In button", max_iterations=5)
    
    # Verify successful login
    if not validate("Is the user logged in? Look for a dashboard, profile menu, navigation sidebar, or welcome message.", timeout=30):
        return {"success": False, "error": "Login verification failed - user does not appear to be logged in"}
    
    return {
        "success": True,
        "message": f"Successfully logged into {web_url}"
    }

"""
Workflow: ezyVet Login

Logs into the ezyVet trial system at https://mybalto.usw2.trial.ezyvet.com/
with provided credentials.
"""
from nen.workflow import agent, validate, keyboard


def handler(payload: dict) -> dict:
    """
    Main workflow entry point for ezyVet login.
    
    Args:
        payload: Input parameters with keys:
            - WEBSITE_URL (optional): URL to navigate to (defaults to ezyVet trial)
            - USERNAME (required): Username for login
            - PASSWORD (required): Password for login
    
    Returns:
        dict with:
            - success (bool): Whether login was successful
            - error (str, optional): Error message if failed
    """
    # Get inputs with defaults
    url = payload.get("WEBSITE_URL", "https://mybalto.usw2.trial.ezyvet.com/")
    username = payload.get("USERNAME", "sample_username")
    password = payload.get("PASSWORD", "sample_password")
    
    # Step 1: Open browser and navigate
    agent("Open Firefox")
    if not validate("Is Firefox open?", timeout=10):
        return {"success": False, "error": "Failed to open Firefox"}
    
    agent(f"Navigate to {url}")
    if not validate("Is the login page loaded?", timeout=20):
        return {"success": False, "error": "Failed to load login page"}
    
    # Step 2: Enter credentials
    agent("Click the username field")
    keyboard.type(username)
    
    agent("Click the password field")
    keyboard.type(password, interval=0.01)
    
    # Step 3: Submit login
    agent("Click the login or sign in button")
    
    # Step 4: Verify login success
    if validate("Is the user logged in? Look for a dashboard or profile menu.", timeout=30):
        return {"success": True, "message": "Successfully logged into ezyVet"}
    else:
        return {"success": False, "error": "Login failed - could not verify dashboard"}

"""
Workflow: Website Login - Custom

Generic website login workflow that navigates to any website login page,
enters credentials, and verifies successful authentication.
"""
from nen.workflow import agent, validate, keyboard
import logging


def handler(payload: dict) -> dict:
    """
    Main workflow entry point for generic website login.
    
    Args:
        payload: Input parameters with keys:
            - WEBSITE_URL (required): URL of the website login page
            - USERNAME (required): Username or email for login
            - PASSWORD (required): Password for the account
    
    Returns:
        dict with:
            - success (bool): Whether login was successful
            - message (str): Status message
            - error (str, optional): Error message if failed
    """
    # Validate required inputs
    if "WEBSITE_URL" not in payload:
        return {"success": False, "error": "WEBSITE_URL is required"}
    if "USERNAME" not in payload:
        return {"success": False, "error": "USERNAME is required"}
    if "PASSWORD" not in payload:
        return {"success": False, "error": "PASSWORD is required"}
    
    # Get inputs
    url = payload["WEBSITE_URL"]
    username = payload["USERNAME"]
    password = payload["PASSWORD"]
    
    logging.info("Starting website login workflow", extra={
        "url": url,
        "username": username,
        "password": "***REDACTED***"
    })
    
    # Phase 1: Environment Setup - Launch browser
    logging.info("Phase 1: Launching Firefox browser")
    agent("Find and click the Firefox icon to launch the browser.", max_iterations=10)
    
    if not validate("Is Firefox open?", timeout=10):
        return {"success": False, "error": "Failed to launch Firefox"}
    
    # Dismiss any initial popups
    agent("Close any welcome screens, popups, banners, or dialogs that may appear. Press Escape or click X buttons as needed.", max_iterations=5)
    
    # Phase 2: Navigation - Navigate to login page
    logging.info("Phase 2: Navigating to login page", extra={"url": url})
    agent("Click the address bar at the top of the Firefox browser window to focus it.", max_iterations=5)
    
    keyboard.type(url)
    keyboard.press("Return")
    
    # Wait for login page to load with popup handling
    if not validate("Is the login page visible with username and password fields?", timeout=30):
        # Try dismissing page popups and check again
        agent("Close any cookie banners, popups, or dialogs by clicking X, 'Accept', 'Decline', or pressing Escape.", max_iterations=5)
        
        if not validate("Is the login page visible with username and password fields?", timeout=10):
            return {"success": False, "error": "Failed to load login page"}
    
    logging.info("Login page loaded successfully")
    
    # Phase 3: Authentication - Enter credentials
    logging.info("Phase 3: Entering credentials")
    
    # Find and click username field
    agent("Find the username or email input field and click it to focus.", max_iterations=8)
    keyboard.type(username)
    
    # Find and click password field
    agent("Find the password input field and click it to focus.", max_iterations=8)
    keyboard.type(password, interval=0.01)  # Use slower typing for password
    
    # Find and click login button
    agent("Find the login, sign in, or submit button and click it.", max_iterations=8)
    
    logging.info("Login credentials submitted")
    
    # Phase 4: Verification - Verify login success
    logging.info("Phase 4: Verifying login success")
    
    if not validate("Is the user successfully logged in? Can you see a dashboard, profile icon, user menu, or other indication of successful authentication?", timeout=30):
        # Check for error messages
        agent("Check if there are any error messages or if login failed. Take a screenshot if you see an error.", max_iterations=3)
        
        # Try validation one more time
        if not validate("Is the user successfully logged in? Can you see a dashboard, profile icon, user menu, or other indication of successful authentication?", timeout=10):
            return {
                "success": False,
                "error": "Login failed - could not verify successful authentication"
            }
    
    logging.info("Login successful - user authenticated")
    
    # Verify user is still logged in
    if not validate("Is the user still logged in with the dashboard or profile visible?"):
        return {
            "success": False,
            "error": "Login verification failed - user session may have expired"
        }
    
    # Success
    return {
        "success": True,
        "message": f"Successfully logged into {url}",
        "url": url,
        "username": username
    }

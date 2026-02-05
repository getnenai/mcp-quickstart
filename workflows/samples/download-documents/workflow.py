"""
Workflow: Download Documents

Navigate to patient profile and download all documents to /artifacts directory.
"""
import json
import os
from nen.workflow import agent, validate, keyboard


def handler(payload: dict) -> dict:
    """
    Download all documents for a specific patient.
    
    Args:
        payload: Input parameters
            - PATIENT_NAME: Patient name to search for
            - LOGIN_EMAIL: Login email address
            - LOGIN_PASSWORD: Login password
    
    Returns:
        dict with:
            - success: bool
            - documents_downloaded: int (number of PDFs downloaded)
            - error: str (if success is False)
    """
    # Get inputs
    patient_name = payload.get("PATIENT_NAME", "")
    login_email = payload.get("LOGIN_EMAIL", "")
    login_password = payload.get("LOGIN_PASSWORD", "")
    
    if not patient_name or not login_email or not login_password:
        return {
            "success": False,
            "error": "Missing required parameters: PATIENT_NAME, LOGIN_EMAIL, LOGIN_PASSWORD"
        }
    
    # Clear previous downloads
    os.system("rm -f /artifacts/*.pdf 2>/dev/null")
    
    # Environment Setup: Launch browser and navigate
    agent("Open Firefox browser")
    if not validate("Is Firefox open?", timeout=10):
        return {"success": False, "error": "Failed to open Firefox"}
    
    agent("Click the address bar at the top of the browser")
    keyboard.type("https://app.example.com")
    keyboard.press("Return")
    
    if not validate("Is the webpage loading or loaded?", timeout=30):
        return {"success": False, "error": "Failed to load application URL"}
    
    # Authentication: Login to the application
    agent(f"If a login page is visible, enter email '{login_email}' in the email field, enter the password in the password field, then click the login button. If already logged in, do nothing.", max_iterations=15)
    
    if not validate("Is the user logged in? Look for a main navigation menu or dashboard.", timeout=30):
        return {"success": False, "error": "Failed to log in"}
    
    # Patient Search: Find the target patient
    agent("Find and click on 'Patients' or 'Clients' in the navigation menu", max_iterations=10)
    
    if not validate("Is the patients page visible with a search field?", timeout=15):
        return {"success": False, "error": "Could not navigate to patients section"}
    
    agent(f"Find the search field and type '{patient_name}'. Wait for search results to appear.", max_iterations=10)
    
    # Verify exactly one patient found
    if not validate(f"Is there exactly one patient result matching '{patient_name}'?", timeout=10):
        agent("Clear the search field and try searching again", max_iterations=3)
        if not validate(f"Is there exactly one patient result matching '{patient_name}'?", timeout=10):
            return {"success": False, "error": f"Could not find unique patient match for '{patient_name}'"}
    
    agent(f"Click on the patient '{patient_name}' to open their profile", max_iterations=5)
    
    if not validate("Is the patient profile page open?", timeout=15):
        return {"success": False, "error": "Failed to open patient profile"}
    
    # Download: Download all documents
    agent("Look for a 'Documents', 'Files', or 'Attachments' tab or section. Click on it.", max_iterations=10)
    
    if not validate("Is the documents section visible?", timeout=15):
        return {"success": False, "error": "Could not find documents section"}
    
    agent("""For each document/PDF visible:
1. Click on the document or download button
2. If a download dialog appears, click Save or Download
3. Wait for download to complete
4. Move to the next document

Repeat until all documents are downloaded.""", max_iterations=30)
    
    # Verify downloads completed
    if not validate("Have all visible documents been downloaded?", timeout=60):
        return {"success": False, "error": "Not all documents were downloaded"}
    
    # Count downloaded PDFs
    result = os.popen("ls /artifacts/*.pdf 2>/dev/null | wc -l").read().strip()
    num_docs = int(result) if result.isdigit() else 0
    
    if num_docs == 0:
        return {"success": False, "error": "No PDF documents were downloaded to /artifacts"}
    
    return {
        "success": True,
        "documents_downloaded": num_docs,
        "message": f"Successfully downloaded {num_docs} document(s)"
    }

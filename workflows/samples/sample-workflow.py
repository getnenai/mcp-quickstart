"""
Workflow: SDK Primitives Test

This workflow demonstrates the nen.workflow SDK primitives.
Modify this file to build your automation workflow.
"""
from nen.workflow import agent, validate, extract, keyboard, mouse


def run(input: dict) -> dict:
    """
    Main workflow entry point.

    Args:
        input: Input parameters passed when the workflow is executed.
               Access variables like: input.get("WEBSITE_URL", "https://example.com")

    Returns:
        dict: Results to return from the workflow execution.
    """
    # Get input variables from payload
    website_url = input.get("WEBSITE_URL", "https://news.ycombinator.com")
    title_number = input.get("TITLE_NUMBER")


    # Use natural language to control the computer
    agent(f"Open Firefox and navigate to {website_url}")

    # Validate that we reached the expected state
    if not validate("Is the website loaded in the browser?"):
        return {"success": False, "error": "Failed to load website"}

    # Extract structured data from the screen
    result = extract(
        f"What is the title of the {title_number}th post on the page?",
        schema={
            "type": "object",
            "properties": {
                "title": {"type": "string"}
            },
            "required": ["title"]
        }
    )

    return {
        "success": True,
        "title": result.get("title"),
    }

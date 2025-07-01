import os
import requests
import azure.functions as func

def main(name: str) -> str:
    github_token = os.environ["GITHUB_TOKEN"]
    github_org = os.environ.get("GITHUB_ORG", "your-org")

    headers = {
        "Authorization": f"token {github_token}",
        "Accept": "application/vnd.github.v3+json"
    }

    repo_name = f"{name}-repo"
    response = requests.post(
        f"https://api.github.com/orgs/{github_org}/repos",
        headers=headers,
        json={
            "name": repo_name,
            "private": True,
            "auto_init": True
        }
    )

    if response.status_code == 201:
        return f"GitHub repository {repo_name} created."
    else:
        raise Exception(f"Failed to create repo: {response.status_code} - {response.text}")
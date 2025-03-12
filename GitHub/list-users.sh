#!/bin/bash

##################################
#About:
# This script retrieves a list of all users who have access to a specified GitHub repository.
# It uses the GitHub API to fetch collaborators or team members based on repository permissions
# Requires a GitHub personal access token (PAT) with the necessary permissions.
#
########
# Setup Instructions:
# Before executing the script, you need to set up your GitHub credentials using environment variables.
# Run the following commands in your terminal to export your GitHub username and personal access token:
#
# export GITHUB_USERNAME="your_github_username"
# export GITHUB_TOKEN="your_personal_access_token"
#
# These variables will be used for authentication when making API requests to GitHub.
# Ensure your token has the necessary permissions (e.g., 'repo' for private repositories or 'read:org' for organizations).
#######
#
#Owner: Amiya Kumar Nayak
#GitHub: AmiyaNix
#
###################################

# Helper function to validate command-line arguments
function helper {
    expected_cmd_args=2
    if [ "$#" -ne "$expected_cmd_args" ]; then
        echo "Please execute the script with the required command-line arguments."
        exit 1
    fi
}

# Validate command-line arguments before execution
helper "$@"

# GitHub API URL
API_URL="https://api.github.com"


# GitHub username and personal access token
USERNAME=$username
TOKEN=$token

# User and Repository information
REPO_OWNER=$1
REPO_NAME=$2

# Function to make a GET request to the GitHub API
function github_api_get {
    local endpoint="$1"
    local url="${API_URL}/${endpoint}"

    # Send a GET request to the GitHub API with authentication
    curl -s -u "${USERNAME}:${TOKEN}" "$url"
}

# Function to list users with read access to the repository
function list_users_with_read_access {
    local endpoint="repos/${REPO_OWNER}/${REPO_NAME}/collaborators"

    # Fetch the list of collaborators on the repository
    collaborators="$(github_api_get "$endpoint" | jq -r '.[] | select(.permissions.pull == true) | .login')"

    # Display the list of collaborators with read access
    if [[ -z "$collaborators" ]]; then
        echo "No users with read access found for ${REPO_OWNER}/${REPO_NAME}."
    else
        echo "Users with read access to ${REPO_OWNER}/${REPO_NAME}:"
        echo "$collaborators"
    fi
}



# Main script
echo "Listing users with read access to ${REPO_OWNER}/${REPO_NAME}..."
list_users_with_read_access

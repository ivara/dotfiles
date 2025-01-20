#!/bin/bash

# Ensure you are in a Git repository
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    echo "Not inside a Git repository. Exiting."
    exit 1
fi

# Get the current Git branch
current_branch=$(git symbolic-ref --short HEAD)
if [ -z "$current_branch" ]; then
    echo "Could not determine the current branch. Exiting."
    exit 1
fi

echo "Current branch: $current_branch"

# Get the Git repository URL (origin URL) and extract the repo name
repo_url=$(git remote get-url origin)
# repo_name=$(basename -s .git "$repo_url")
repo_name="Lernia.Se.Mono"
echo "Current repo url: $repo_url"
echo "Current repo name: $repo_repo_name"
# Set your Azure DevOps organization and project
ORG_NAME="activesolution"
PROJECT_NAME="lernia"

# Fetch the list of pipelines that are associated with the current repository
# We will use the `az pipelines list` command and filter by repository name
pipelines=$(az pipelines list --org "https://dev.azure.com/$ORG_NAME" --project "$PROJECT_NAME" --query "[?repository.name=='$repo_name'].{id:id, name:name}" -o tsv)

# Check if we have any pipelines associated with this repository
if [ -z "$pipelines" ]; then
    echo "No pipelines found for repository $repo_name. Exiting."
    exit 1
fi

# Use FZF to let the user select a pipeline
selected_pipeline=$(echo "$pipelines" | fzf --height=20% --border --preview 'echo {}' | awk '{print $1}')

# Check if a pipeline was selected
if [ -z "$selected_pipeline" ]; then
    echo "No pipeline selected. Exiting."
    exit 1
fi

# Trigger the selected pipeline with the current branch
echo "Triggering pipeline $selected_pipeline for branch $current_branch..."

# Trigger the build pipeline for the selected pipeline and the current branch
az pipelines run --org "https://dev.azure.com/$ORG_NAME" --project "$PROJECT_NAME" --id "$selected_pipeline" --branch "$current_branch"

echo "Build triggered successfully!"


#!/bin/bash

# Make sure BETA-PRIME is cloned directly inside /opt/stacks

# Define your repository path on the server
REPO_PATH="/opt/stacks/BETA-PRIME" 

# Navigate to the repository directory
cd "$REPO_PATH" || exit

# Pull the latest changes from the main branch
git pull origin main

# Loop through each stack directory and redeploy
for STACK_DIR in "$REPO_PATH"/*/; do
  if [ -d "$STACK_DIR" ]; then
    STACK_NAME=$(basename "$STACK_DIR")
    echo "Updating stack: $STACK_NAME"
    cd "$STACK_DIR" || continue
    docker compose up -d --build --force-recreate
    cd "$REPO_PATH" # Go back to repo root for next iteration
  fi
done

echo "Deployment complete!"
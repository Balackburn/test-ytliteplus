#!/bin/bash

# Variables (Replace these with your GitHub username and email)
GITHUB_USER="your-github-username"
REPO_NAME="test-ytliteplus"

# Create a new local git repository
git init

# Add all files to the git repository
git add .

# Commit changes
git commit -m "Initial commit for Vite project"

# Create a new repository on GitHub using gh CLI
gh repo create $REPO_NAME --public --source=. --remote=origin --push

# Add vite.config.js file for proper GitHub Pages setup
cat <<EOT >> vite.config.ts
import { defineConfig } from 'vite'

export default defineConfig({
  base: '/$REPO_NAME/', // base URL for GitHub Pages
  plugins: [],
})
EOT

# Commit the vite.config.ts
git add vite.config.ts
git commit -m "Added Vite config for GitHub Pages"

# Push the updated files
git push origin main

# Set up GitHub Pages for the repository
gh repo edit --add-topic github-pages
gh pages set-up --branch=main --dist=dist

# Build the project (vite or bun depending on your preference)
npm install
npm run build

# Deploy to GitHub Pages
gh pages deploy --source dist --branch=gh-pages --message "Deployed to GitHub Pages"

# Success message
echo "Project has been created, pushed to GitHub, and deployed to GitHub Pages!"
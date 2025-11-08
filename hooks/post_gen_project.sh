#!/usr/bin/env bash
set -euo pipefail

# Install tools using Homebrew (avoids externally managed environment issues)
if ! command -v uv &> /dev/null; then
    brew install uv
fi

if ! command -v pre-commit &> /dev/null; then
    brew install pre-commit
fi

if ! command -v hatch &> /dev/null; then
    brew install hatch
fi

# Install git-flow if not available
if ! git flow version &> /dev/null; then
    brew install git-flow-avh
fi

# Ensure Python is available for git-flow (pyenv compatibility)
if command -v pyenv &> /dev/null; then
    # Set a global Python version if none is set
    if ! pyenv global &> /dev/null || [ "$(pyenv global)" = "system" ]; then
        # Use the latest available Python 3 version
        latest_python=$(pyenv versions --bare | grep "^3\." | sort -V | tail -1)
        if [ -n "$latest_python" ]; then
            pyenv global "$latest_python"
        fi
    fi
    # Ensure pyenv is properly initialized
    eval "$(pyenv init -)"
fi

git init --initial-branch=main

if [ "{{ cookiecutter.remote_origin_url }}" != "https://git@github.com:user_name/repository_name.git" ]; then
  git remote add origin "{{ cookiecutter.remote_origin_url }}"
fi

pre-commit install
cp .githooks/post-checkout .git/hooks/post-checkout
chmod +x .git/hooks/post-checkout
echo "Custom post-checkout hook installed into .git/hooks."

git add .
git commit -m 'Initializing project.' --no-verify

# Tell git-flow to use main/develop, tag prefix v
git config --local gitflow.branch.master main
git config --local gitflow.branch.develop develop
git config --local gitflow.prefix.versiontag v

# Initialize git-flow with error handling
if ! git flow init -d -f; then
    echo "Warning: git-flow initialization failed. You may need to run 'git flow init' manually."
    echo "This could be due to Python/pyenv configuration issues."
    # Create develop branch manually as fallback
    git checkout -b develop 2>/dev/null || true
    git checkout main 2>/dev/null || true
fi

if [ "{{ cookiecutter.force_push_to_remote }}" = "Y" ] && [ "{{ cookiecutter.remote_origin_url }}" != "https://git@github.com:user_name/repository_name.git" ]; then
    # Force push the main branch if a valid remote URL is provided and force_push_to_remote is enabled.
    git push -u origin main --force
    git push -u origin develop --force || true
fi
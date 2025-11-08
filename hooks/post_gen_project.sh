#!/usr/bin/env bash
set -euo pipefail

pip3 install -q uv
uv pip install -q pre-commit hatch

git init --initial-branch=main

if [ "{{ cookiecutter.remote_origin_url }}" != "https://git@github.com:user_name/repository_name.git" ]; then
  git remote add origin "{{ cookiecutter.remote_origin_url }}"
fi

uv run pre-commit install
cp .githooks/post-checkout .git/hooks/post-checkout
chmod +x .git/hooks/post-checkout
echo "Custom post-checkout hook installed into .git/hooks."

git add .
git commit -m 'Initializing project.' --no-verify

# Tell git-flow to use main/develop, tag prefix v
git config --local gitflow.branch.master main
git config --local gitflow.branch.develop develop
git config --local gitflow.prefix.versiontag v
git flow init -d -f

if [ "{{ cookiecutter.force_push_to_remote }}" = "Y" ] && [ "{{ cookiecutter.remote_origin_url }}" != "https://git@github.com:user_name/repository_name.git" ]; then
    # Force push the main branch if a valid remote URL is provided and force_push_to_remote is enabled.
    git push -u origin main --force
    git push -u origin develop --force || true
fi
#!/usr/bin/env bash
set -euo pipefail

GITHUB_REPO="jazzsequence/claude-skill-pantheon-docs-writer"
MARKETPLACE_KEY="pantheon-docs-writer"
PLUGIN_KEY="jazzsequence-skills@pantheon-docs-writer"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo "Installing Claude Skill: Pantheon Docs Writer..."
echo ""

if ! command -v claude &>/dev/null; then
  echo -e "${RED}Error:${NC} Claude Code CLI is required but not installed."
  echo "Install it from https://claude.ai/code"
  exit 1
fi

if claude plugin marketplace list 2>/dev/null | grep -q "$MARKETPLACE_KEY"; then
  echo -e "${YELLOW}Marketplace already registered.${NC} Updating..."
  claude plugin marketplace update "$MARKETPLACE_KEY" 2>&1
else
  echo "Registering marketplace..."
  claude plugin marketplace add "$GITHUB_REPO" 2>&1
fi

echo -e "${GREEN}✓${NC} Marketplace registered: $MARKETPLACE_KEY"

if claude plugin list 2>/dev/null | grep -q "$PLUGIN_KEY"; then
  echo -e "${YELLOW}Plugin already installed.${NC} Updating..."
  claude plugin update "$PLUGIN_KEY" 2>&1
else
  echo "Installing plugin..."
  claude plugin install "$PLUGIN_KEY" 2>&1
fi

echo -e "${GREEN}✓${NC} Plugin installed: $PLUGIN_KEY"
echo ""
echo "Start a new Claude Code session to use /jazzsequence-skills:pantheon-docs-writer"
echo "To update later: claude plugin update $PLUGIN_KEY"

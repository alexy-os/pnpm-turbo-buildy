#!/bin/bash

# Get all arguments after the command
components=("$@")

# Navigate to the root directory of the repository
cd "$(git rev-parse --show-toplevel)" || exit

# First, we install components through shadcn
bun x shadcn@latest add --cwd packages/ui "${components[@]}"

# Then we run the script to fix imports
bun scripts/replaceImport/fix-imports.ts "${components[@]}" 
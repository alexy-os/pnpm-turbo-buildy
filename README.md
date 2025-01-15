# Bun Monorepo with Next.js and shadcn/ui

## Overview
A modern monorepo setup powered by Bun runtime, featuring a Next.js application with shadcn/ui components. This architecture provides a scalable and maintainable structure for building enterprise-grade web applications.

## Installation
```bash
# Clone into current directory
git clone https://github.com/alexy-os/bunjs-monorepo-next-shadcn-ui.git .

# Install dependencies
bun install
```

## Development
```bash
bun run dev
```

## Build
```bash
bun run build
```

## Start
```bash
bun run start
```

## Tech Stack
- **Runtime & Package Manager**: Bun
- **Framework**: Next.js 14+
- **UI Components**: shadcn/ui
- **Styling**: Tailwind CSS
- **Type Safety**: TypeScript

## Repository Structure
```
├── apps/
│   └── web/                 # Next.js application
│       ├── src/            # Application source code
│       └── next.config.js   # Next.js configuration
├── packages/
│   └── ui/                  # Shared UI components library
│       ├── src/            # UI components source
│       ├── next.config.js   # Required for shadcn/ui initialization
│       ├── components.json  # shadcn/ui configuration
│       └── package.json     # UI package configuration
├── package.json            # Root package configuration
└── tsconfig.json          # TypeScript configuration with path aliases
```

## Dependencies Management
The project uses a workspace-based monorepo structure with centralized dependency management:

### Root Dependencies
- All shared dependencies are installed in the root `node_modules`
- No duplicate dependencies across packages
- Managed through workspace hoisting

### Workspace Setup
```json
// package.json
{
  "workspaces": [
    "apps/*",
    "packages/*"
  ]
}
```

### Local Package References
```json
// apps/web/package.json
{
  "dependencies": {
    "@turbo-buildy/ui": "workspace:*"
  }
}
```

## Initial Setup
1. **Create Base Structure**
```bash
mkdir apps packages
mkdir apps/web packages/ui
```

2. **Configure Package Files**
> packages/ui/package.json
```json
{
  "name": "@turbo-buildy/ui",
  "exports": {
    ".": { "import": "./src/index.ts" },
    "./*": "./src/components/ui/*.tsx",
    "./lib/utils": "./src/lib/utils.ts"
  }
}
```

3. **Initialize shadcn/ui**
```bash
# Initialize shadcn/ui
bun run ui:init

# Add components
bun run ui:add button
```

## Path Aliases Usage
```typescript
// Import UI components
import { Button } from "@turbo-buildy/ui/button";
import { cn } from "@turbo-buildy/ui/lib/utils";

// Import from web application
import { Component } from "@web/components";
```

## Scripts
```json
{
  "scripts": {
    "dev": "bun run --cwd apps/web dev",
    "build": "bun run build:packages && bun run build:apps",
    "ui:init": "bun x shadcn@latest init --cwd packages/ui",
    "ui:add": "bun x shadcn@latest add --cwd packages/ui"
  }
}
```

## Best Practices
- Use workspace dependencies with `workspace:*`
- Keep shared dependencies in root package.json
- Use proper exports in packages/ui/package.json
- Maintain clear separation between app and UI package

## Common Issues & Solutions
- Only `.bin` directory is created in local `node_modules` - this is expected behavior
- Dependencies are hoisted to root `node_modules`
- Use `bunx` for running local binaries

## Requirements
- Bun 1.0+
- Node.js 18+
- TypeScript 5.3+
- Next.js 14+

## License
MIT

## TypeScript Configuration
The project uses a multi-level TypeScript configuration to handle both the UI library and Next.js application:

### Root Configuration
```json
// tsconfig.json
{
  "compilerOptions": {
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "baseUrl": ".",
    "paths": {
      "@turbo-buildy/ui": ["packages/ui/src"],
      "@turbo-buildy/ui/*": ["packages/ui/src/*"],
      "@web": ["apps/web/src"],
      "@web/*": ["apps/web/src/*"]
    }
  }
}
```

### UI Package Configuration
```json
// packages/ui/tsconfig.json
{
  "compilerOptions": {
    "jsx": "react-jsx",
    "moduleResolution": "node",
    "isolatedModules": true,
    "paths": {
      "@turbo-buildy/ui/*": ["./src/*"]
    }
  }
}
```

### Next.js App Configuration
```json
// apps/web/tsconfig.json
{
  "compilerOptions": {
    "jsx": "preserve",  // Required for Next.js
    "plugins": [
      {
        "name": "next"
      }
    ],
    "paths": {
      "@/*": ["./src/*"],
      "@turbo-buildy/ui": ["../../packages/ui/src"],
      "@turbo-buildy/ui/*": ["../../packages/ui/src/*"]
    }
  }
}
```

### TypeScript Setup Notes
- Root config provides base paths for monorepo
- UI package uses `react-jsx` for optimal component compilation
- Next.js app uses `preserve` for SSR optimization
- Path aliases are configured at each level for proper module resolution
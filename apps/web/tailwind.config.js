const sharedConfig = require("@turbo-buildy/ui/tailwind.config");

/** @type {import('tailwindcss').Config} */
module.exports = {
  ...sharedConfig,
  content: [
    "./src/**/*.{ts,tsx,mdx}",
    "../../packages/ui/src/components/**/*.{ts,tsx,mdx}",
  ],
}; 
#!/usr/bin/env node
/**
 * Design-side export: turn the W3C DTCG source (tokens/design-tokens.json)
 * into consumer-friendly artifacts, no third-party deps required.
 *
 *   node tools/export-tokens.mjs           # write tokens/build/*
 *
 * Outputs (gitignored build artifacts):
 *   tokens/build/tokens.flat.json  flat "group.name.variant": value map
 *   tokens/build/variables.css     :root CSS custom properties (light + dark)
 *
 * The source file is already DTCG-formatted, so Tokens Studio (Figma) and
 * Style Dictionary can also consume tokens/design-tokens.json directly; see
 * tokens/style-dictionary.config.json.
 */
import fs from 'node:fs';
import path from 'node:path';
import process from 'node:process';
import { fileURLToPath } from 'node:url';
import { tokens } from './design-system.mjs';

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');
const outDir = path.join(root, 'tokens/build');

function flatten() {
  const flat = {};
  // Colors (with light/dark and brand overrides).
  for (const [name, token] of Object.entries(tokens.color)) {
    flat[`color.${name}.light`] = token.$value.light;
    flat[`color.${name}.dark`] = token.$value.dark;
    const brands = token.$extensions?.brands;
    if (brands) {
      for (const [brand, value] of Object.entries(brands)) {
        flat[`color.${name}.${brand}.light`] = value.light;
        flat[`color.${name}.${brand}.dark`] = value.dark;
      }
    }
  }
  // Simple dimension groups.
  for (const group of ['space', 'radius', 'icon']) {
    for (const [name, token] of Object.entries(tokens[group])) {
      if (name.startsWith('$')) continue;
      flat[`${group}.${name}`] = token.$value;
    }
  }
  // Sizes (scalar or comfortable/compact).
  for (const [name, token] of Object.entries(tokens.size)) {
    if (name.startsWith('$')) continue;
    const value = token.$value;
    if (typeof value === 'string') {
      flat[`size.${name}`] = value;
    } else {
      flat[`size.${name}.comfortable`] = value.comfortable;
      flat[`size.${name}.compact`] = value.compact;
    }
  }
  // Typography.
  flat['font.family'] = tokens.font.family.$value;
  for (const [name, token] of Object.entries(tokens.font)) {
    if (name.startsWith('$') || name === 'family') continue;
    flat[`font.${name}.fontSize`] = token.$value.fontSize;
    flat[`font.${name}.lineHeight`] = token.$value.lineHeight;
    flat[`font.${name}.fontWeight`] = token.$value.fontWeight;
  }
  // Motion.
  for (const [name, token] of Object.entries(tokens.motion)) {
    flat[`motion.${name}`] = token.$value;
  }
  return flat;
}

function cssVariables() {
  const light = [];
  const dark = [];
  for (const [name, token] of Object.entries(tokens.color)) {
    const kebab = name.replace(/[A-Z]/g, (c) => `-${c.toLowerCase()}`);
    light.push(`  --ds-color-${kebab}: ${token.$value.light};`);
    dark.push(`  --ds-color-${kebab}: ${token.$value.dark};`);
  }
  for (const group of ['space', 'radius', 'icon']) {
    for (const [name, token] of Object.entries(tokens[group])) {
      if (name.startsWith('$')) continue;
      light.push(`  --ds-${group}-${name}: ${token.$value};`);
    }
  }
  return `:root {\n${light.join('\n')}\n}\n\n@media (prefers-color-scheme: dark) {\n  :root {\n${dark.map((l) => `  ${l}`).join('\n')}\n  }\n}\n`;
}

function generate() {
  fs.mkdirSync(outDir, { recursive: true });
  fs.writeFileSync(path.join(outDir, 'tokens.flat.json'), `${JSON.stringify(flatten(), null, 2)}\n`);
  fs.writeFileSync(path.join(outDir, 'variables.css'), cssVariables());
  console.log('Exported tokens/build/tokens.flat.json and variables.css');
}

if (process.argv[1] && path.resolve(process.argv[1]) === fileURLToPath(import.meta.url)) {
  generate();
}

export { flatten, cssVariables };

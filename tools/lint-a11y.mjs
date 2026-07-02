#!/usr/bin/env node
/**
 * Accessibility guard: icon-only tappable elements must expose a label.
 *
 * Flags a `SymbolGlyph(...)` / `Image(...)` attribute chain that has its own
 * `.onClick(` but no `.accessibilityText(`. Icons that rely on a parent's
 * onClick (no onClick in their own chain) are not flagged.
 *
 *   node tools/lint-a11y.mjs            # scan component sources
 *   node tools/lint-a11y.mjs path ...   # scan explicit files/dirs
 */
import fs from 'node:fs';
import path from 'node:path';
import process from 'node:process';
import { fileURLToPath } from 'node:url';

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');
const defaultRoots = ['library/src/main/ets/components'];

function listEtsFiles(target) {
  const abs = path.isAbsolute(target) ? target : path.join(root, target);
  if (!fs.existsSync(abs)) return [];
  if (fs.statSync(abs).isFile()) return abs.endsWith('.ets') ? [abs] : [];
  const out = [];
  for (const entry of fs.readdirSync(abs)) {
    if (entry === 'build' || entry === 'oh_modules' || entry === 'node_modules') continue;
    out.push(...listEtsFiles(path.join(abs, entry)));
  }
  return out;
}

function scanFile(file) {
  const lines = fs.readFileSync(file, 'utf8').split('\n');
  const findings = [];
  for (let i = 0; i < lines.length; i++) {
    if (!/\b(SymbolGlyph|Image)\s*\(/.test(lines[i])) continue;
    const chain = [lines[i].trim()];
    let k = i + 1;
    while (k < lines.length && lines[k].trim().startsWith('.')) {
      chain.push(lines[k].trim());
      k++;
    }
    const text = chain.join('\n');
    if (text.includes('.onClick(') && !text.includes('.accessibilityText(')) {
      findings.push({ file: path.relative(root, file), line: i + 1, text: chain[0] });
    }
  }
  return findings;
}

function main() {
  const targets = process.argv.slice(2);
  const roots = targets.length > 0 ? targets : defaultRoots;
  const files = roots.flatMap(listEtsFiles);
  const findings = files.flatMap(scanFile);
  if (findings.length > 0) {
    console.error('Icon buttons missing .accessibilityText(...):\n');
    for (const f of findings) {
      console.error(`  ${f.file}:${f.line}  ${f.text}`);
    }
    console.error(`\n${findings.length} issue(s). Add .accessibilityText($r('app.string...')).`);
    process.exit(1);
  }
  console.log(`A11y check passed. Scanned ${files.length} component file(s).`);
}

if (process.argv[1] && path.resolve(process.argv[1]) === fileURLToPath(import.meta.url)) {
  main();
}

export { scanFile };

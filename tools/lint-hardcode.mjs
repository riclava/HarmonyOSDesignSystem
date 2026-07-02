#!/usr/bin/env node
/**
 * Golden-rule guard: no hardcoded design values in ArkUI code.
 *
 * Every color / font size / spacing / radius / shadow / motion value must come
 * from `Token.*`. This scanner fails CI when it finds literal design values in
 * `.ets` component/app code so the rule is enforced by a gate, not by review.
 *
 * Usage:
 *   node tools/lint-hardcode.mjs            # scan default source roots
 *   node tools/lint-hardcode.mjs path ...   # scan explicit files/dirs
 */
import fs from 'node:fs';
import path from 'node:path';
import process from 'node:process';
import { fileURLToPath } from 'node:url';

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');

// Default roots to scan.
const defaultRoots = [
  'library/src/main/ets/components',
  'showcase/entry/src/main/ets'
];

// Files that legitimately hold raw values (generated / canonical sources).
const allowFiles = new Set([
  path.join(root, 'library/src/main/ets/theme/Tokens.ets')
]);

// Rules: each matches a hardcoded design value on a code line.
const rules = [
  {
    id: 'hardcoded-hex-color',
    // #RGB / #RRGGBB / #RRGGBBAA color literals anywhere in the line.
    re: /#[0-9A-Fa-f]{3}(?:[0-9A-Fa-f]{1})?(?:[0-9A-Fa-f]{2})?(?:[0-9A-Fa-f]{2})?\b/,
    test: (line) => /['"]#[0-9A-Fa-f]{3,8}['"]/.test(line),
    hint: 'Use Token.color.*() instead of a literal hex color.'
  },
  {
    id: 'hardcoded-font-size',
    test: (line) => /\.fontSize\(\s*\d/.test(line),
    hint: 'Use Token.font.*.size / .sizeFor(this.compact).'
  },
  {
    id: 'hardcoded-font-weight',
    test: (line) => /\.fontWeight\(\s*\d/.test(line),
    hint: 'Use Token.font.*.weight (numeric weights are not allowed).'
  },
  {
    id: 'hardcoded-line-height',
    test: (line) => /\.lineHeight\(\s*\d/.test(line),
    hint: 'Use Token.font.*.lineHeight / .lineHeightFor(this.compact).'
  },
  {
    id: 'hardcoded-padding',
    test: (line) => /\.padding\(\s*\d/.test(line),
    hint: 'Use Token.space.* (wrap with LengthMetrics.vp for start/end).'
  },
  {
    id: 'hardcoded-margin',
    test: (line) => /\.margin\(\s*\d/.test(line),
    hint: 'Use Token.space.* (wrap with LengthMetrics.vp for start/end).'
  },
  {
    id: 'hardcoded-radius',
    test: (line) => /\.borderRadius\(\s*\d/.test(line),
    hint: 'Use Token.radius.*.'
  },
  {
    id: 'system-color-enum',
    test: (line) => /\bColor\.[A-Z][A-Za-z]+/.test(line),
    hint: 'Use Token.color.*() instead of the built-in Color enum.'
  },
  {
    id: 'implicit-brand-color',
    test: (line) => /Token\.color\.(?:primary|primaryContainer|onPrimary)\(\s*\)/.test(line),
    hint: 'Pass the component @StorageLink brand value, e.g. Token.color.primary(this.brand), so brand switches repaint.'
  }
];

function listEtsFiles(target) {
  const abs = path.isAbsolute(target) ? target : path.join(root, target);
  if (!fs.existsSync(abs)) {
    return [];
  }
  const stat = fs.statSync(abs);
  if (stat.isFile()) {
    return abs.endsWith('.ets') ? [abs] : [];
  }
  const out = [];
  for (const entry of fs.readdirSync(abs)) {
    if (entry === 'build' || entry === 'oh_modules' || entry === 'node_modules') {
      continue;
    }
    out.push(...listEtsFiles(path.join(abs, entry)));
  }
  return out;
}

function stripComment(line) {
  const idx = line.indexOf('//');
  return idx >= 0 ? line.slice(0, idx) : line;
}

function scanFile(file) {
  const findings = [];
  const lines = fs.readFileSync(file, 'utf8').split('\n');
  lines.forEach((raw, index) => {
    const line = stripComment(raw);
    for (const rule of rules) {
      if (rule.test(line)) {
        findings.push({
          file: path.relative(root, file),
          line: index + 1,
          rule: rule.id,
          hint: rule.hint,
          text: raw.trim()
        });
      }
    }
  });
  return findings;
}

function main() {
  const targets = process.argv.slice(2);
  const roots = targets.length > 0 ? targets : defaultRoots;
  const files = roots
    .flatMap(listEtsFiles)
    .filter((file) => !allowFiles.has(file));

  const findings = files.flatMap(scanFile);
  if (findings.length > 0) {
    console.error('Hardcoded design values found (use Token.* instead):\n');
    for (const f of findings) {
      console.error(`  ${f.file}:${f.line}  [${f.rule}]`);
      console.error(`    ${f.text}`);
      console.error(`    -> ${f.hint}\n`);
    }
    console.error(`${findings.length} violation(s) across ${files.length} file(s).`);
    process.exit(1);
  }
  console.log(`Hardcode check passed. Scanned ${files.length} .ets file(s).`);
}

if (process.argv[1] && path.resolve(process.argv[1]) === fileURLToPath(import.meta.url)) {
  main();
}

export { scanFile, listEtsFiles, rules };

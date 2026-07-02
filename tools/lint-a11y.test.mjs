import test from 'node:test';
import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';

import { scanFile } from './lint-a11y.mjs';

function withTempFile(content, run) {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'a11y-'));
  const file = path.join(dir, 'Sample.ets');
  fs.writeFileSync(file, content);
  try {
    return run(file);
  } finally {
    fs.rmSync(dir, { recursive: true, force: true });
  }
}

test('flags an icon button with onClick but no accessibilityText', () => {
  const src = [
    'SymbolGlyph($r("x"))',
    '  .fontSize(24)',
    '  .onClick(() => {})'
  ].join('\n');
  withTempFile(src, (file) => {
    assert.equal(scanFile(file).length, 1);
  });
});

test('accepts an icon button that has accessibilityText', () => {
  const src = [
    'SymbolGlyph($r("x"))',
    '  .accessibilityText($r("label"))',
    '  .onClick(() => {})'
  ].join('\n');
  withTempFile(src, (file) => {
    assert.equal(scanFile(file).length, 0);
  });
});

test('does not flag an icon without its own onClick', () => {
  const src = [
    'SymbolGlyph($r("x"))',
    '  .fontSize(24)'
  ].join('\n');
  withTempFile(src, (file) => {
    assert.equal(scanFile(file).length, 0);
  });
});

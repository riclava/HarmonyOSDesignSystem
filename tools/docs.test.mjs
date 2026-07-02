import test from 'node:test';
import assert from 'node:assert/strict';
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

import { parseComponent, renderComponentsDoc, renderTokenDoc } from './docs.mjs';
import { flatten, cssVariables } from './export-tokens.mjs';

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');
const componentsDir = path.join(root, 'library/src/main/ets/components');

test('parseComponent extracts props, events and skips framework state', () => {
  const c = parseComponent(path.join(componentsDir, 'AppButton.ets'));
  assert.equal(c.name, 'AppButton');
  const propNames = c.props.map((p) => p.name);
  assert.ok(propNames.includes('label'));
  assert.ok(propNames.includes('loading'));
  // isDark / brand / compact / private state must not appear as public props.
  assert.ok(!propNames.includes('isDark'));
  assert.ok(!propNames.includes('brand'));
  assert.ok(!propNames.includes('compact'));
  assert.ok(!propNames.includes('pressed'));
  assert.ok(c.events.some((e) => e.name === 'onClickAction'));
  assert.ok(c.enums.some((e) => e.name === 'AppButtonType'));
});

test('parseComponent captures @BuilderParam slots', () => {
  const c = parseComponent(path.join(componentsDir, 'AppAccordion.ets'));
  assert.ok(c.slots.some((s) => s.name === 'content'));
});

test('generated component doc is in sync with sources', () => {
  const onDisk = fs.readFileSync(path.join(root, 'docs/generated/components-api.md'), 'utf8');
  assert.equal(onDisk, renderComponentsDoc(), 'Run: npm run docs:generate');
});

test('generated token reference is in sync', () => {
  const onDisk = fs.readFileSync(path.join(root, 'docs/generated/token-reference.md'), 'utf8');
  assert.equal(onDisk, renderTokenDoc(), 'Run: npm run docs:generate');
});

test('flatten exposes color light/dark, brand overrides and dimensions', () => {
  const flat = flatten();
  assert.equal(flat['color.primary.light'], '#126AFF');
  assert.equal(flat['color.primary.violet.light'], '#6D28D9');
  assert.equal(flat['space.md'], '16vp');
  assert.equal(flat['font.body.fontSize'], '16fp');
  assert.equal(flat['size.buttonLarge.compact'], '40vp');
});

test('cssVariables emits :root custom properties and a dark override', () => {
  const css = cssVariables();
  assert.match(css, /--ds-color-primary: #126AFF;/);
  assert.match(css, /prefers-color-scheme: dark/);
});

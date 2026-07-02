import test from 'node:test';
import assert from 'node:assert/strict';
import fs from 'node:fs';
import path from 'node:path';
import process from 'node:process';
import { fileURLToPath } from 'node:url';

import {
  arkColor,
  parseDimension,
  resourceName,
  runtimeName,
  contrast,
  renderRuntime,
  renderColorResources
} from './design-system.mjs';

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');

test('arkColor: 6-digit hex is normalized to uppercase', () => {
  assert.equal(arkColor('#2979ff'), '#2979FF');
});

test('arkColor: 8-digit RGBA hex is reordered to ARGB', () => {
  // #RRGGBBAA -> #AARRGGBB (ArkUI color format)
  assert.equal(arkColor('#11223344'), '#44112233');
});

test('arkColor: rejects malformed color values', () => {
  assert.throws(() => arkColor('2979FF'));
  assert.throws(() => arkColor('#12'));
});

test('parseDimension: strips vp/fp/ms units', () => {
  assert.equal(parseDimension('16vp'), 16);
  assert.equal(parseDimension('14fp'), 14);
  assert.equal(parseDimension('250ms'), 250);
  assert.equal(parseDimension('0'), 0);
});

test('parseDimension: rejects unsupported dimensions', () => {
  assert.throws(() => parseDimension('16px'));
  assert.throws(() => parseDimension('auto'));
});

test('resourceName: camelCase maps to ds_ snake_case', () => {
  assert.equal(resourceName('primary'), 'ds_primary');
  assert.equal(resourceName('onSurfaceVariant'), 'ds_on_surface_variant');
});

test('runtimeName: numeric-prefixed scale names map to words', () => {
  assert.equal(runtimeName('3xl'), 'xxxl');
  assert.equal(runtimeName('2xl'), 'xxl');
  assert.equal(runtimeName('md'), 'md');
});

test('contrast: pure black on white is ~21:1', () => {
  assert.ok(Math.abs(contrast('#000000', '#FFFFFF') - 21) < 0.1);
});

test('contrast: identical colors are 1:1', () => {
  assert.equal(contrast('#123456', '#123456'), 1);
});

test('generated runtime Tokens.ets is in sync with tokens/design-tokens.json', () => {
  const onDisk = fs.readFileSync(
    path.join(root, 'library/src/main/ets/theme/Tokens.ets'), 'utf8');
  assert.equal(onDisk, renderRuntime(), 'Run: node tools/design-system.mjs generate');
});

test('generated light color.json is in sync', () => {
  const onDisk = fs.readFileSync(
    path.join(root, 'library/src/main/resources/base/element/color.json'), 'utf8');
  assert.equal(onDisk, renderColorResources('light'));
});

test('generated dark color.json is in sync', () => {
  const onDisk = fs.readFileSync(
    path.join(root, 'library/src/main/resources/dark/element/color.json'), 'utf8');
  assert.equal(onDisk, renderColorResources('dark'));
});

import test from 'node:test';
import assert from 'node:assert/strict';

import { rules } from './lint-hardcode.mjs';

function matches(line) {
  return rules.filter((rule) => rule.test(line)).map((rule) => rule.id);
}

test('flags literal hex colors', () => {
  assert.deepEqual(matches(".fontColor('#2979FF')"), ['hardcoded-hex-color']);
});

test('flags hardcoded font size / weight / line height', () => {
  assert.ok(matches('.fontSize(18)').includes('hardcoded-font-size'));
  assert.ok(matches('.fontWeight(700)').includes('hardcoded-font-weight'));
  assert.ok(matches('.lineHeight(24)').includes('hardcoded-line-height'));
});

test('flags hardcoded spacing and radius', () => {
  assert.ok(matches('.padding(16)').includes('hardcoded-padding'));
  assert.ok(matches('.margin(8)').includes('hardcoded-margin'));
  assert.ok(matches('.borderRadius(12)').includes('hardcoded-radius'));
});

test('flags built-in Color enum usage', () => {
  assert.ok(matches('.backgroundColor(Color.Red)').includes('system-color-enum'));
});

test('accepts Token-based values', () => {
  assert.deepEqual(matches('.fontSize(Token.font.label.sizeFor(this.compact))'), []);
  assert.deepEqual(matches('.padding(LengthMetrics.vp(Token.space.md))'), []);
  assert.deepEqual(matches('.fontColor(Token.color.primary())'), []);
  assert.deepEqual(matches('.borderRadius(Token.radius.sm)'), []);
});

test('ignores non-design numeric args (border width, opacity, scale)', () => {
  // These are not design-token categories and must not be flagged.
  assert.deepEqual(matches('.opacity(0.38)'), []);
  assert.deepEqual(matches('.scale({ x: 0.98, y: 0.98 })'), []);
});

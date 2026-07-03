#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import process from 'node:process';
import { fileURLToPath } from 'node:url';

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');
const tokenPath = path.join(root, 'tokens/design-tokens.json');
const runtimePath = path.join(root, 'library/src/main/ets/theme/Tokens.ets');
const lightResourcePath = path.join(root, 'library/src/main/resources/base/element/color.json');
const darkResourcePath = path.join(root, 'library/src/main/resources/dark/element/color.json');

const tokens = JSON.parse(fs.readFileSync(tokenPath, 'utf8'));

const nameMap = new Map([
  ['3xl', 'xxxl'],
  ['4xl', 'xxxxl'],
  ['5xl', 'xxxxxl'],
  ['2xl', 'xxl']
]);

const curveMap = new Map([
  ['easeStandard', 'Curve.Friction'],
  ['easeOut', 'Curve.EaseOut'],
  ['easeIn', 'Curve.EaseIn']
]);

const contrastPairs = [
  // Normal text (WCAG 1.4.3 AA): >= 4.5. Button labels use onPrimary on the fill color.
  ['primary/onPrimary light', 'primary', 'onPrimary', 'light', 4.5],
  ['primary/onPrimary dark', 'primary', 'onPrimary', 'dark', 4.5],
  ['danger/onPrimary light', 'danger', 'onPrimary', 'light', 4.5],
  ['danger/onPrimary dark', 'danger', 'onPrimary', 'dark', 4.5],
  ['info/surface light', 'info', 'surface', 'light', 4.5],
  ['onSurface/surface light', 'onSurface', 'surface', 'light', 4.5],
  ['onSurface/surface dark', 'onSurface', 'surface', 'dark', 4.5],
  ['onSurfaceVariant/surface light', 'onSurfaceVariant', 'surface', 'light', 4.5],
  ['onSurfaceVariant/surface dark', 'onSurfaceVariant', 'surface', 'dark', 4.5],
  // Non-text status indicators (WCAG 1.4.11): >= 3.0. success/warning are used as
  // icons / borders / status dots and short status labels, not body text.
  ['success/surface light', 'success', 'surface', 'light', 3.0],
  ['warning/surface light', 'warning', 'surface', 'light', 3.0]
];

function runtimeName(name) {
  return nameMap.get(name) ?? name;
}

function parseDimension(value) {
  const match = String(value).match(/^(-?\d+(?:\.\d+)?)(vp|fp|ms)?$/);
  if (!match) {
    throw new Error(`Unsupported token dimension: ${value}`);
  }
  return Number(match[1]);
}

function arkColor(hex) {
  if (!/^#[0-9A-Fa-f]{6}([0-9A-Fa-f]{2})?$/.test(hex)) {
    throw new Error(`Unsupported color value: ${hex}`);
  }
  const upper = hex.toUpperCase();
  if (upper.length === 9) {
    return `#${upper.slice(7, 9)}${upper.slice(1, 7)}`;
  }
  return upper;
}

function resourceName(name) {
  return `ds_${name.replace(/[A-Z]/g, (part) => `_${part.toLowerCase()}`)}`;
}

function renderRuntime() {
  const colorMethods = Object.entries(tokens.color).map(([name, token]) => {
    const light = arkColor(token.$value.light);
    const dark = arkColor(token.$value.dark);
    const brands = token.$extensions?.brands;
    if (!brands) {
      return `  ${name}(): ResourceColor { return pick(new ColorPair('${light}', '${dark}')); }`;
    }
    const cases = Object.entries(brands).map(([brandId, value]) =>
      `      case '${brandId}': return pick(new ColorPair('${arkColor(value.light)}', '${arkColor(value.dark)}'));`).join('\n');
    // Branded colors take an explicit brand argument so callers that pass their
    // @StorageLink('brand') read it during build() and repaint on brand switch.
    // Defaults to currentBrand() to keep the parameter-less call site working.
    return `  ${name}(brand: string = currentBrand()): ResourceColor {\n    switch (brand) {\n${cases}\n      default: return pick(new ColorPair('${light}', '${dark}'));\n    }\n  }`;
  }).join('\n');

  const spaceFields = Object.entries(tokens.space).map(([name, token]) =>
    `  readonly ${runtimeName(name)}: number = ${parseDimension(token.$value)};`).join('\n');

  const radiusFields = Object.entries(tokens.radius).map(([name, token]) =>
    `  readonly ${runtimeName(name)}: number = ${parseDimension(token.$value)};`).join('\n');

  const iconFields = Object.entries(tokens.icon).map(([name, token]) =>
    `  readonly ${runtimeName(name)}: number = ${parseDimension(token.$value)};`).join('\n');

  const fontFields = Object.entries(tokens.font)
    .filter(([name]) => !name.startsWith('$') && name !== 'family')
    .map(([name, token]) => {
      const value = token.$value;
      const compact = token.$extensions?.compact ?? value;
      // superCompact falls back to compact, which falls back to the base value.
      const superCompact = token.$extensions?.superCompact ?? compact;
      return `  readonly ${name}: TypeStyle = new TypeStyle(${parseDimension(value.fontSize)}, ${parseDimension(value.lineHeight)}, ${value.fontWeight}, ${parseDimension(compact.fontSize)}, ${parseDimension(compact.lineHeight)}, ${parseDimension(superCompact.fontSize)}, ${parseDimension(superCompact.lineHeight)});`;
    }).join('\n');

  const shadowFields = Object.entries(tokens.elevation).map(([name, token]) => {
    const value = token.$value;
    return `  readonly ${name}: ShadowStyle = new ShadowStyle(${value.blur}, '${arkColor(value.color)}', ${value.offsetX ?? 0}, ${value.offsetY});`;
  }).join('\n');

  const motionFields = Object.entries(tokens.motion).map(([name, token]) => {
    if (token.$type === 'duration') {
      return `  readonly ${name}: number = ${parseDimension(token.$value)};`;
    }
    const curve = curveMap.get(name);
    if (!curve) {
      throw new Error(`Missing runtime curve mapping for motion.${name}`);
    }
    return `  readonly ${name}: Curve = ${curve};`;
  }).join('\n');

  const sizeFields = Object.entries(tokens.size)
    .filter(([name]) => !name.startsWith('$'))
    .map(([name, token]) => {
      const value = token.$value;
      if (typeof value === 'string') {
        return `  readonly ${runtimeName(name)}: number = ${parseDimension(value)};`;
      }
      // superCompact falls back to compact when not specified.
      const superCompact = value.superCompact ?? value.compact;
      return `  ${runtimeName(name)}(density: Density): number {\n    switch (density) {\n      case Density.SuperCompact: return ${parseDimension(superCompact)};\n      case Density.Compact: return ${parseDimension(value.compact)};\n      default: return ${parseDimension(value.comfortable)};\n    }\n  }`;
    }).join('\n');

  return `/**
 * HarmonyOS Design System - Tokens (generated)
 *
 * Source of truth: tokens/design-tokens.json.
 * Generated by: node tools/design-system.mjs generate.
 * Do not hand-edit token values in this file.
 */
import { ConfigurationConstant } from '@kit.AbilityKit';
import { i18n } from '@kit.LocalizationKit';

class ColorPair {
  light: string;
  dark: string;
  constructor(light: string, dark: string) {
    this.light = light;
    this.dark = dark;
  }
}

/**
 * UI density level. Drives control sizes, paddings and font sizes/line-heights.
 * Colors and radius never change with density.
 * - Comfortable: default, touch-friendly.
 * - Compact: data-dense screens / large displays.
 * - SuperCompact: extremely information-dense apps; visuals may dip below 44vp,
 *   so keep a 44vp hit area via .responseRegion(...). caption font never shrinks.
 */
export enum Density {
  Comfortable = 0,
  Compact = 1,
  SuperCompact = 2
}

/** Initialize light/dark mode from system configuration. */
export function initColorMode(colorMode: ConfigurationConstant.ColorMode): void {
  AppStorage.setOrCreate('isDark',
    colorMode === ConfigurationConstant.ColorMode.COLOR_MODE_DARK);
}

/** Current light/dark mode flag for components that hold @StorageLink('isDark'). */
export function isDarkMode(): boolean {
  return AppStorage.get<boolean>('isDark') ?? false;
}

/**
 * Current density. Components hold @StorageProp('density') and pass it to
 * Token.size.*(density) / Token.font.*.sizeFor(density) so they repaint on change.
 * Falls back to the legacy boolean 'compact' key for backward compatibility.
 */
export function currentDensity(): Density {
  const density = AppStorage.get<Density>('density');
  if (density !== undefined) {
    return density;
  }
  return (AppStorage.get<boolean>('compact') ?? false) ? Density.Compact : Density.Comfortable;
}

/** Set the active density at runtime. Components holding @StorageProp('density') repaint. */
export function setDensity(density: Density): void {
  AppStorage.setOrCreate('density', density);
}

/** Initialize density at app startup, e.g. in the Ability. */
export function initDensity(density: Density): void {
  AppStorage.setOrCreate('density', density);
}

/**
 * Backward-compatible boolean density switch: true -> Compact, false -> Comfortable.
 * Prefer setDensity(Density) to also reach SuperCompact.
 */
export function setCompact(compact: boolean): void {
  AppStorage.setOrCreate('density', compact ? Density.Compact : Density.Comfortable);
}

/** Current compact-or-denser flag (compat helper). True for Compact and SuperCompact. */
export function isCompactMode(): boolean {
  return currentDensity() !== Density.Comfortable;
}

/** Current brand id. Colors with brand overrides resolve against this ('default' when unset). */
export function currentBrand(): string {
  return AppStorage.get<string>('brand') ?? 'default';
}

/** Switch the active brand at runtime. Components holding @StorageLink('brand') repaint. */
export function setBrand(brand: string): void {
  AppStorage.setOrCreate('brand', brand);
}

/** Initialize theme (brand + light/dark) at app startup, e.g. in the Ability. */
export function initTheme(brand: string, colorMode: ConfigurationConstant.ColorMode): void {
  AppStorage.setOrCreate('brand', brand);
  AppStorage.setOrCreate('isDark',
    colorMode === ConfigurationConstant.ColorMode.COLOR_MODE_DARK);
}

/** Current system language direction. Use this only for directional icon mirroring. */
export function isRTL(): boolean {
  try {
    const locale: string = new Intl.DateTimeFormat().resolvedOptions().locale;
    return i18n.isRTL(locale);
  } catch (err) {
    return false;
  }
}

function pick(pair: ColorPair): ResourceColor {
  return isDarkMode() ? pair.dark : pair.light;
}

/** ---------- Color ---------- */
class ColorTokens {
${colorMethods}
}

/** ---------- Spacing (vp) ---------- */
class SpaceTokens {
${spaceFields}
}

/** ---------- Radius (vp) ---------- */
class RadiusTokens {
${radiusFields}
}

/** ---------- Typography (fp) ---------- */
class TypeStyle {
  size: number;
  lineHeight: number;
  weight: number;
  compactSize: number;
  compactLineHeight: number;
  superCompactSize: number;
  superCompactLineHeight: number;
  constructor(size: number, lineHeight: number, weight: number,
              compactSize: number, compactLineHeight: number,
              superCompactSize: number, superCompactLineHeight: number) {
    this.size = size;
    this.lineHeight = lineHeight;
    this.weight = weight;
    this.compactSize = compactSize;
    this.compactLineHeight = compactLineHeight;
    this.superCompactSize = superCompactSize;
    this.superCompactLineHeight = superCompactLineHeight;
  }

  sizeFor(density: Density): number {
    switch (density) {
      case Density.SuperCompact: return this.superCompactSize;
      case Density.Compact: return this.compactSize;
      default: return this.size;
    }
  }

  lineHeightFor(density: Density): number {
    switch (density) {
      case Density.SuperCompact: return this.superCompactLineHeight;
      case Density.Compact: return this.compactLineHeight;
      default: return this.lineHeight;
    }
  }
}

class FontTokens {
  readonly family: string = '${tokens.font.family.$value}';
${fontFields}
}

/** ---------- Icon size (vp) ---------- */
class IconTokens {
${iconFields}
}

/** ---------- Elevation / Shadow ---------- */
class ShadowStyle {
  radius: number;
  color: string;
  offsetX: number;
  offsetY: number;
  constructor(radius: number, color: string, offsetX: number, offsetY: number) {
    this.radius = radius;
    this.color = color;
    this.offsetX = offsetX;
    this.offsetY = offsetY;
  }
}

class ShadowTokens {
${shadowFields}
}

/** ---------- Motion ---------- */
class MotionTokens {
${motionFields}
}

/** ---------- Control and component sizes (vp) ---------- */
class SizeTokens {
${sizeFields}
}

/** Unified token export. */
export class Token {
  static readonly color: ColorTokens = new ColorTokens();
  static readonly space: SpaceTokens = new SpaceTokens();
  static readonly radius: RadiusTokens = new RadiusTokens();
  static readonly font: FontTokens = new FontTokens();
  static readonly icon: IconTokens = new IconTokens();
  static readonly shadow: ShadowTokens = new ShadowTokens();
  static readonly motion: MotionTokens = new MotionTokens();
  static readonly size: SizeTokens = new SizeTokens();
}
`;
}

function renderColorResources(mode) {
  const values = Object.entries(tokens.color).map(([name, token]) => ({
    name: resourceName(name),
    value: arkColor(token.$value[mode])
  }));
  return `${JSON.stringify({ color: values }, null, 2)}\n`;
}

function rgb(hex) {
  const clean = hex.replace('#', '');
  const rgbPart = clean.length === 8 ? clean.slice(0, 6) : clean;
  return [0, 2, 4].map((index) => parseInt(rgbPart.slice(index, index + 2), 16) / 255);
}

function linear(channel) {
  return channel <= 0.03928 ? channel / 12.92 : ((channel + 0.055) / 1.055) ** 2.4;
}

function luminance(hex) {
  const [r, g, b] = rgb(hex).map(linear);
  return 0.2126 * r + 0.7152 * g + 0.0722 * b;
}

function contrast(first, second) {
  const high = Math.max(luminance(first), luminance(second));
  const low = Math.min(luminance(first), luminance(second));
  return (high + 0.05) / (low + 0.05);
}

function brandIds() {
  const ids = new Set(['default']);
  for (const token of Object.values(tokens.color)) {
    const brands = token.$extensions?.brands;
    if (brands) {
      Object.keys(brands).forEach((id) => ids.add(id));
    }
  }
  return [...ids];
}

function resolveColor(name, mode, brand) {
  const token = tokens.color[name];
  const brands = token.$extensions?.brands;
  if (brand !== 'default' && brands && brands[brand]) {
    return brands[brand][mode];
  }
  return token.$value[mode];
}

function validateContrast() {
  const failures = [];
  for (const brand of brandIds()) {
    for (const [label, fg, bg, mode, minimum] of contrastPairs) {
      const ratio = contrast(resolveColor(fg, mode, brand), resolveColor(bg, mode, brand));
      if (ratio < minimum) {
        failures.push(`[${brand}] ${label}: ${ratio.toFixed(2)} < ${minimum}`);
      }
    }
  }
  return failures;
}

function compareFile(filePath, expected) {
  const actual = fs.existsSync(filePath) ? fs.readFileSync(filePath, 'utf8') : '';
  return actual === expected ? [] : [`${path.relative(root, filePath)} is not generated from tokens/design-tokens.json`];
}

function generate() {
  fs.writeFileSync(runtimePath, renderRuntime());
  fs.writeFileSync(lightResourcePath, renderColorResources('light'));
  fs.writeFileSync(darkResourcePath, renderColorResources('dark'));
}

function check(strictContrast) {
  const failures = [
    ...compareFile(runtimePath, renderRuntime()),
    ...compareFile(lightResourcePath, renderColorResources('light')),
    ...compareFile(darkResourcePath, renderColorResources('dark')),
    ...(strictContrast ? validateContrast() : [])
  ];
  if (failures.length > 0) {
    console.error(failures.join('\n'));
    process.exit(1);
  }
  console.log('Design system token checks passed.');
}

function main() {
  const args = process.argv.slice(2);
  const command = args[0] ?? 'check';
  const strictContrast = args.includes('--strict-contrast');
  if (command === 'generate') {
    generate();
  } else if (command === 'check') {
    check(strictContrast);
  } else {
    console.error(`Unknown command: ${command}`);
    process.exit(1);
  }
}

// Only run the CLI when executed directly, so tests can import pure helpers.
if (process.argv[1] && path.resolve(process.argv[1]) === fileURLToPath(import.meta.url)) {
  main();
}

export {
  tokens,
  arkColor,
  parseDimension,
  resourceName,
  runtimeName,
  contrast,
  luminance,
  validateContrast,
  renderRuntime,
  renderColorResources
};

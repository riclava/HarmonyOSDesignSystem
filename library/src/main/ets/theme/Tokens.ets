/**
 * HarmonyOS Design System — Tokens（canonical）
 *
 * 单一事实来源见仓库根目录 tokens/design-tokens.json，本文件是其 ArkUI 运行时实现。
 * 业务代码只引用 Token，禁止硬编码颜色 / 字号 / 间距 / 圆角 / 阴影 / 动画。
 *
 * 深浅色：Token 从 AppStorage 的 'isDark' 读取。
 *   - 跟随系统：在 UIAbility.onCreate / onConfigurationUpdate 调用 initColorMode(...)。
 *   - App 内手动切换：直接 AppStorage.setOrCreate('isDark', true/false)。
 *   - UI 组件持有 @StorageLink('isDark') 即可在切换时自动重绘。
 *
 * 说明：ArkTS 严格模式禁止 object-literal 作为类型、as const、以及无类型对象字面量，
 * 因此所有 token 集合均以 class 声明并实例化。
 */
import { ConfigurationConstant } from '@kit.AbilityKit';

class ColorPair {
  light: string;
  dark: string;
  constructor(light: string, dark: string) {
    this.light = light;
    this.dark = dark;
  }
}

/** 由系统配置初始化深浅色（在 Ability 生命周期里调用）。 */
export function initColorMode(colorMode: ConfigurationConstant.ColorMode): void {
  AppStorage.setOrCreate('isDark',
    colorMode === ConfigurationConstant.ColorMode.COLOR_MODE_DARK);
}

/** 当前是否深色（供 UI 层 @StorageLink('isDark') 响应式刷新）。 */
export function isDarkMode(): boolean {
  return AppStorage.get<boolean>('isDark') ?? false;
}

function pick(pair: ColorPair): ResourceColor {
  return isDarkMode() ? pair.dark : pair.light;
}

/** ---------- Color ---------- */
class ColorTokens {
  primary(): ResourceColor { return pick(new ColorPair('#2979FF', '#6EA8FF')); }
  primaryContainer(): ResourceColor { return pick(new ColorPair('#D6E4FF', '#00429A')); }
  onPrimary(): ResourceColor { return pick(new ColorPair('#FFFFFF', '#00285C')); }
  secondary(): ResourceColor { return pick(new ColorPair('#00C48C', '#4FE0B5')); }
  secondaryContainer(): ResourceColor { return pick(new ColorPair('#C8F5E7', '#00513A')); }
  success(): ResourceColor { return pick(new ColorPair('#34C759', '#4ADE80')); }
  warning(): ResourceColor { return pick(new ColorPair('#FF9F0A', '#FBBF24')); }
  danger(): ResourceColor { return pick(new ColorPair('#FF3B30', '#FF6B6B')); }
  info(): ResourceColor { return pick(new ColorPair('#0A84FF', '#64B5FF')); }
  surface(): ResourceColor { return pick(new ColorPair('#FFFFFF', '#1E1E1E')); }
  background(): ResourceColor { return pick(new ColorPair('#F6F6F6', '#000000')); }
  onSurface(): ResourceColor { return pick(new ColorPair('#1A1A1A', '#F5F5F5')); }
  onSurfaceVariant(): ResourceColor { return pick(new ColorPair('#666666', '#A8A8A8')); }
  outline(): ResourceColor { return pick(new ColorPair('#E0E0E0', '#3A3A3A')); }
  divider(): ResourceColor { return pick(new ColorPair('#EEEEEE', '#2A2A2A')); }
  mask(): ResourceColor { return pick(new ColorPair('#73000000', '#99000000')); }
  transparent(): ResourceColor { return '#00000000'; }
}

/** ---------- Spacing (vp) ---------- */
class SpaceTokens {
  readonly none: number = 0;
  readonly xxs: number = 4;
  readonly xs: number = 8;
  readonly sm: number = 12;
  readonly md: number = 16;
  readonly lg: number = 24;
  readonly xl: number = 32;
  readonly xxl: number = 40;
  readonly xxxl: number = 48;
  readonly xxxxl: number = 56;
  readonly xxxxxl: number = 64;
}

/** ---------- Radius (vp) ---------- */
class RadiusTokens {
  readonly none: number = 0;
  readonly xs: number = 4;
  readonly sm: number = 8;
  readonly md: number = 12;
  readonly lg: number = 16;
  readonly xl: number = 20;
  readonly xxl: number = 24;
  readonly xxxl: number = 32;
  readonly full: number = 999;
}

/** ---------- Typography (fp) ---------- */
class TypeStyle {
  size: number;
  lineHeight: number;
  weight: number;
  constructor(size: number, lineHeight: number, weight: number) {
    this.size = size;
    this.lineHeight = lineHeight;
    this.weight = weight;
  }
}

class FontTokens {
  readonly family: string = 'HarmonyOS Sans';
  readonly displayLarge: TypeStyle = new TypeStyle(48, 56, 700);
  readonly displayMedium: TypeStyle = new TypeStyle(36, 44, 700);
  readonly headlineLarge: TypeStyle = new TypeStyle(30, 38, 600);
  readonly headlineMedium: TypeStyle = new TypeStyle(24, 32, 600);
  readonly titleLarge: TypeStyle = new TypeStyle(20, 28, 500);
  readonly titleMedium: TypeStyle = new TypeStyle(18, 26, 500);
  readonly body: TypeStyle = new TypeStyle(16, 24, 400);
  readonly bodySmall: TypeStyle = new TypeStyle(14, 20, 400);
  readonly label: TypeStyle = new TypeStyle(14, 20, 500);
  readonly caption: TypeStyle = new TypeStyle(12, 16, 400);
}

/** ---------- Icon size (vp) ---------- */
class IconTokens {
  readonly xs: number = 16;
  readonly sm: number = 20;
  readonly md: number = 24;
  readonly lg: number = 28;
  readonly xl: number = 32;
  readonly xxl: number = 48;
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
  readonly level0: ShadowStyle = new ShadowStyle(0, '#00000000', 0, 0);
  readonly level1: ShadowStyle = new ShadowStyle(3, '#14000000', 0, 1);
  readonly level2: ShadowStyle = new ShadowStyle(6, '#1A000000', 0, 2);
  readonly level3: ShadowStyle = new ShadowStyle(12, '#24000000', 0, 4);
  readonly level4: ShadowStyle = new ShadowStyle(24, '#2E000000', 0, 8);
}

/** ---------- Motion ---------- */
class MotionTokens {
  readonly instant: number = 100;
  readonly fast: number = 200;
  readonly normal: number = 250;
  readonly slow: number = 300;
  readonly extraSlow: number = 400;
  readonly easeStandard: Curve = Curve.Friction;
  readonly easeOut: Curve = Curve.EaseOut;
  readonly easeIn: Curve = Curve.EaseIn;
}

/** 统一出口 */
export class Token {
  static readonly color: ColorTokens = new ColorTokens();
  static readonly space: SpaceTokens = new SpaceTokens();
  static readonly radius: RadiusTokens = new RadiusTokens();
  static readonly font: FontTokens = new FontTokens();
  static readonly icon: IconTokens = new IconTokens();
  static readonly shadow: ShadowTokens = new ShadowTokens();
  static readonly motion: MotionTokens = new MotionTokens();
}

/**
 * HarmonyOS Design System — Tokens (showcase 版本)
 *
 * 与 library（@riclava/designsystem）的 Tokens 同源，但为了让 App 内的深色开关能实时切换，
 * 这里的颜色从 AppStorage 的 'isDark' 读取（配合页面里的 @StorageLink 触发重绘）。
 *
 * 生产环境建议：把 tokens/ 独立成共享 HAR 包，各 App 依赖同一版本。
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

/** 由系统 / 应用配置初始化深浅色（在 Ability 生命周期里调用）。 */
export function initColorMode(colorMode: ConfigurationConstant.ColorMode): void {
  AppStorage.setOrCreate('isDark',
    colorMode === ConfigurationConstant.ColorMode.COLOR_MODE_DARK);
}

/** 读取当前深浅色，由 UI 层的 @StorageLink('isDark') 保证响应式刷新。 */
export function isDarkMode(): boolean {
  return AppStorage.get<boolean>('isDark') ?? false;
}

/**
 * 当前是否紧凑密度。
 * compact 无系统级触发，组件须在 build 里直接引用 @StorageProp('compact') 才能触发重绘，
 * 因此尺寸取值统一走 Token.size.*(compact) 把 compact 作为参数传入。
 */
export function isCompactMode(): boolean {
  return AppStorage.get<boolean>('compact') ?? false;
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

/** ---------- Control size (vp)，随 compact 密度切换 ---------- */
class SizeTokens {
  /** 无障碍最小命中区。compact 下控件视觉可更小，但用 responseRegion 兜底到该值。 */
  readonly minTouch: number = 44;

  buttonLarge(compact: boolean): number { return compact ? 40 : 48; }
  buttonMedium(compact: boolean): number { return compact ? 32 : 40; }
  buttonSmall(compact: boolean): number { return compact ? 28 : 32; }
  /** 输入框 / 搜索框高度 */
  field(compact: boolean): number { return compact ? 40 : 48; }
  /** 分段标签栏高度 */
  tabBar(compact: boolean): number { return compact ? 40 : 48; }
  /** 分段标签文字区高度（指示条在其下方） */
  tabLabel(compact: boolean): number { return compact ? 38 : 46; }
  /** 列表项最小高度 */
  rowMin(compact: boolean): number { return compact ? 48 : 56; }
  /** 菜单项高度 */
  menuItem(compact: boolean): number { return compact ? 36 : 40; }
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
  static readonly size: SizeTokens = new SizeTokens();
}

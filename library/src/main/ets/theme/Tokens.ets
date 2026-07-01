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
import { i18n } from '@kit.LocalizationKit';

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

/**
 * 当前是否紧凑密度。
 * compact 无系统级触发，组件须在 build 里直接引用 @StorageProp('compact') 才能触发重绘，
 * 因此尺寸取值统一走 Token.size.*(compact) 把 compact 作为参数传入。
 */
export function isCompactMode(): boolean {
  return AppStorage.get<boolean>('compact') ?? false;
}

/**
 * 当前系统语言是否为从右到左（RTL，如阿拉伯语 / 希伯来语 / 波斯语）。
 * 组件据此镜像方向性图标（如列表箭头）。布局的镜像交由 start/end 逻辑方向自动完成。
 */
export function isRTL(): boolean {
  try {
    return i18n.isRTL(i18n.System.getSystemLocale());
  } catch (err) {
    return false;
  }
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
  compactSize: number;
  compactLineHeight: number;
  constructor(size: number, lineHeight: number, weight: number, compactSize: number, compactLineHeight: number) {
    this.size = size;
    this.lineHeight = lineHeight;
    this.weight = weight;
    this.compactSize = compactSize;
    this.compactLineHeight = compactLineHeight;
  }

  /** 字号：随 compact 密度切换。 */
  sizeFor(compact: boolean): number {
    return compact ? this.compactSize : this.size;
  }

  /** 行高：随 compact 密度切换。 */
  lineHeightFor(compact: boolean): number {
    return compact ? this.compactLineHeight : this.lineHeight;
  }
}

class FontTokens {
  readonly family: string = 'HarmonyOS Sans';
  readonly displayLarge: TypeStyle = new TypeStyle(48, 56, 700, 40, 48);
  readonly displayMedium: TypeStyle = new TypeStyle(36, 44, 700, 32, 40);
  readonly headlineLarge: TypeStyle = new TypeStyle(30, 38, 600, 26, 34);
  readonly headlineMedium: TypeStyle = new TypeStyle(24, 32, 600, 22, 28);
  readonly titleLarge: TypeStyle = new TypeStyle(20, 28, 500, 18, 24);
  readonly titleMedium: TypeStyle = new TypeStyle(18, 26, 500, 16, 22);
  readonly body: TypeStyle = new TypeStyle(16, 24, 400, 14, 20);
  readonly bodySmall: TypeStyle = new TypeStyle(14, 20, 400, 13, 18);
  readonly label: TypeStyle = new TypeStyle(14, 20, 500, 13, 18);
  readonly caption: TypeStyle = new TypeStyle(12, 16, 400, 12, 16);
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

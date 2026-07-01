import { Token } from '../theme/Tokens';

export enum AppButtonType { Primary, Secondary, Text, Danger }
export enum AppButtonSize { Large, Medium, Small }

/**
 * 按钮：Primary / Secondary / Text / Danger 四型，Large / Medium / Small 三档。
 * 支持 loading（显示指示器并禁用点击）与 Pressed 缩放动画（0.98, Instant）。
 */
@Component
export struct AppButton {
  @Prop label: string;
  @Prop type: AppButtonType = AppButtonType.Primary;
  @Prop btnSize: AppButtonSize = AppButtonSize.Medium;
  @Prop disabled: boolean = false;
  @Prop loading: boolean = false;
  @StorageLink('isDark') isDark: boolean = false;
  @StorageProp('compact') compact: boolean = false;
  @State private pressed: boolean = false;
  onClickAction?: () => void;

  private btnHeight(): number {
    switch (this.btnSize) {
      case AppButtonSize.Large: return Token.size.buttonLarge(this.compact);
      case AppButtonSize.Small: return Token.size.buttonSmall(this.compact);
      default: return Token.size.buttonMedium(this.compact);
    }
  }

  private touchHeight(): number {
    return Math.max(this.btnHeight(), Token.size.minTouch);
  }

  private hPadding(): number {
    switch (this.btnSize) {
      case AppButtonSize.Large: return Token.space.lg;
      case AppButtonSize.Small: return Token.space.sm;
      default: return Token.space.md;
    }
  }

  private labelSize(): number {
    return this.btnSize === AppButtonSize.Small ? Token.font.bodySmall.sizeFor(this.compact) : Token.font.label.sizeFor(this.compact);
  }

  private bgColor(): ResourceColor {
    if (this.type === AppButtonType.Primary) {
      return Token.color.primary();
    }
    if (this.type === AppButtonType.Danger) {
      return Token.color.danger();
    }
    return Token.color.transparent();
  }

  private fgColor(): ResourceColor {
    if (this.type === AppButtonType.Primary || this.type === AppButtonType.Danger) {
      return Token.color.onPrimary();
    }
    return Token.color.primary();
  }

  private interactive(): boolean {
    return !this.disabled && !this.loading;
  }

  build() {
    Row() {
      if (this.loading) {
        LoadingProgress()
          .width(Token.icon.sm)
          .height(Token.icon.sm)
          .color(this.fgColor())
          .margin({ right: Token.space.xs })
      }
      Text(this.label)
        .fontSize(this.labelSize())
        .fontWeight(Token.font.label.weight)
        .fontColor(this.fgColor())
        .textAlign(TextAlign.Center)
    }
    .justifyContent(FlexAlign.Center)
    .height(this.btnHeight())
    .padding({ left: this.hPadding(), right: this.hPadding() })
    .backgroundColor(this.bgColor())
    .borderRadius(this.btnSize === AppButtonSize.Small ? Token.radius.xs : Token.radius.sm)
    .border(this.type === AppButtonType.Secondary
      ? { width: 1, color: Token.color.outline() }
      : { width: 0 })
    .opacity(this.interactive() ? 1 : 0.38)
    .scale(this.pressed ? { x: 0.98, y: 0.98 } : { x: 1, y: 1 })
    .animation({ duration: Token.motion.instant, curve: Token.motion.easeStandard })
    .responseRegion({ x: 0, y: (this.btnHeight() - this.touchHeight()) / 2, width: '100%', height: this.touchHeight() })
    .enabled(this.interactive())
    .onTouch((event: TouchEvent) => {
      if (event.type === TouchType.Down) {
        this.pressed = true;
      } else if (event.type === TouchType.Up || event.type === TouchType.Cancel) {
        this.pressed = false;
      }
    })
    .onClick(() => {
      if (this.interactive() && this.onClickAction) {
        this.onClickAction();
      }
    })
  }
}

import { Token } from '../theme/Tokens';

export enum AppButtonType { Primary, Secondary, Text, Danger }
export enum AppButtonSize { Large, Medium, Small }

@Component
export struct AppButton {
  @Prop label: string;
  @Prop type: AppButtonType = AppButtonType.Primary;
  @Prop btnSize: AppButtonSize = AppButtonSize.Medium;
  @Prop disabled: boolean = false;
  @StorageLink('isDark') isDark: boolean = false;
  onClickAction?: () => void;

  private btnHeight(): number {
    switch (this.btnSize) {
      case AppButtonSize.Large: return 48;
      case AppButtonSize.Small: return 32;
      default: return 40;
    }
  }

  private hPadding(): number {
    switch (this.btnSize) {
      case AppButtonSize.Large: return Token.space.lg;
      case AppButtonSize.Small: return Token.space.sm;
      default: return Token.space.md;
    }
  }

  private bgColor(): ResourceColor {
    if (this.type === AppButtonType.Primary) return Token.color.primary();
    if (this.type === AppButtonType.Danger) return Token.color.danger();
    return Token.color.transparent();
  }

  private fgColor(): ResourceColor {
    if (this.type === AppButtonType.Primary || this.type === AppButtonType.Danger) {
      return Token.color.onPrimary();
    }
    return Token.color.primary();
  }

  build() {
    Text(this.label)
      .fontSize(Token.font.label.size)
      .fontWeight(Token.font.label.weight)
      .fontColor(this.fgColor())
      .textAlign(TextAlign.Center)
      .height(this.btnHeight())
      .padding({ left: this.hPadding(), right: this.hPadding() })
      .backgroundColor(this.bgColor())
      .borderRadius(Token.radius.sm)
      .border(
        this.type === AppButtonType.Secondary
          ? { width: 1, color: Token.color.outline() }
          : { width: 0 }
      )
      .opacity(this.disabled ? 0.38 : 1)
      .enabled(!this.disabled)
      .onClick(() => { if (!this.disabled && this.onClickAction) this.onClickAction(); })
  }
}

import { Token } from '../Tokens';

/**
 * 输入框：Label（上）+ 输入区 + Helper/Error（下）。
 * 状态：Default(Outline) / Focused(Primary 2vp) / Error(Danger) / Disabled(Divider + 38%)。
 */
@Component
export struct AppTextField {
  @Prop label: string = '';
  @Prop text: string = '';
  @Prop placeholder: string = '';
  @Prop helper: string = '';
  @Prop error: string = '';
  @Prop fieldDisabled: boolean = false;
  @StorageLink('isDark') isDark: boolean = false;
  @StorageProp('compact') compact: boolean = false;
  @State private focused: boolean = false;
  onTextChange?: (value: string) => void;

  private fieldBorderColor(): ResourceColor {
    if (this.error.length > 0) {
      return Token.color.danger();
    }
    if (this.focused) {
      return Token.color.primary();
    }
    return Token.color.outline();
  }

  private fieldTouch(): number {
    return Math.max(Token.size.field(this.compact), Token.size.minTouch);
  }

  build() {
    Column() {
      if (this.label.length > 0) {
        Text(this.label)
          .fontSize(Token.font.label.size)
          .fontWeight(Token.font.label.weight)
          .fontColor(Token.color.onSurface())
          .margin({ bottom: Token.space.xxs })
      }
      TextInput({ placeholder: this.placeholder, text: this.text })
        .fontSize(Token.font.body.size)
        .fontColor(Token.color.onSurface())
        .placeholderColor(Token.color.onSurfaceVariant())
        .backgroundColor(this.fieldDisabled ? Token.color.divider() : Token.color.surface())
        .height(Token.size.field(this.compact))
        .borderRadius(Token.radius.sm)
        .border({ width: this.focused ? 2 : 1, color: this.fieldBorderColor() })
        .padding({ left: Token.space.md, right: Token.space.md })
        .responseRegion({ x: 0, y: (Token.size.field(this.compact) - this.fieldTouch()) / 2, width: '100%', height: this.fieldTouch() })
        .enabled(!this.fieldDisabled)
        .opacity(this.fieldDisabled ? 0.38 : 1)
        .onFocus(() => { this.focused = true; })
        .onBlur(() => { this.focused = false; })
        .onChange((v: string) => {
          this.text = v;
          if (this.onTextChange) {
            this.onTextChange(v);
          }
        })
      if (this.error.length > 0) {
        Text(this.error)
          .fontSize(Token.font.caption.size)
          .fontColor(Token.color.danger())
          .margin({ top: Token.space.xxs })
      } else if (this.helper.length > 0) {
        Text(this.helper)
          .fontSize(Token.font.caption.size)
          .fontColor(Token.color.onSurfaceVariant())
          .margin({ top: Token.space.xxs })
      }
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

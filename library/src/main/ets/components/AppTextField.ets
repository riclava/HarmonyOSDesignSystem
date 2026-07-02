import { Token } from '../theme/Tokens';
import { LengthMetrics } from '@kit.ArkUI';

/** 输入框尺寸档位：Medium（默认）/ Small（更紧凑，用于工具栏 / 密集布局）。 */
export enum AppTextFieldSize { Medium, Small }

/**
 * 输入框：Label（上）+ 输入区 + Helper/Error（下）。
 * 状态：Default(Outline) / Focused(Primary 2vp) / Error(Danger) / Disabled(Divider + 38%)。
 */
@Component
export struct AppTextField {
  @Prop label: string = '';
  @Prop text: string = '';
  @Prop placeholder: ResourceStr = '';
  @Prop helper: string = '';
  @Prop error: string = '';
  @Prop fieldDisabled: boolean = false;
  @Prop fieldSize: AppTextFieldSize = AppTextFieldSize.Medium;
  @Prop inputType: InputType = InputType.Normal;
  @Prop fieldFontFamily: string = Token.font.family;
  @StorageLink('isDark') isDark: boolean = false;
  @StorageProp('compact') compact: boolean = false;
  @State private focused: boolean = false;
  onTextChange?: (value: string) => void;
  onSubmitAction?: () => void;

  private fieldHeight(): number {
    return this.fieldSize === AppTextFieldSize.Small
      ? Token.size.buttonSmall(this.compact)
      : Token.size.field(this.compact);
  }

  private textSize(): number {
    return this.fieldSize === AppTextFieldSize.Small
      ? Token.font.caption.sizeFor(this.compact)
      : Token.font.body.sizeFor(this.compact);
  }

  private hPadding(): number {
    return this.fieldSize === AppTextFieldSize.Small ? Token.space.xs : Token.space.md;
  }

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
    return Math.max(this.fieldHeight(), Token.size.minTouch);
  }

  build() {
    Column() {
      if (this.label.length > 0) {
        Text(this.label)
          .fontSize(Token.font.label.sizeFor(this.compact))
          .fontWeight(Token.font.label.weight)
          .fontColor(Token.color.onSurface())
          .margin({ bottom: Token.space.xxs })
      }
      TextInput({ placeholder: this.placeholder, text: this.text })
        .fontSize(this.textSize())
        .placeholderFont({ size: this.textSize(), family: this.fieldFontFamily })
        .fontFamily(this.fieldFontFamily)
        .fontColor(Token.color.onSurface())
        .placeholderColor(Token.color.onSurfaceVariant())
        .backgroundColor(this.fieldDisabled ? Token.color.divider() : Token.color.surface())
        .height(this.fieldHeight())
        .borderRadius(Token.radius.sm)
        .border({ width: this.focused ? 2 : 1, color: this.fieldBorderColor() })
        .padding({ start: LengthMetrics.vp(this.hPadding()), end: LengthMetrics.vp(this.hPadding()) })
        .responseRegion({ x: 0, y: (this.fieldHeight() - this.fieldTouch()) / 2, width: '100%', height: this.fieldTouch() })
        .type(this.inputType)
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
        .onSubmit(() => {
          if (this.onSubmitAction) {
            this.onSubmitAction();
          }
        })
      if (this.error.length > 0) {
        Text(this.error)
          .fontSize(Token.font.caption.sizeFor(this.compact))
          .fontColor(Token.color.danger())
          .margin({ top: Token.space.xxs })
      } else if (this.helper.length > 0) {
        Text(this.helper)
          .fontSize(Token.font.caption.sizeFor(this.compact))
          .fontColor(Token.color.onSurfaceVariant())
          .margin({ top: Token.space.xxs })
      }
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

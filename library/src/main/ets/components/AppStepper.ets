import { Density, Token } from '../theme/Tokens';

/**
 * 数字步进器：[-] 值 [+]。受 min/max/step 约束，越界时对应按钮禁用。
 */
@Component
export struct AppStepper {
  @Prop value: number = 0;
  @Prop min: number = 0;
  @Prop max: number = 99;
  @Prop step: number = 1;
  @Prop stepperDisabled: boolean = false;
  @StorageLink('isDark') isDark: boolean = false;
  @StorageLink('brand') brand: string = 'default';
  @StorageProp('density') density: Density = Density.Comfortable;
  onChange?: (value: number) => void;

  private btnSize(): number {
    return Token.size.buttonMedium(this.density);
  }

  private btnTouch(): number {
    return Math.max(this.btnSize(), Token.size.minTouch);
  }

  private update(next: number): void {
    this.value = next;
    if (this.onChange) {
      this.onChange(next);
    }
  }

  @Builder
  private DecreaseButton() {
    Stack({ alignContent: Alignment.Center }) {
      SymbolGlyph($r('sys.symbol.minus'))
        .fontSize(Token.icon.sm)
        .fontColor([!this.stepperDisabled && this.value - this.step >= this.min ? Token.color.primary(this.brand) : Token.color.onSurfaceVariant()])
        .width(Token.icon.sm)
        .height(Token.icon.sm)
    }
      .width(this.btnSize())
      .height(this.btnSize())
      .borderRadius(Token.radius.sm)
      .border({ width: 1, color: Token.color.outline() })
      .opacity(!this.stepperDisabled && this.value - this.step >= this.min ? 1 : 0.38)
      .enabled(!this.stepperDisabled && this.value - this.step >= this.min)
      .responseRegion({
        x: (this.btnSize() - this.btnTouch()) / 2,
        y: (this.btnSize() - this.btnTouch()) / 2,
        width: this.btnTouch(),
        height: this.btnTouch()
      })
      .accessibilityText($r('app.string.ds_stepper_decrease'))
      .onClick(() => {
        if (!this.stepperDisabled && this.value - this.step >= this.min) {
          this.update(this.value - this.step);
        }
      })
  }

  @Builder
  private IncreaseButton() {
    Stack({ alignContent: Alignment.Center }) {
      SymbolGlyph($r('sys.symbol.plus'))
        .fontSize(Token.icon.sm)
        .fontColor([!this.stepperDisabled && this.value + this.step <= this.max ? Token.color.primary(this.brand) : Token.color.onSurfaceVariant()])
        .width(Token.icon.sm)
        .height(Token.icon.sm)
    }
      .width(this.btnSize())
      .height(this.btnSize())
      .borderRadius(Token.radius.sm)
      .border({ width: 1, color: Token.color.outline() })
      .opacity(!this.stepperDisabled && this.value + this.step <= this.max ? 1 : 0.38)
      .enabled(!this.stepperDisabled && this.value + this.step <= this.max)
      .responseRegion({
        x: (this.btnSize() - this.btnTouch()) / 2,
        y: (this.btnSize() - this.btnTouch()) / 2,
        width: this.btnTouch(),
        height: this.btnTouch()
      })
      .accessibilityText($r('app.string.ds_stepper_increase'))
      .onClick(() => {
        if (!this.stepperDisabled && this.value + this.step <= this.max) {
          this.update(this.value + this.step);
        }
      })
  }

  build() {
    Row() {
      this.DecreaseButton()
      Text(this.value.toString())
        .fontSize(Token.font.body.sizeFor(this.density))
        .fontColor(Token.color.onSurface())
        .textAlign(TextAlign.Center)
        .constraintSize({ minWidth: Token.size.sliderValueWidth })
        .height(this.btnSize())
      this.IncreaseButton()
    }
    .alignItems(VerticalAlign.Center)
    .opacity(this.stepperDisabled ? 0.38 : 1)
  }
}

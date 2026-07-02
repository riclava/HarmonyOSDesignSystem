import { Token } from '../theme/Tokens';

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
  @StorageProp('compact') compact: boolean = false;
  onChange?: (value: number) => void;

  private btnSize(): number {
    return Token.size.buttonMedium(this.compact);
  }

  private canDecrease(): boolean {
    return !this.stepperDisabled && this.value - this.step >= this.min;
  }

  private canIncrease(): boolean {
    return !this.stepperDisabled && this.value + this.step <= this.max;
  }

  private update(next: number): void {
    this.value = next;
    if (this.onChange) {
      this.onChange(next);
    }
  }

  @Builder
  private stepButton(glyph: Resource, enabled: boolean, accessibility: ResourceStr, action: () => void) {
    SymbolGlyph(glyph)
      .fontSize(Token.icon.sm)
      .fontColor([enabled ? Token.color.primary() : Token.color.onSurfaceVariant()])
      .width(this.btnSize())
      .height(this.btnSize())
      .textAlign(TextAlign.Center)
      .borderRadius(Token.radius.sm)
      .border({ width: 1, color: Token.color.outline() })
      .opacity(enabled ? 1 : 0.38)
      .enabled(enabled)
      .responseRegion({ x: 0, y: (this.btnSize() - Token.size.minTouch) / 2, width: '100%', height: Token.size.minTouch })
      .accessibilityText(accessibility)
      .onClick(action)
  }

  build() {
    Row() {
      this.stepButton($r('sys.symbol.minus'), this.canDecrease(), $r('app.string.ds_stepper_decrease'), () => {
        if (this.canDecrease()) {
          this.update(this.value - this.step);
        }
      })
      Text(this.value.toString())
        .fontSize(Token.font.body.sizeFor(this.compact))
        .fontColor(Token.color.onSurface())
        .textAlign(TextAlign.Center)
        .constraintSize({ minWidth: Token.size.sliderValueWidth })
        .height(this.btnSize())
      this.stepButton($r('sys.symbol.plus'), this.canIncrease(), $r('app.string.ds_stepper_increase'), () => {
        if (this.canIncrease()) {
          this.update(this.value + this.step);
        }
      })
    }
    .alignItems(VerticalAlign.Center)
    .opacity(this.stepperDisabled ? 0.38 : 1)
  }
}

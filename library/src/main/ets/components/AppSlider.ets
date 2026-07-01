import { Token } from '../theme/Tokens';
import { LengthMetrics } from '@kit.ArkUI';

/** 滑块：已选段 Primary，未选 Outline。可选右侧数值显示。 */
@Component
export struct AppSlider {
  @Prop value: number = 0;
  @Prop min: number = 0;
  @Prop max: number = 100;
  @Prop step: number = 1;
  @Prop showValue: boolean = false;
  @StorageLink('isDark') isDark: boolean = false;
  @StorageProp('compact') compact: boolean = false;
  onValueChange?: (value: number) => void;

  build() {
    Row() {
      Slider({ value: this.value, min: this.min, max: this.max, step: this.step })
        .selectedColor(Token.color.primary())
        .trackColor(Token.color.outline())
        .blockColor(Token.color.surface())
        .layoutWeight(1)
        .onChange((v: number) => {
          this.value = v;
          if (this.onValueChange) {
            this.onValueChange(v);
          }
        })
      if (this.showValue) {
        Text(`${Math.round(this.value)}`)
          .fontSize(Token.font.bodySmall.sizeFor(this.compact))
          .fontColor(Token.color.onSurfaceVariant())
          .width(40)
          .textAlign(TextAlign.End)
          .margin({ start: LengthMetrics.vp(Token.space.sm) })
      }
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

import { Token } from '../theme/Tokens';
import { LengthMetrics } from '@kit.ArkUI';

/** 复选框：左侧 Checkbox + 右侧文案。命中区 ≥ 44。 */
@Component
export struct AppCheckbox {
  @Prop label: ResourceStr = '';
  @Prop checked: boolean = false;
  @Prop boxDisabled: boolean = false;
  @StorageLink('isDark') isDark: boolean = false;
  @StorageLink('brand') brand: string = 'default';
  @StorageProp('compact') compact: boolean = false;
  onCheck?: (value: boolean) => void;

  private hasLabel(): boolean {
    return typeof this.label !== 'string' || this.label.length > 0;
  }

  build() {
    Row() {
      Checkbox()
        .select(this.checked)
        .selectedColor(Token.color.primary())
        .enabled(!this.boxDisabled)
        .onChange((v: boolean) => {
          this.checked = v;
          if (this.onCheck) {
            this.onCheck(v);
          }
        })
      if (this.hasLabel()) {
        Text(this.label)
          .fontSize(Token.font.body.sizeFor(this.compact))
          .fontColor(Token.color.onSurface())
          .margin({ start: LengthMetrics.vp(Token.space.xs) })
          .layoutWeight(1)
      }
    }
    .width('100%')
    .constraintSize({ minHeight: Token.size.minTouch })
    .alignItems(VerticalAlign.Center)
    .opacity(this.boxDisabled ? 0.38 : 1)
  }
}

import { Token } from '../theme/Tokens';

/** 复选框：左侧 Checkbox + 右侧文案。命中区 ≥ 44。 */
@Component
export struct AppCheckbox {
  @Prop label: string = '';
  @Prop checked: boolean = false;
  @Prop boxDisabled: boolean = false;
  @StorageLink('isDark') isDark: boolean = false;
  onCheck?: (value: boolean) => void;

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
      if (this.label.length > 0) {
        Text(this.label)
          .fontSize(Token.font.body.size)
          .fontColor(Token.color.onSurface())
          .margin({ left: Token.space.xs })
          .layoutWeight(1)
      }
    }
    .width('100%')
    .constraintSize({ minHeight: 44 })
    .alignItems(VerticalAlign.Center)
    .opacity(this.boxDisabled ? 0.38 : 1)
  }
}

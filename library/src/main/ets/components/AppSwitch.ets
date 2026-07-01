import { Token } from '../theme/Tokens';

/** 开关：可选左侧文案 + 右侧 Switch。命中区 ≥ 44。 */
@Component
export struct AppSwitch {
  @Prop label: string = '';
  @Prop isOn: boolean = false;
  @Prop switchDisabled: boolean = false;
  @StorageLink('isDark') isDark: boolean = false;
  @StorageProp('compact') compact: boolean = false;
  onToggle?: (value: boolean) => void;

  build() {
    Row() {
      if (this.label.length > 0) {
        Text(this.label)
          .fontSize(Token.font.body.sizeFor(this.compact))
          .fontColor(Token.color.onSurface())
          .layoutWeight(1)
      }
      Toggle({ type: ToggleType.Switch, isOn: this.isOn })
        .selectedColor(Token.color.primary())
        .enabled(!this.switchDisabled)
        .opacity(this.switchDisabled ? 0.38 : 1)
        .onChange((v: boolean) => {
          this.isOn = v;
          if (this.onToggle) {
            this.onToggle(v);
          }
        })
    }
    .width('100%')
    .constraintSize({ minHeight: 44 })
    .alignItems(VerticalAlign.Center)
  }
}

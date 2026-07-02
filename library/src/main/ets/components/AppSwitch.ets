import { Token } from '../theme/Tokens';

/** 开关：可选左侧文案 + 右侧 Switch。命中区 ≥ 44。 */
@Component
export struct AppSwitch {
  @Prop label: ResourceStr = '';
  @Prop isOn: boolean = false;
  @Prop switchDisabled: boolean = false;
  @StorageLink('isDark') isDark: boolean = false;
  @StorageLink('brand') brand: string = 'default';
  @StorageProp('compact') compact: boolean = false;
  onToggle?: (value: boolean) => void;

  private hasLabel(): boolean {
    return typeof this.label !== 'string' || this.label.length > 0;
  }

  build() {
    Row() {
      if (this.hasLabel()) {
        Text(this.label)
          .fontSize(Token.font.body.sizeFor(this.compact))
          .fontColor(Token.color.onSurface())
          .layoutWeight(1)
      }
      Toggle({ type: ToggleType.Switch, isOn: this.isOn })
        .selectedColor(Token.color.primary(this.brand))
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
    .constraintSize({ minHeight: Token.size.minTouch })
    .alignItems(VerticalAlign.Center)
  }
}

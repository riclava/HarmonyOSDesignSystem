import { Token } from '../Tokens';

/** 单选项数据模型。 */
export class AppRadioOption {
  label: string;
  value: string;
  constructor(label: string, value: string) {
    this.label = label;
    this.value = value;
  }
}

/** 单选组：横向或纵向排列，选中项高亮 Primary。命中区 ≥ 44。 */
@Component
export struct AppRadioGroup {
  @Prop options: AppRadioOption[] = [];
  @Prop selected: string = '';
  @Prop groupName: string = 'app-radio-group';
  @Prop vertical: boolean = false;
  @StorageLink('isDark') isDark: boolean = false;
  @StorageProp('compact') compact: boolean = false;
  onSelect?: (value: string) => void;

  @Builder
  optionItem(opt: AppRadioOption) {
    Row() {
      Radio({ value: opt.value, group: this.groupName })
        .checked(this.selected === opt.value)
        .radioStyle({ checkedBackgroundColor: Token.color.primary() })
        .onChange((checked: boolean) => {
          if (checked) {
            this.selected = opt.value;
            if (this.onSelect) {
              this.onSelect(opt.value);
            }
          }
        })
      Text(opt.label)
        .fontSize(Token.font.body.sizeFor(this.compact))
        .fontColor(Token.color.onSurface())
        .margin({ left: Token.space.xxs, right: Token.space.lg })
    }
    .constraintSize({ minHeight: 44 })
    .alignItems(VerticalAlign.Center)
  }

  build() {
    if (this.vertical) {
      Column() {
        ForEach(this.options, (opt: AppRadioOption) => {
          this.optionItem(opt)
        })
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    } else {
      Row() {
        ForEach(this.options, (opt: AppRadioOption) => {
          this.optionItem(opt)
        })
      }
      .width('100%')
    }
  }
}

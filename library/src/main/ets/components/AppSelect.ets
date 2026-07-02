import { Token } from '../theme/Tokens';

/**
 * 下拉选择：封装系统 Select，统一按 Token 主题化（字号/字色/圆角/选中色）。
 * 单选。options 为可读文案数组；selectedIndex 为当前选中项（-1 表示未选）。
 */
@Component
export struct AppSelect {
  @Prop options: ResourceStr[] = [];
  @Prop selectedIndex: number = -1;
  @Prop placeholder: ResourceStr = '';
  @Prop selectDisabled: boolean = false;
  @StorageLink('isDark') isDark: boolean = false;
  @StorageLink('brand') brand: string = 'default';
  @StorageProp('compact') compact: boolean = false;
  onSelectIndex?: (index: number) => void;

  private selectOptions(): SelectOption[] {
    return this.options.map((label: ResourceStr): SelectOption => ({ value: label }));
  }

  private currentText(): ResourceStr {
    if (this.selectedIndex >= 0 && this.selectedIndex < this.options.length) {
      return this.options[this.selectedIndex];
    }
    return this.placeholder;
  }

  private controlFont(): Font {
    return { size: Token.font.body.sizeFor(this.compact), family: Token.font.family };
  }

  build() {
    Select(this.selectOptions())
      .selected(this.selectedIndex)
      .value(this.currentText())
      .font(this.controlFont())
      .fontColor(this.selectedIndex >= 0 ? Token.color.onSurface() : Token.color.onSurfaceVariant())
      .optionFont(this.controlFont())
      .optionFontColor(Token.color.onSurface())
      .selectedOptionFont(this.controlFont())
      .selectedOptionFontColor(Token.color.primary(this.brand))
      .selectedOptionBgColor(Token.color.primaryContainer(this.brand))
      .menuBackgroundColor(Token.color.surface())
      .backgroundColor(Token.color.surface())
      .borderRadius(Token.radius.sm)
      .height(Token.size.field(this.compact))
      .constraintSize({ minHeight: Token.size.minTouch })
      .enabled(!this.selectDisabled)
      .opacity(this.selectDisabled ? 0.38 : 1)
      .onSelect((index: number) => {
        this.selectedIndex = index;
        if (this.onSelectIndex) {
          this.onSelectIndex(index);
        }
      })
  }
}

import { Token } from '../Tokens';

/** 日期选择器：内嵌滚轮式，选中项 Primary。 */
@Component
export struct AppDatePicker {
  @Prop selected: Date = new Date();
  @StorageLink('isDark') isDark: boolean = false;
  onPick?: (value: Date) => void;

  build() {
    DatePicker({ selected: this.selected })
      .selectedTextStyle({
        color: Token.color.primary(),
        font: { size: Token.font.titleMedium.size, weight: FontWeight.Medium }
      })
      .textStyle({
        color: Token.color.onSurface(),
        font: { size: Token.font.body.size }
      })
      .disappearTextStyle({
        color: Token.color.onSurfaceVariant(),
        font: { size: Token.font.bodySmall.size }
      })
      .backgroundColor(Token.color.surface())
      .borderRadius(Token.radius.md)
      .onDateChange((value: Date) => {
        if (this.onPick) {
          this.onPick(value);
        }
      })
  }
}

import { Density, Token } from '../theme/Tokens';

/** 日期选择器：内嵌滚轮式，选中项 Primary。 */
@Component
export struct AppDatePicker {
  @Prop selected: Date = new Date();
  @StorageLink('isDark') isDark: boolean = false;
  @StorageLink('brand') brand: string = 'default';
  @StorageProp('density') density: Density = Density.Comfortable;
  onPick?: (value: Date) => void;

  build() {
    DatePicker({ selected: this.selected })
      .selectedTextStyle({
        color: Token.color.primary(this.brand),
        font: { size: Token.font.titleMedium.sizeFor(this.density), weight: FontWeight.Medium }
      })
      .textStyle({
        color: Token.color.onSurface(),
        font: { size: Token.font.body.sizeFor(this.density) }
      })
      .disappearTextStyle({
        color: Token.color.onSurfaceVariant(),
        font: { size: Token.font.bodySmall.sizeFor(this.density) }
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

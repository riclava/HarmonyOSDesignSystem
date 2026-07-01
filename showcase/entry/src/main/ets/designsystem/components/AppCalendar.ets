import { Token } from '../Tokens';

/** 日历选择：胶囊入口点开日历面板，选中填充 Primary。 */
@Component
export struct AppCalendar {
  @Prop selected: Date = new Date();
  @StorageLink('isDark') isDark: boolean = false;
  onPick?: (value: Date) => void;

  build() {
    CalendarPicker({ hintRadius: Token.radius.full, selected: this.selected })
      .edgeAlign(CalendarAlign.END)
      .textStyle({
        color: Token.color.onSurface(),
        font: { size: Token.font.body.size, weight: FontWeight.Normal }
      })
      .backgroundColor(Token.color.surface())
      .borderRadius(Token.radius.sm)
      .onChange((value: Date) => {
        if (this.onPick) {
          this.onPick(value);
        }
      })
  }
}

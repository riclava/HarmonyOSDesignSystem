import { Token, AppDatePicker, AppCalendar, AppToast } from '@riclava/designsystem';
import { SectionLabel } from './Widgets';

@Component
export struct PickersSection {
  @StorageLink('isDark') isDark: boolean = false;

  private format(v: Date): string {
    return `${v.getFullYear()}-${v.getMonth() + 1}-${v.getDate()}`;
  }

  build() {
    Column() {
      SectionLabel({ text: 'DatePicker · 日期选择' })
      AppDatePicker({
        onPick: (v: Date): void => { AppToast.show(this.format(v)); }
      })
        .margin({ bottom: Token.space.lg })

      SectionLabel({ text: 'Calendar · 日历选择' })
      AppCalendar({
        onPick: (v: Date): void => { AppToast.show(this.format(v)); }
      })
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .margin({ bottom: Token.space.lg })
  }
}

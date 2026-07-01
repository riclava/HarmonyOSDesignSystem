import { Token, AppDatePicker, AppTimePicker, AppTimePickerMode, AppCalendar, AppToast } from '@riclava/designsystem';
import { SectionLabel } from './Widgets';

@Component
export struct PickersSection {
  @StorageLink('isDark') isDark: boolean = false;

  private format(v: Date): string {
    return `${v.getFullYear()}-${v.getMonth() + 1}-${v.getDate()}`;
  }

  private formatTime(h: number, m: number): string {
    const hh: string = h < 10 ? `0${h}` : `${h}`;
    const mm: string = m < 10 ? `0${m}` : `${m}`;
    return `${hh}:${mm}`;
  }

  build() {
    Column() {
      SectionLabel({ text: 'DatePicker · 日期选择' })
      AppDatePicker({
        onPick: (v: Date): void => { AppToast.show(this.format(v)); }
      })
        .margin({ bottom: Token.space.lg })

      SectionLabel({ text: 'TimePicker · 时间选择（字段 + 弹窗）' })
      AppTimePicker({
        label: '提醒时间',
        placeholder: '选择时间',
        helper: '点击选择每日提醒时间',
        onPick: (v: TimePickerResult): void => {
          AppToast.show(this.formatTime(v.hour, v.minute));
        }
      })
        .margin({ bottom: Token.space.lg })

      SectionLabel({ text: 'TimePicker · 内嵌滚轮（12 小时 + 秒）' })
      AppTimePicker({
        mode: AppTimePickerMode.Inline,
        useMilitaryTime: false,
        showSeconds: true,
        onPick: (v: TimePickerResult): void => {
          AppToast.show(this.formatTime(v.hour, v.minute));
        }
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

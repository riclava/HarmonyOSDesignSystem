import { Token, AppDatePicker, AppTimePicker, AppTimePickerMode, AppCalendar, AppToast } from '@riclava/designsystem';
import { DemoBlock } from './Widgets';

@Component
export struct PickersSection {
  @StorageLink('isDark') isDark: boolean = false;

  private format(v: Date): string {
    return new Intl.DateTimeFormat().format(v);
  }

  private formatTime(h: number, m: number): string {
    const d: Date = new Date();
    d.setHours(h, m, 0, 0);
    return new Intl.DateTimeFormat(undefined, { hour: '2-digit', minute: '2-digit' }).format(d);
  }

  build() {
    Column() {
      DemoBlock({ title: $r('app.string.sec_datepicker') }) {
        AppDatePicker({
          onPick: (v: Date): void => { AppToast.show(this.format(v)); }
        })
      }

      DemoBlock({ title: $r('app.string.sec_timepicker_field') }) {
        AppTimePicker({
          label: $r('app.string.picker_reminder_label'),
          placeholder: $r('app.string.picker_reminder_placeholder'),
          helper: $r('app.string.picker_reminder_helper'),
          onPick: (v: TimePickerResult): void => {
            AppToast.show(this.formatTime(v.hour, v.minute));
          }
        })
      }

      DemoBlock({ title: $r('app.string.sec_timepicker_inline') }) {
        AppTimePicker({
          mode: AppTimePickerMode.Inline,
          useMilitaryTime: false,
          showSeconds: true,
          onPick: (v: TimePickerResult): void => {
            AppToast.show(this.formatTime(v.hour, v.minute));
          }
        })
      }

      DemoBlock({ title: $r('app.string.sec_calendar') }) {
        AppCalendar({
          onPick: (v: Date): void => { AppToast.show(this.format(v)); }
        })
      }
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .margin({ bottom: Token.space.lg })
  }
}

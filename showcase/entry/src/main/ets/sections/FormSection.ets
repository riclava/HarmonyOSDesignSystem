import { Token, AppTextField, AppSearch, AppCheckbox, AppSwitch, AppSlider, AppRadioGroup, AppRadioOption } from '@riclava/designsystem';
import { SectionLabel } from './Widgets';

@Component
export struct FormSection {
  @StorageLink('isDark') isDark: boolean = false;
  @State name: string = '';
  @State search: string = '';
  @State agree: boolean = true;
  @State notify: boolean = true;
  @State volume: number = 40;
  @State plan: string = 'monthly';

  private planOptions: AppRadioOption[] = [
    new AppRadioOption($r('app.string.plan_monthly'), 'monthly'),
    new AppRadioOption($r('app.string.plan_yearly'), 'yearly')
  ];

  build() {
    Column() {
      SectionLabel({ text: $r('app.string.sec_textfield') })
      AppTextField({
        label: $r('app.string.field_nickname_label'),
        text: this.name,
        placeholder: $r('app.string.field_nickname_placeholder'),
        helper: $r('app.string.field_nickname_helper'),
        onTextChange: (v: string): void => { this.name = v; }
      })
      AppTextField({
        label: $r('app.string.field_email_label'),
        placeholder: 'name@example.com',
        error: $r('app.string.field_email_error')
      })
        .margin({ top: Token.space.md })
      AppTextField({ label: $r('app.string.field_disabled_label'), text: $r('app.string.field_disabled_text'), fieldDisabled: true })
        .margin({ top: Token.space.md, bottom: Token.space.md })

      SectionLabel({ text: $r('app.string.sec_search') })
      AppSearch({
        text: this.search,
        placeholder: $r('app.string.search_placeholder'),
        onTextChange: (v: string): void => { this.search = v; }
      })
        .margin({ bottom: Token.space.md })

      SectionLabel({ text: $r('app.string.sec_checkbox') })
      AppCheckbox({
        label: $r('app.string.checkbox_agree'),
        checked: this.agree,
        onCheck: (v: boolean): void => { this.agree = v; }
      })

      SectionLabel({ text: $r('app.string.sec_radio') })
      AppRadioGroup({
        options: this.planOptions,
        selected: this.plan,
        groupName: 'plan',
        onSelect: (v: string): void => { this.plan = v; }
      })

      SectionLabel({ text: $r('app.string.sec_switch') })
      AppSwitch({
        label: $r('app.string.switch_notify'),
        isOn: this.notify,
        onToggle: (v: boolean): void => { this.notify = v; }
      })
      AppSwitch({ label: $r('app.string.field_disabled_label'), isOn: true, switchDisabled: true })

      SectionLabel({ text: $r('app.string.sec_slider') })
      AppSlider({
        value: this.volume,
        showValue: true,
        onValueChange: (v: number): void => { this.volume = v; }
      })
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .margin({ bottom: Token.space.lg })
  }
}

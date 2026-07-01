import { Token } from '../designsystem/Tokens';
import { SectionLabel } from './Widgets';
import { AppTextField } from '../designsystem/components/AppTextField';
import { AppSearch } from '../designsystem/components/AppSearch';
import { AppCheckbox } from '../designsystem/components/AppCheckbox';
import { AppSwitch } from '../designsystem/components/AppSwitch';
import { AppSlider } from '../designsystem/components/AppSlider';
import { AppRadioGroup, AppRadioOption } from '../designsystem/components/AppRadioGroup';

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
    new AppRadioOption('按月', 'monthly'),
    new AppRadioOption('按年', 'yearly')
  ];

  build() {
    Column() {
      SectionLabel({ text: 'TextField · 输入框' })
      AppTextField({
        label: '昵称',
        text: this.name,
        placeholder: '请输入昵称',
        helper: '2~16 个字符',
        onTextChange: (v: string): void => { this.name = v; }
      })
      AppTextField({
        label: '邮箱',
        placeholder: 'name@example.com',
        error: '邮箱格式不正确'
      })
        .margin({ top: Token.space.md })
      AppTextField({ label: '禁用态', text: '不可编辑', fieldDisabled: true })
        .margin({ top: Token.space.md, bottom: Token.space.md })

      SectionLabel({ text: 'Search · 搜索框' })
      AppSearch({
        text: this.search,
        placeholder: '搜索组件…',
        onTextChange: (v: string): void => { this.search = v; }
      })
        .margin({ bottom: Token.space.md })

      SectionLabel({ text: 'Checkbox · 复选框' })
      AppCheckbox({
        label: '我已阅读并同意用户协议',
        checked: this.agree,
        onCheck: (v: boolean): void => { this.agree = v; }
      })

      SectionLabel({ text: 'Radio · 单选框' })
      AppRadioGroup({
        options: this.planOptions,
        selected: this.plan,
        groupName: 'plan',
        onSelect: (v: string): void => { this.plan = v; }
      })

      SectionLabel({ text: 'Switch · 开关' })
      AppSwitch({
        label: '接收推送通知',
        isOn: this.notify,
        onToggle: (v: boolean): void => { this.notify = v; }
      })
      AppSwitch({ label: '禁用态', isOn: true, switchDisabled: true })

      SectionLabel({ text: 'Slider · 滑块' })
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

import { Token } from '../designsystem/Tokens';
import { SectionLabel } from './Widgets';
import { AppButton, AppButtonType, AppButtonSize } from '../designsystem/components/AppButton';
import { AppCard } from '../designsystem/components/AppCard';
import { AppTag, AppTagTone } from '../designsystem/components/AppTag';

@Component
export struct ComponentsSection {
  @StorageLink('isDark') isDark: boolean = false;
  @State switchOn: boolean = true;
  @State sliderVal: number = 40;
  @State inputText: string = '';

  build() {
    Column() {
      // Buttons
      SectionLabel({ text: 'Button · 按钮' })
      Flex({ wrap: FlexWrap.Wrap }) {
        AppButton({ label: 'Primary', type: AppButtonType.Primary })
          .margin({ right: Token.space.xs, bottom: Token.space.xs })
        AppButton({ label: 'Secondary', type: AppButtonType.Secondary })
          .margin({ right: Token.space.xs, bottom: Token.space.xs })
        AppButton({ label: 'Text', type: AppButtonType.Text })
          .margin({ right: Token.space.xs, bottom: Token.space.xs })
        AppButton({ label: 'Danger', type: AppButtonType.Danger })
          .margin({ right: Token.space.xs, bottom: Token.space.xs })
        AppButton({ label: 'Disabled', type: AppButtonType.Primary, disabled: true })
          .margin({ right: Token.space.xs, bottom: Token.space.xs })
        AppButton({ label: 'Small', type: AppButtonType.Primary, btnSize: AppButtonSize.Small })
          .margin({ right: Token.space.xs, bottom: Token.space.xs })
      }
      .width('100%')
      .margin({ bottom: Token.space.md })

      // Tags
      SectionLabel({ text: 'Tag · 标签' })
      Flex({ wrap: FlexWrap.Wrap }) {
        AppTag({ label: 'Neutral', tone: AppTagTone.Neutral }).margin({ right: Token.space.xs, bottom: Token.space.xs })
        AppTag({ label: 'Primary', tone: AppTagTone.Primary }).margin({ right: Token.space.xs, bottom: Token.space.xs })
        AppTag({ label: 'Success', tone: AppTagTone.Success }).margin({ right: Token.space.xs, bottom: Token.space.xs })
        AppTag({ label: 'Warning', tone: AppTagTone.Warning }).margin({ right: Token.space.xs, bottom: Token.space.xs })
        AppTag({ label: 'Danger', tone: AppTagTone.Danger }).margin({ right: Token.space.xs, bottom: Token.space.xs })
      }
      .width('100%')
      .margin({ bottom: Token.space.md })

      // Card
      SectionLabel({ text: 'Card · 卡片' })
      Column() {
        AppCard() {
          Text('卡片标题')
            .fontSize(Token.font.titleMedium.size)
            .fontWeight(Token.font.titleMedium.weight)
            .fontColor(Token.color.onSurface())
          Text('使用 Surface 底色、Level1 阴影、RadiusMD 圆角与 MD 内边距。')
            .fontSize(Token.font.bodySmall.size)
            .fontColor(Token.color.onSurfaceVariant())
            .margin({ top: Token.space.xxs })
        }
      }
      .width('100%')
      .margin({ bottom: Token.space.md })

      // TextField
      SectionLabel({ text: 'TextField · 输入框' })
      TextInput({ placeholder: '请输入内容', text: this.inputText })
        .fontSize(Token.font.body.size)
        .fontColor(Token.color.onSurface())
        .placeholderColor(Token.color.onSurfaceVariant())
        .backgroundColor(Token.color.surface())
        .height(48)
        .borderRadius(Token.radius.sm)
        .border({ width: 1, color: Token.color.outline() })
        .padding({ left: Token.space.md, right: Token.space.md })
        .onChange((v: string) => { this.inputText = v; })
        .margin({ bottom: Token.space.md })

      // Switch + Slider + Progress
      SectionLabel({ text: 'Switch · Slider · Progress' })
      Row() {
        Toggle({ type: ToggleType.Switch, isOn: this.switchOn })
          .selectedColor(Token.color.primary())
          .onChange((on: boolean) => { this.switchOn = on; })
        Text(this.switchOn ? 'On' : 'Off')
          .fontSize(Token.font.bodySmall.size)
          .fontColor(Token.color.onSurfaceVariant())
          .margin({ left: Token.space.xs })
      }
      .width('100%')
      .margin({ bottom: Token.space.xs })

      Slider({ value: this.sliderVal, min: 0, max: 100 })
        .selectedColor(Token.color.primary())
        .trackColor(Token.color.outline())
        .onChange((v: number) => { this.sliderVal = v; })

      Progress({ value: this.sliderVal, total: 100, type: ProgressType.Linear })
        .color(Token.color.primary())
        .backgroundColor(Token.color.outline())
        .margin({ top: Token.space.xs })
    }
    .width('100%')
    .margin({ bottom: Token.space.lg })
  }
}

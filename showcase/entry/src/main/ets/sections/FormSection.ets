import { Token } from '../designsystem/Tokens';
import { SectionLabel } from './Widgets';

@Component
export struct FormSection {
  @StorageLink('isDark') isDark: boolean = false;
  @State search: string = '';
  @State agree: boolean = true;
  @State plan: string = 'monthly';

  build() {
    Column() {
      // Search
      SectionLabel({ text: 'Search · 搜索框' })
      Row() {
        Text('🔍')
          .fontSize(Token.font.bodySmall.size)
          .margin({ right: Token.space.xs })
        TextInput({ placeholder: '搜索…', text: this.search })
          .fontSize(Token.font.body.size)
          .fontColor(Token.color.onSurface())
          .placeholderColor(Token.color.onSurfaceVariant())
          .backgroundColor(Token.color.transparent())
          .borderRadius(0)
          .padding(0)
          .layoutWeight(1)
          .onChange((v: string) => { this.search = v; })
      }
      .width('100%')
      .height(40)
      .padding({ left: Token.space.md, right: Token.space.md })
      .backgroundColor(Token.color.surface())
      .borderRadius(Token.radius.full)
      .border({ width: 1, color: Token.color.outline() })
      .margin({ bottom: Token.space.md })

      // Checkbox
      SectionLabel({ text: 'Checkbox · 复选框' })
      Row() {
        Checkbox()
          .select(this.agree)
          .selectedColor(Token.color.primary())
          .onChange((v: boolean) => { this.agree = v; })
        Text('我已阅读并同意用户协议')
          .fontSize(Token.font.body.size)
          .fontColor(Token.color.onSurface())
          .margin({ left: Token.space.xs })
      }
      .width('100%')
      .margin({ bottom: Token.space.md })

      // Radio group
      SectionLabel({ text: 'Radio · 单选框' })
      Row() {
        Radio({ value: 'monthly', group: 'plan' })
          .checked(this.plan === 'monthly')
          .radioStyle({ checkedBackgroundColor: Token.color.primary() })
          .onChange((c: boolean) => { if (c) this.plan = 'monthly'; })
        Text('按月')
          .fontSize(Token.font.body.size)
          .fontColor(Token.color.onSurface())
          .margin({ right: Token.space.lg, left: Token.space.xxs })
        Radio({ value: 'yearly', group: 'plan' })
          .checked(this.plan === 'yearly')
          .radioStyle({ checkedBackgroundColor: Token.color.primary() })
          .onChange((c: boolean) => { if (c) this.plan = 'yearly'; })
        Text('按年')
          .fontSize(Token.font.body.size)
          .fontColor(Token.color.onSurface())
          .margin({ left: Token.space.xxs })
      }
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .margin({ bottom: Token.space.lg })
  }
}

import { Token, AppButton, AppButtonType, AppButtonSize, AppCard, AppTag, AppTagTone, AppToast } from '@riclava/designsystem';
import { SectionLabel } from './Widgets';

@Component
export struct ComponentsSection {
  @StorageLink('isDark') isDark: boolean = false;
  @State loading: boolean = false;

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

      // Loading button
      SectionLabel({ text: 'Button · Loading' })
      AppButton({
        label: this.loading ? '提交中' : '点击提交',
        type: AppButtonType.Primary,
        loading: this.loading,
        onClickAction: (): void => {
          this.loading = true;
          setTimeout((): void => { this.loading = false; }, 1500);
        }
      })
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

      // Card（可点击）
      SectionLabel({ text: 'Card · 卡片（可点击）' })
      Column() {
        AppCard({
          clickable: true,
          onCardClick: (): void => { AppToast.show('卡片被点击'); }
        }) {
          Text('卡片标题')
            .fontSize(Token.font.titleMedium.size)
            .fontWeight(Token.font.titleMedium.weight)
            .fontColor(Token.color.onSurface())
          Text('整卡可点，按下时阴影升至 Level2。使用 Surface 底色、RadiusMD 圆角与 MD 内边距。')
            .fontSize(Token.font.bodySmall.size)
            .fontColor(Token.color.onSurfaceVariant())
            .margin({ top: Token.space.xxs })
        }
      }
      .width('100%')
      .margin({ bottom: Token.space.md })
    }
    .width('100%')
    .margin({ bottom: Token.space.lg })
  }
}

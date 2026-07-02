import { Token, AppButton, AppButtonType, AppButtonSize, AppCard, AppTag, AppTagTone, AppToast } from '@riclava/designsystem';
import { LengthMetrics } from '@kit.ArkUI';
import { SectionLabel } from './Widgets';

@Component
export struct ComponentsSection {
  @StorageLink('isDark') isDark: boolean = false;
  @State loading: boolean = false;

  build() {
    Column() {
      // Buttons
      SectionLabel({ text: $r('app.string.sec_button') })
      Flex({ wrap: FlexWrap.Wrap }) {
        AppButton({ label: 'Primary', type: AppButtonType.Primary })
          .margin({ end: LengthMetrics.vp(Token.space.xs), bottom: Token.space.xs })
        AppButton({ label: 'Secondary', type: AppButtonType.Secondary })
          .margin({ end: LengthMetrics.vp(Token.space.xs), bottom: Token.space.xs })
        AppButton({ label: 'Text', type: AppButtonType.Text })
          .margin({ end: LengthMetrics.vp(Token.space.xs), bottom: Token.space.xs })
        AppButton({ label: 'Danger', type: AppButtonType.Danger })
          .margin({ end: LengthMetrics.vp(Token.space.xs), bottom: Token.space.xs })
        AppButton({ label: 'Disabled', type: AppButtonType.Primary, disabled: true })
          .margin({ end: LengthMetrics.vp(Token.space.xs), bottom: Token.space.xs })
        AppButton({ label: 'Small', type: AppButtonType.Primary, btnSize: AppButtonSize.Small })
          .margin({ end: LengthMetrics.vp(Token.space.xs), bottom: Token.space.xs })
      }
      .width('100%')
      .margin({ bottom: Token.space.md })

      // Loading button
      SectionLabel({ text: $r('app.string.sec_button_loading') })
      AppButton({
        label: this.loading ? $r('app.string.btn_submitting') : $r('app.string.btn_submit'),
        type: AppButtonType.Primary,
        loading: this.loading,
        onClickAction: (): void => {
          this.loading = true;
          setTimeout((): void => { this.loading = false; }, 1500);
        }
      })
        .margin({ bottom: Token.space.md })

      // Tags
      SectionLabel({ text: $r('app.string.sec_tag') })
      Flex({ wrap: FlexWrap.Wrap }) {
        AppTag({ label: 'Neutral', tone: AppTagTone.Neutral }).margin({ end: LengthMetrics.vp(Token.space.xs), bottom: Token.space.xs })
        AppTag({ label: 'Primary', tone: AppTagTone.Primary }).margin({ end: LengthMetrics.vp(Token.space.xs), bottom: Token.space.xs })
        AppTag({ label: 'Success', tone: AppTagTone.Success }).margin({ end: LengthMetrics.vp(Token.space.xs), bottom: Token.space.xs })
        AppTag({ label: 'Warning', tone: AppTagTone.Warning }).margin({ end: LengthMetrics.vp(Token.space.xs), bottom: Token.space.xs })
        AppTag({ label: 'Danger', tone: AppTagTone.Danger }).margin({ end: LengthMetrics.vp(Token.space.xs), bottom: Token.space.xs })
      }
      .width('100%')
      .margin({ bottom: Token.space.md })

      // Card（可点击）
      SectionLabel({ text: $r('app.string.sec_card') })
      Column() {
        AppCard({
          clickable: true,
          onCardClick: (): void => { AppToast.show($r('app.string.card_click_toast')); }
        }) {
          Text($r('app.string.card_title'))
            .fontSize(Token.font.titleMedium.size)
            .fontWeight(Token.font.titleMedium.weight)
            .fontColor(Token.color.onSurface())
          Text($r('app.string.card_body'))
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

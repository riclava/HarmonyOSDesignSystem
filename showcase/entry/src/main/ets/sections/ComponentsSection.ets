import { Token, AppButton, AppButtonType, AppButtonSize, AppCard, AppTag, AppTagTone, AppToast } from '@riclava/designsystem';
import { LengthMetrics } from '@kit.ArkUI';
import { DemoBlock } from './Widgets';

@Component
export struct ComponentsSection {
  @StorageLink('isDark') isDark: boolean = false;
  @StorageProp('compact') compact: boolean = false;
  @State loading: boolean = false;

  build() {
    Column() {
      // Buttons
      DemoBlock({ title: $r('app.string.sec_button') }) {
        Flex({ wrap: FlexWrap.Wrap }) {
          AppButton({ label: $r('app.string.demo_button_primary'), type: AppButtonType.Primary })
            .margin({ end: LengthMetrics.vp(Token.space.xs), bottom: Token.space.xs })
          AppButton({ label: $r('app.string.demo_button_secondary'), type: AppButtonType.Secondary })
            .margin({ end: LengthMetrics.vp(Token.space.xs), bottom: Token.space.xs })
          AppButton({ label: $r('app.string.demo_button_text'), type: AppButtonType.Text })
            .margin({ end: LengthMetrics.vp(Token.space.xs), bottom: Token.space.xs })
          AppButton({ label: $r('app.string.demo_button_danger'), type: AppButtonType.Danger })
            .margin({ end: LengthMetrics.vp(Token.space.xs), bottom: Token.space.xs })
          AppButton({ label: $r('app.string.demo_button_disabled'), type: AppButtonType.Primary, disabled: true })
            .margin({ end: LengthMetrics.vp(Token.space.xs), bottom: Token.space.xs })
          AppButton({ label: $r('app.string.demo_button_small'), type: AppButtonType.Primary, btnSize: AppButtonSize.Small })
            .margin({ end: LengthMetrics.vp(Token.space.xs), bottom: Token.space.xs })
        }
        .width('100%')
      }

      // Loading button
      DemoBlock({ title: $r('app.string.sec_button_loading') }) {
        AppButton({
          label: this.loading ? $r('app.string.btn_submitting') : $r('app.string.btn_submit'),
          type: AppButtonType.Primary,
          loading: this.loading,
          onClickAction: (): void => {
            this.loading = true;
            setTimeout((): void => { this.loading = false; }, 1500);
          }
        })
      }

      // Tags
      DemoBlock({ title: $r('app.string.sec_tag') }) {
        Flex({ wrap: FlexWrap.Wrap }) {
          AppTag({ label: $r('app.string.demo_tag_neutral'), tone: AppTagTone.Neutral })
            .margin({ end: LengthMetrics.vp(Token.space.xs), bottom: Token.space.xs })
          AppTag({ label: $r('app.string.demo_tag_primary'), tone: AppTagTone.Primary })
            .margin({ end: LengthMetrics.vp(Token.space.xs), bottom: Token.space.xs })
          AppTag({ label: $r('app.string.demo_tag_success'), tone: AppTagTone.Success })
            .margin({ end: LengthMetrics.vp(Token.space.xs), bottom: Token.space.xs })
          AppTag({ label: $r('app.string.demo_tag_warning'), tone: AppTagTone.Warning })
            .margin({ end: LengthMetrics.vp(Token.space.xs), bottom: Token.space.xs })
          AppTag({ label: $r('app.string.demo_tag_danger'), tone: AppTagTone.Danger })
            .margin({ end: LengthMetrics.vp(Token.space.xs), bottom: Token.space.xs })
        }
        .width('100%')
      }

      // Card（可点击）
      DemoBlock({ title: $r('app.string.sec_card') }) {
        AppCard({
          clickable: true,
          onCardClick: (): void => { AppToast.show($r('app.string.card_click_toast')); }
        }) {
          Text($r('app.string.card_title'))
            .fontSize(Token.font.titleMedium.sizeFor(this.compact))
            .lineHeight(Token.font.titleMedium.lineHeightFor(this.compact))
            .fontWeight(Token.font.titleMedium.weight)
            .fontColor(Token.color.onSurface())
          Text($r('app.string.card_body'))
            .fontSize(Token.font.bodySmall.sizeFor(this.compact))
            .lineHeight(Token.font.bodySmall.lineHeightFor(this.compact))
            .fontColor(Token.color.onSurfaceVariant())
            .margin({ top: Token.space.xxs })
        }
      }
    }
    .width('100%')
    .margin({ bottom: Token.space.lg })
  }
}

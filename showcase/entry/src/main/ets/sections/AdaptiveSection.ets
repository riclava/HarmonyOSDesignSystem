import { Token } from '@riclava/designsystem';
import { LengthMetrics } from '@kit.ArkUI';
import { SectionLabel } from './Widgets';

@Component
export struct AdaptiveSection {
  @StorageLink('isDark') isDark: boolean = false;
  @State breakpoint: string = 'sm';

  @Builder
  cell(label: ResourceStr) {
    Column() {
      Text(label)
        .fontSize(Token.font.label.size)
        .fontColor(Token.color.onPrimary())
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .height(Token.size.rowMin(false))
    .width('100%')
    .backgroundColor(Token.color.primary())
    .borderRadius(Token.radius.sm)
  }

  build() {
    Column() {
      SectionLabel({ text: $r('app.string.sec_adaptive') })
      Text($r('app.string.adaptive_breakpoint', this.breakpoint))
        .fontSize(Token.font.caption.size)
        .fontColor(Token.color.onSurfaceVariant())
        .margin({ bottom: Token.space.sm })

      // 断点：<600 单列，600~840 两列，>840 三列
      GridRow({
        columns: { sm: 4, md: 8, lg: 12 },
        gutter: { x: Token.space.sm, y: Token.space.sm },
        breakpoints: { value: ['600vp', '840vp'], reference: BreakpointsReference.WindowSize }
      }) {
        ForEach(['1', '2', '3'], (item: string) => {
          GridCol({ span: { sm: 4, md: 4, lg: 4 } }) {
            this.cell($r('app.string.adaptive_item', item))
          }
        })
      }
      .width('100%')
      .onBreakpointChange((bp: string) => { this.breakpoint = bp; })

      SectionLabel({ text: $r('app.string.sec_accessibility') })
      // 触摸区域：视觉 24，命中 ≥ 44
      Row() {
        Stack() {
          Circle({ width: Token.size.avatarXs, height: Token.size.avatarXs }).fill(Token.color.primary())
        }
        .width(Token.size.minTouch).height(Token.size.minTouch)
        .backgroundColor(Token.color.primaryContainer())
        .borderRadius(Token.radius.sm)
        .accessibilityText($r('app.string.a11y_more'))

        Column() {
          Text($r('app.string.a11y_touch_title'))
            .fontSize(Token.font.body.size)
            .fontColor(Token.color.onSurface())
          Text($r('app.string.a11y_touch_desc'))
            .fontSize(Token.font.caption.size)
            .fontColor(Token.color.onSurfaceVariant())
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
        .margin({ start: LengthMetrics.vp(Token.space.md) })
      }
      .width('100%')
      .margin({ top: Token.space.xs })

      // 对比度示例
      Row() {
        Text($r('app.string.contrast_body'))
          .fontSize(Token.font.body.size)
          .fontColor(Token.color.onSurface())
          .backgroundColor(Token.color.surface())
          .padding(Token.space.xs)
          .borderRadius(Token.radius.xs)
          .margin({ end: LengthMetrics.vp(Token.space.xs) })
        Text($r('app.string.contrast_primary'))
          .fontSize(Token.font.body.size)
          .fontColor(Token.color.onPrimary())
          .backgroundColor(Token.color.primary())
          .padding(Token.space.xs)
          .borderRadius(Token.radius.xs)
      }
      .width('100%')
      .margin({ top: Token.space.md })
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .margin({ bottom: Token.space.lg })
  }
}

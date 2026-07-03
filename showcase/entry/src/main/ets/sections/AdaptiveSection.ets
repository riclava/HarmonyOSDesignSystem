import { Density, Token } from '@riclava/designsystem';
import { LengthMetrics } from '@kit.ArkUI';
import { DemoBlock, SectionLabel } from './Widgets';

@Component
export struct AdaptiveSection {
  @StorageLink('isDark') isDark: boolean = false;
  @StorageLink('brand') brand: string = 'default';
  @StorageProp('density') density: Density = Density.Comfortable;
  @State breakpoint: string = 'sm';

  @Builder
  cell(label: ResourceStr) {
    Column() {
      Text(label)
        .fontSize(Token.font.label.sizeFor(this.density))
        .lineHeight(Token.font.label.lineHeightFor(this.density))
        .fontColor(Token.color.onPrimary(this.brand))
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .height(Token.size.rowMin(this.density))
    .width('100%')
    .backgroundColor(Token.color.primary(this.brand))
    .borderRadius(Token.radius.sm)
  }

  build() {
    Column() {
      SectionLabel({ text: $r('app.string.sec_adaptive') })
      DemoBlock({ title: $r('app.string.sec_adaptive_grid') }) {
        Text($r('app.string.adaptive_breakpoint', this.breakpoint))
          .fontSize(Token.font.caption.sizeFor(this.density))
          .lineHeight(Token.font.caption.lineHeightFor(this.density))
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
      }

      DemoBlock({ title: $r('app.string.sec_accessibility') }) {
        // 触摸区域：视觉 24，命中 ≥ 44
        Row() {
          Stack() {
            Circle({ width: Token.size.avatarXs, height: Token.size.avatarXs }).fill(Token.color.primary(this.brand))
          }
          .width(Token.size.minTouch).height(Token.size.minTouch)
          .backgroundColor(Token.color.primaryContainer(this.brand))
          .borderRadius(Token.radius.sm)
          .accessibilityText($r('app.string.a11y_more'))

          Column() {
            Text($r('app.string.a11y_touch_title'))
              .fontSize(Token.font.body.sizeFor(this.density))
              .lineHeight(Token.font.body.lineHeightFor(this.density))
              .fontColor(Token.color.onSurface())
            Text($r('app.string.a11y_touch_desc'))
              .fontSize(Token.font.caption.sizeFor(this.density))
              .lineHeight(Token.font.caption.lineHeightFor(this.density))
              .fontColor(Token.color.onSurfaceVariant())
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)
          .margin({ start: LengthMetrics.vp(Token.space.md) })
        }
        .width('100%')
      }

      DemoBlock({ title: $r('app.string.sec_contrast') }) {
        // 对比度示例
        Flex({ wrap: FlexWrap.Wrap }) {
          Text($r('app.string.contrast_body'))
            .fontSize(Token.font.body.sizeFor(this.density))
            .lineHeight(Token.font.body.lineHeightFor(this.density))
            .fontColor(Token.color.onSurface())
            .backgroundColor(Token.color.surface())
            .padding(Token.space.xs)
            .borderRadius(Token.radius.xs)
            .border({ width: 1, color: Token.color.divider() })
            .margin({ end: LengthMetrics.vp(Token.space.xs), bottom: Token.space.xs })
          Text($r('app.string.contrast_primary'))
            .fontSize(Token.font.body.sizeFor(this.density))
            .lineHeight(Token.font.body.lineHeightFor(this.density))
            .fontColor(Token.color.onPrimary(this.brand))
            .backgroundColor(Token.color.primary(this.brand))
            .padding(Token.space.xs)
            .borderRadius(Token.radius.xs)
            .margin({ bottom: Token.space.xs })
        }
        .width('100%')
      }
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .margin({ bottom: Token.space.lg })
  }
}

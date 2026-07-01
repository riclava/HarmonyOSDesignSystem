import { Token } from '../designsystem/Tokens';
import { SectionLabel } from './Widgets';

@Component
export struct AdaptiveSection {
  @StorageLink('isDark') isDark: boolean = false;
  @State breakpoint: string = 'sm';

  @Builder
  cell(label: string) {
    Column() {
      Text(label)
        .fontSize(Token.font.label.size)
        .fontColor(Token.color.onPrimary())
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .height(56)
    .width('100%')
    .backgroundColor(Token.color.primary())
    .borderRadius(Token.radius.sm)
  }

  build() {
    Column() {
      SectionLabel({ text: 'Adaptive · 自适应栅格' })
      Text(`当前断点：${this.breakpoint}（改变窗口/设备宽度可观察列数变化）`)
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
            this.cell(`Item ${item}`)
          }
        })
      }
      .width('100%')
      .onBreakpointChange((bp: string) => { this.breakpoint = bp; })

      SectionLabel({ text: 'Accessibility · 无障碍' })
      // 触摸区域：视觉 24，命中 ≥ 44
      Row() {
        Stack() {
          Circle({ width: 24, height: 24 }).fill(Token.color.primary())
        }
        .width(44).height(44)
        .backgroundColor(Token.color.primaryContainer())
        .borderRadius(Token.radius.sm)
        .accessibilityText('更多操作')

        Column() {
          Text('触摸命中区 ≥ 44×44vp')
            .fontSize(Token.font.body.size)
            .fontColor(Token.color.onSurface())
          Text('图标视觉 24，外围命中区 44（浅底示意）。图标按钮需带语义 Label。')
            .fontSize(Token.font.caption.size)
            .fontColor(Token.color.onSurfaceVariant())
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
        .margin({ left: Token.space.md })
      }
      .width('100%')
      .margin({ top: Token.space.xs })

      // 对比度示例
      Row() {
        Text('正文 4.5:1')
          .fontSize(Token.font.body.size)
          .fontColor(Token.color.onSurface())
          .backgroundColor(Token.color.surface())
          .padding(Token.space.xs)
          .borderRadius(Token.radius.xs)
          .margin({ right: Token.space.xs })
        Text('主色按钮')
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

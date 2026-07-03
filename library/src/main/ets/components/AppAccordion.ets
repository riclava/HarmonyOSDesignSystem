import { Density, Token } from '../theme/Tokens';
import { LengthMetrics } from '@kit.ArkUI';

/**
 * 折叠面板：标题行点击展开/收起，内容通过 content 插槽注入。
 * 展开状态由 expanded 双向持有；箭头随状态旋转。
 */
@Component
export struct AppAccordion {
  @Prop title: ResourceStr = '';
  @Prop expanded: boolean = false;
  @StorageLink('isDark') isDark: boolean = false;
  @StorageLink('brand') brand: string = 'default';
  @StorageProp('density') density: Density = Density.Comfortable;
  onToggle?: (expanded: boolean) => void;
  @BuilderParam content: () => void;

  private headerHeight(): number {
    return Token.size.rowMin(this.density);
  }

  build() {
    Column() {
      Row() {
        Text(this.title)
          .fontSize(Token.font.titleMedium.sizeFor(this.density))
          .fontWeight(Token.font.titleMedium.weight)
          .fontColor(Token.color.onSurface())
          .layoutWeight(1)
          .textAlign(TextAlign.Start)
        SymbolGlyph($r('sys.symbol.chevron_down'))
          .fontSize(Token.icon.sm)
          .fontColor([Token.color.onSurfaceVariant()])
          .width(Token.icon.md)
          .height(Token.icon.md)
          .rotate({ angle: this.expanded ? 180 : 0 })
          .animation({ duration: Token.motion.fast, curve: this.expanded ? Token.motion.easeOut : Token.motion.easeIn })
      }
      .width('100%')
      .constraintSize({ minHeight: this.headerHeight() })
      .padding({ start: LengthMetrics.vp(Token.space.md), end: LengthMetrics.vp(Token.space.md) })
      .alignItems(VerticalAlign.Center)
      .onClick(() => {
        this.expanded = !this.expanded;
        if (this.onToggle) {
          this.onToggle(this.expanded);
        }
      })
      if (this.expanded) {
        Column() {
          this.content()
        }
        .width('100%')
        .padding({
          start: LengthMetrics.vp(Token.space.md),
          end: LengthMetrics.vp(Token.space.md),
          bottom: LengthMetrics.vp(Token.space.md)
        })
        .transition(TransitionEffect.OPACITY.animation({ duration: Token.motion.fast, curve: Token.motion.easeOut }))
      }
      Divider().color(Token.color.divider())
    }
    .width('100%')
    .backgroundColor(Token.color.surface())
  }
}

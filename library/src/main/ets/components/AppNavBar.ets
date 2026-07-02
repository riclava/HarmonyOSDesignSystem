import { Token, isRTL } from '../theme/Tokens';
import { LengthMetrics } from '@kit.ArkUI';

/**
 * 顶部导航栏：返回按钮（可选）+ 标题 + 尾部操作插槽（可选）。
 * 返回箭头方向随 RTL 镜像；命中区 ≥ 44。
 */
@Component
export struct AppNavBar {
  @Prop title: ResourceStr = '';
  @Prop showBack: boolean = true;
  @StorageLink('isDark') isDark: boolean = false;
  @StorageLink('brand') brand: string = 'default';
  @StorageProp('compact') compact: boolean = false;
  onBack?: () => void;
  @BuilderParam trailing?: () => void;

  private barHeight(): number {
    return Math.max(Token.size.rowMin(this.compact), Token.size.minTouch);
  }

  private backIcon(): Resource {
    return isRTL() ? $r('sys.symbol.chevron_right') : $r('sys.symbol.chevron_left');
  }

  build() {
    Row() {
      if (this.showBack) {
        SymbolGlyph(this.backIcon())
          .fontSize(Token.icon.md)
          .fontColor([Token.color.onSurface()])
          .width(Token.size.minTouch)
          .height(Token.size.minTouch)
          .accessibilityText($r('app.string.ds_navbar_back'))
          .onClick(() => {
            if (this.onBack) {
              this.onBack();
            }
          })
      }
      Text(this.title)
        .fontSize(Token.font.titleLarge.sizeFor(this.compact))
        .fontWeight(Token.font.titleLarge.weight)
        .fontColor(Token.color.onSurface())
        .layoutWeight(1)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .textAlign(TextAlign.Start)
        .margin({ start: LengthMetrics.vp(this.showBack ? Token.space.xs : Token.space.md) })
      if (this.trailing) {
        this.trailing()
      }
    }
    .width('100%')
    .height(this.barHeight())
    .padding({ start: LengthMetrics.vp(Token.space.xs), end: LengthMetrics.vp(Token.space.md) })
    .backgroundColor(Token.color.surface())
    .alignItems(VerticalAlign.Center)
  }
}

import { Token, isRTL } from '../theme/Tokens';
import { LengthMetrics } from '@kit.ArkUI';

/**
 * 面包屑：以分隔符连接的层级路径，最后一项为当前页（不可点）。
 * 分隔符方向随 RTL 镜像。
 */
@Component
export struct AppBreadcrumb {
  @Prop items: ResourceStr[] = [];
  @StorageLink('isDark') isDark: boolean = false;
  @StorageLink('brand') brand: string = 'default';
  @StorageProp('compact') compact: boolean = false;
  onSelect?: (index: number) => void;

  private isLast(index: number): boolean {
    return index === this.items.length - 1;
  }

  private separator(): Resource {
    return isRTL() ? $r('sys.symbol.chevron_left') : $r('sys.symbol.chevron_right');
  }

  build() {
    Row() {
      ForEach(this.items, (item: ResourceStr, index: number) => {
        Text(item)
          .fontSize(Token.font.bodySmall.sizeFor(this.compact))
          .fontColor(this.isLast(index) ? Token.color.onSurface() : Token.color.primary(this.brand))
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .constraintSize({ minHeight: Token.size.minTouch })
          .enabled(!this.isLast(index))
          .onClick(() => {
            if (!this.isLast(index) && this.onSelect) {
              this.onSelect(index);
            }
          })
        if (!this.isLast(index)) {
          SymbolGlyph(this.separator())
            .fontSize(Token.icon.xs)
            .fontColor([Token.color.onSurfaceVariant()])
            .width(Token.icon.xs)
            .height(Token.icon.xs)
            .margin({ start: LengthMetrics.vp(Token.space.xxs), end: LengthMetrics.vp(Token.space.xxs) })
        }
      }, (item: ResourceStr, index: number): string => index.toString())
    }
    .alignItems(VerticalAlign.Center)
  }
}

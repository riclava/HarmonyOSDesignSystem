import { Token, isRTL } from '../theme/Tokens';
import { LengthMetrics } from '@kit.ArkUI';

/**
 * 分页器：上一页 + 页码窗口（最多显示 maxButtons 个）+ 下一页。
 * current 为 1 基页码；pageCount 为总页数。
 */
@Component
export struct AppPagination {
  @Prop current: number = 1;
  @Prop pageCount: number = 1;
  @Prop maxButtons: number = 5;
  @StorageLink('isDark') isDark: boolean = false;
  @StorageLink('brand') brand: string = 'default';
  @StorageProp('compact') compact: boolean = false;
  onChange?: (page: number) => void;

  private cellSize(): number {
    return Token.size.buttonMedium(this.compact);
  }

  private pages(): number[] {
    const span: number = Math.min(this.maxButtons, this.pageCount);
    let start: number = this.current - Math.floor(span / 2);
    if (start < 1) {
      start = 1;
    }
    if (start + span - 1 > this.pageCount) {
      start = this.pageCount - span + 1;
    }
    const list: number[] = [];
    for (let i = 0; i < span; i++) {
      list.push(start + i);
    }
    return list;
  }

  private go(page: number): void {
    if (page < 1 || page > this.pageCount || page === this.current) {
      return;
    }
    this.current = page;
    if (this.onChange) {
      this.onChange(page);
    }
  }

  @Builder
  private navButton(glyph: Resource, enabled: boolean, accessibility: Resource, action: () => void) {
    SymbolGlyph(glyph)
      .fontSize(Token.icon.sm)
      .fontColor([enabled ? Token.color.onSurface() : Token.color.onSurfaceVariant()])
      .width(this.cellSize())
      .height(this.cellSize())
      .borderRadius(Token.radius.sm)
      .border({ width: 1, color: Token.color.outline() })
      .opacity(enabled ? 1 : 0.38)
      .enabled(enabled)
      .responseRegion({ x: 0, y: (this.cellSize() - Token.size.minTouch) / 2, width: '100%', height: Token.size.minTouch })
      .accessibilityText(accessibility)
      .onClick(action)
  }

  build() {
    Row({ space: Token.space.xxs }) {
      this.navButton(
        isRTL() ? $r('sys.symbol.chevron_right') : $r('sys.symbol.chevron_left'),
        this.current > 1,
        $r('app.string.ds_pagination_prev'),
        () => { this.go(this.current - 1); })
      ForEach(this.pages(), (page: number) => {
        Text(page.toString())
          .fontSize(Token.font.label.sizeFor(this.compact))
          .fontColor(page === this.current ? Token.color.onPrimary() : Token.color.onSurface())
          .textAlign(TextAlign.Center)
          .width(this.cellSize())
          .height(this.cellSize())
          .borderRadius(Token.radius.sm)
          .backgroundColor(page === this.current ? Token.color.primary() : Token.color.transparent())
          .border(page === this.current ? { width: 0 } : { width: 1, color: Token.color.outline() })
          .responseRegion({ x: 0, y: (this.cellSize() - Token.size.minTouch) / 2, width: '100%', height: Token.size.minTouch })
          .onClick(() => { this.go(page); })
      }, (page: number): string => page.toString())
      this.navButton(
        isRTL() ? $r('sys.symbol.chevron_left') : $r('sys.symbol.chevron_right'),
        this.current < this.pageCount,
        $r('app.string.ds_pagination_next'),
        () => { this.go(this.current + 1); })
    }
    .alignItems(VerticalAlign.Center)
  }
}

import { Token, isRTL } from '../theme/Tokens';

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

  private cellTouch(): number {
    return Math.max(this.cellSize(), Token.size.minTouch);
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

  private prevGlyph(): string {
    return isRTL() ? '›' : '‹';
  }

  private nextGlyph(): string {
    return isRTL() ? '‹' : '›';
  }

  @Builder
  private PreviousButton() {
    Row() {
      Text(this.prevGlyph())
        .fontSize(Token.icon.lg)
        .lineHeight(Token.icon.lg)
        .fontWeight(Token.font.titleMedium.weight)
        .fontColor(this.current > 1 ? Token.color.onSurface() : Token.color.onSurfaceVariant())
        .textAlign(TextAlign.Center)
        .width(Token.icon.lg)
        .height(Token.icon.lg)
    }
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .width(this.cellSize())
      .height(this.cellSize())
      .borderRadius(Token.radius.sm)
      .border({ width: 1, color: Token.color.outline() })
      .opacity(this.current > 1 ? 1 : 0.38)
      .enabled(this.current > 1)
      .responseRegion({
        x: (this.cellSize() - this.cellTouch()) / 2,
        y: (this.cellSize() - this.cellTouch()) / 2,
        width: this.cellTouch(),
        height: this.cellTouch()
      })
      .accessibilityText($r('app.string.ds_pagination_prev'))
      .onClick(() => {
        if (this.current > 1) {
          this.go(this.current - 1);
        }
      })
  }

  @Builder
  private NextButton() {
    Row() {
      Text(this.nextGlyph())
        .fontSize(Token.icon.lg)
        .lineHeight(Token.icon.lg)
        .fontWeight(Token.font.titleMedium.weight)
        .fontColor(this.current < this.pageCount ? Token.color.onSurface() : Token.color.onSurfaceVariant())
        .textAlign(TextAlign.Center)
        .width(Token.icon.lg)
        .height(Token.icon.lg)
    }
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .width(this.cellSize())
      .height(this.cellSize())
      .borderRadius(Token.radius.sm)
      .border({ width: 1, color: Token.color.outline() })
      .opacity(this.current < this.pageCount ? 1 : 0.38)
      .enabled(this.current < this.pageCount)
      .responseRegion({
        x: (this.cellSize() - this.cellTouch()) / 2,
        y: (this.cellSize() - this.cellTouch()) / 2,
        width: this.cellTouch(),
        height: this.cellTouch()
      })
      .accessibilityText($r('app.string.ds_pagination_next'))
      .onClick(() => {
        if (this.current < this.pageCount) {
          this.go(this.current + 1);
        }
      })
  }

  build() {
    Row({ space: Token.space.xxs }) {
      this.PreviousButton()
      ForEach(this.pages(), (page: number) => {
        Text(page.toString())
          .fontSize(Token.font.label.sizeFor(this.compact))
          .fontColor(page === this.current ? Token.color.onPrimary(this.brand) : Token.color.onSurface())
          .textAlign(TextAlign.Center)
          .width(this.cellSize())
          .height(this.cellSize())
          .borderRadius(Token.radius.sm)
          .backgroundColor(page === this.current ? Token.color.primary(this.brand) : Token.color.transparent())
          .border(page === this.current ? { width: 0 } : { width: 1, color: Token.color.outline() })
          .responseRegion({
            x: (this.cellSize() - this.cellTouch()) / 2,
            y: (this.cellSize() - this.cellTouch()) / 2,
            width: this.cellTouch(),
            height: this.cellTouch()
          })
          .onClick(() => { this.go(page); })
      }, (page: number): string => page.toString())
      this.NextButton()
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
  }
}

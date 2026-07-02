import { Token } from '../theme/Tokens';
import { LengthMetrics } from '@kit.ArkUI';

/**
 * 星级评分：max 颗星，rating 为已选数。ratingReadonly=true 仅展示不可点。
 */
@Component
export struct AppRating {
  @Prop rating: number = 0;
  @Prop max: number = 5;
  @Prop ratingReadonly: boolean = false;
  @StorageLink('isDark') isDark: boolean = false;
  @StorageLink('brand') brand: string = 'default';
  @StorageProp('compact') compact: boolean = false;
  onRate?: (value: number) => void;

  private stars(): number[] {
    const list: number[] = [];
    for (let i = 1; i <= this.max; i++) {
      list.push(i);
    }
    return list;
  }

  private starGlyph(index: number): Resource {
    return index <= this.rating ? $r('sys.symbol.star_fill') : $r('sys.symbol.star');
  }

  build() {
    Row() {
      ForEach(this.stars(), (index: number) => {
        SymbolGlyph(this.starGlyph(index))
          .fontSize(Token.icon.md)
          .fontColor([index <= this.rating ? Token.color.warning() : Token.color.onSurfaceVariant()])
          .width(Token.icon.lg)
          .height(Token.icon.lg)
          .margin({ end: LengthMetrics.vp(Token.space.xxs) })
          .responseRegion({ x: 0, y: (Token.icon.lg - Token.size.minTouch) / 2, width: '100%', height: Token.size.minTouch })
          .enabled(!this.ratingReadonly)
          .accessibilityText($r('app.string.ds_rating_star'))
          .onClick(() => {
            if (!this.ratingReadonly) {
              this.rating = index;
              if (this.onRate) {
                this.onRate(index);
              }
            }
          })
      }, (index: number): string => index.toString())
    }
    .alignItems(VerticalAlign.Center)
  }
}

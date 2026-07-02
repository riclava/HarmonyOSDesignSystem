import { Token } from '../theme/Tokens';
import { LengthMetrics } from '@kit.ArkUI';

/** 搜索框：胶囊外形（RadiusFull），左侧搜索图标，有内容时右侧可清除。 */
@Component
export struct AppSearch {
  @Prop text: string = '';
  @Prop placeholder: ResourceStr = $r('app.string.ds_search_placeholder');
  @StorageLink('isDark') isDark: boolean = false;
  @StorageLink('brand') brand: string = 'default';
  @StorageProp('compact') compact: boolean = false;
  onTextChange?: (value: string) => void;
  onSubmit?: (value: string) => void;

  private searchTouch(): number {
    return Math.max(Token.size.field(this.compact), Token.size.minTouch);
  }

  build() {
    Row() {
      SymbolGlyph($r('sys.symbol.magnifyingglass'))
        .fontSize(Token.icon.xs)
        .fontColor([Token.color.onSurfaceVariant()])
        .renderingStrategy(SymbolRenderingStrategy.MULTIPLE_OPACITY)
        .width(Token.icon.sm)
        .height(Token.icon.sm)
        .margin({ end: LengthMetrics.vp(Token.space.xs) })
      TextInput({ placeholder: this.placeholder, text: this.text })
        .fontSize(Token.font.body.sizeFor(this.compact))
        .fontColor(Token.color.onSurface())
        .placeholderColor(Token.color.onSurfaceVariant())
        .backgroundColor(Token.color.transparent())
        .borderRadius(Token.radius.none)
        .padding(Token.space.none)
        .layoutWeight(1)
        .onChange((v: string) => {
          this.text = v;
          if (this.onTextChange) {
            this.onTextChange(v);
          }
        })
        .onSubmit(() => {
          if (this.onSubmit) {
            this.onSubmit(this.text);
          }
        })
      if (this.text.length > 0) {
        Row() {
          SymbolGlyph($r('sys.symbol.xmark'))
            .fontSize(Token.icon.xs)
            .fontColor([Token.color.onSurfaceVariant()])
            .renderingStrategy(SymbolRenderingStrategy.MULTIPLE_OPACITY)
            .width(Token.icon.xs)
            .height(Token.icon.xs)
        }
          .width(Token.size.minTouch)
          .height(Token.size.minTouch)
          .justifyContent(FlexAlign.Center)
          .accessibilityText($r('app.string.ds_search_clear'))
          .onClick(() => {
            this.text = '';
            if (this.onTextChange) {
              this.onTextChange('');
            }
          })
      }
    }
    .width('100%')
    .height(Token.size.field(this.compact))
    .padding({ start: LengthMetrics.vp(Token.space.md), end: LengthMetrics.vp(Token.space.xs) })
    .backgroundColor(Token.color.surface())
    .borderRadius(Token.radius.full)
    .border({ width: 1, color: Token.color.outline() })
    .alignItems(VerticalAlign.Center)
    .responseRegion({ x: 0, y: (Token.size.field(this.compact) - this.searchTouch()) / 2, width: '100%', height: this.searchTouch() })
  }
}

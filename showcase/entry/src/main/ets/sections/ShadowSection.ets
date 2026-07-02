import { Token } from '@riclava/designsystem';
import { SectionLabel } from './Widgets';

interface ShadowItem { name: string; radius: number; color: string; offsetX: number; offsetY: number; }

@Component
export struct ShadowSection {
  @StorageLink('isDark') isDark: boolean = false;
  @StorageProp('compact') compact: boolean = false;

  private items(): ShadowItem[] {
    const e = Token.shadow;
    return [
      { name: 'Level1', radius: e.level1.radius, color: e.level1.color, offsetX: e.level1.offsetX, offsetY: e.level1.offsetY },
      { name: 'Level2', radius: e.level2.radius, color: e.level2.color, offsetX: e.level2.offsetX, offsetY: e.level2.offsetY },
      { name: 'Level3', radius: e.level3.radius, color: e.level3.color, offsetX: e.level3.offsetX, offsetY: e.level3.offsetY },
      { name: 'Level4', radius: e.level4.radius, color: e.level4.color, offsetX: e.level4.offsetX, offsetY: e.level4.offsetY },
    ];
  }

  build() {
    Column() {
      SectionLabel({ text: $r('app.string.sec_shadow') })
      GridRow({
        columns: { sm: 4, md: 8, lg: 12 },
        gutter: { x: Token.space.sm, y: Token.space.sm },
        breakpoints: { value: ['600vp', '840vp'], reference: BreakpointsReference.WindowSize }
      }) {
        ForEach(this.items(), (item: ShadowItem) => {
          GridCol({ span: { sm: 2, md: 2, lg: 3 } }) {
            Column() {
              Text(item.name)
                .fontSize(Token.font.caption.sizeFor(this.compact))
                .lineHeight(Token.font.caption.lineHeightFor(this.compact))
                .fontColor(Token.color.onSurface())
            }
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
            .width('100%')
            .height(Token.size.rowMin(this.compact) + Token.space.md)
            .backgroundColor(Token.color.surface())
            .borderRadius(Token.radius.md)
            .shadow({ radius: item.radius, color: item.color, offsetX: item.offsetX, offsetY: item.offsetY })
          }
        })
      }
      .width('100%')
    }
    .width('100%')
    .margin({ bottom: Token.space.lg })
  }
}

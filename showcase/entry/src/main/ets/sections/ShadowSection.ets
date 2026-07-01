import { Token } from '@riclava/designsystem';
import { SectionLabel } from './Widgets';

interface ShadowItem { name: string; radius: number; color: string; offsetY: number; }

@Component
export struct ShadowSection {
  @StorageLink('isDark') isDark: boolean = false;

  private items(): ShadowItem[] {
    const e = Token.shadow;
    return [
      { name: 'Level1', radius: e.level1.radius, color: e.level1.color, offsetY: e.level1.offsetY },
      { name: 'Level2', radius: e.level2.radius, color: e.level2.color, offsetY: e.level2.offsetY },
      { name: 'Level3', radius: e.level3.radius, color: e.level3.color, offsetY: e.level3.offsetY },
      { name: 'Level4', radius: e.level4.radius, color: e.level4.color, offsetY: e.level4.offsetY },
    ];
  }

  build() {
    Column() {
      SectionLabel({ text: 'Shadow · 高度 Elevation' })
      Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween }) {
        ForEach(this.items(), (item: ShadowItem) => {
          Column() {
            Text(item.name)
              .fontSize(Token.font.caption.size)
              .fontColor(Token.color.onSurface())
          }
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .width('47%')
          .height(72)
          .margin({ bottom: Token.space.md })
          .backgroundColor(Token.color.surface())
          .borderRadius(Token.radius.md)
          .shadow({ radius: item.radius, color: item.color, offsetX: 0, offsetY: item.offsetY })
        })
      }
      .width('100%')
    }
    .width('100%')
    .margin({ bottom: Token.space.lg })
  }
}

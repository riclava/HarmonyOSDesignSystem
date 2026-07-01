import { Token } from '@riclava/designsystem';
import { SectionLabel } from './Widgets';

interface IconItem { name: string; size: number; }

@Component
export struct IconSection {
  @StorageLink('isDark') isDark: boolean = false;

  private items(): IconItem[] {
    const i = Token.icon;
    return [
      { name: 'xs', size: i.xs }, { name: 'sm', size: i.sm },
      { name: 'md', size: i.md }, { name: 'lg', size: i.lg },
      { name: 'xl', size: i.xl }, { name: 'xxl', size: i.xxl },
    ];
  }

  build() {
    Column() {
      SectionLabel({ text: 'Icon · 图标尺寸' })
      Flex({ wrap: FlexWrap.Wrap, alignItems: ItemAlign.End }) {
        ForEach(this.items(), (item: IconItem) => {
          Column() {
            // 用一个圆形代替图标，演示尺寸网格与命中区概念
            Circle({ width: item.size, height: item.size })
              .fill(Token.color.primary())
            Text(`${item.name} · ${item.size}`)
              .fontSize(Token.font.caption.size)
              .fontColor(Token.color.onSurfaceVariant())
              .margin({ top: Token.space.xxs })
          }
          .justifyContent(FlexAlign.End)
          .alignItems(HorizontalAlign.Center)
          .width(64)
          .margin({ right: Token.space.sm, bottom: Token.space.sm })
        })
      }
      .width('100%')

      Text('默认 24vp；命中区始终 ≥ 44×44vp（见 Accessibility）。')
        .fontSize(Token.font.caption.size)
        .fontColor(Token.color.onSurfaceVariant())
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .margin({ bottom: Token.space.lg })
  }
}

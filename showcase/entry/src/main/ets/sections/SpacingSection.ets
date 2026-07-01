import { Token } from '../designsystem/Tokens';
import { SectionLabel } from './Widgets';

interface SpaceItem { name: string; value: number; }

@Component
export struct SpacingSection {
  @StorageLink('isDark') isDark: boolean = false;

  private items(): SpaceItem[] {
    const s = Token.space;
    return [
      { name: 'xxs', value: s.xxs }, { name: 'xs', value: s.xs },
      { name: 'sm', value: s.sm }, { name: 'md', value: s.md },
      { name: 'lg', value: s.lg }, { name: 'xl', value: s.xl },
      { name: 'xxl', value: s.xxl }, { name: '3xl', value: s.xxxl },
    ];
  }

  build() {
    Column() {
      SectionLabel({ text: 'Spacing · 间距（8pt Grid）' })
      ForEach(this.items(), (item: SpaceItem) => {
        Row() {
          Text(`Space.${item.name}`)
            .fontSize(Token.font.bodySmall.size)
            .fontColor(Token.color.onSurface())
            .width(110)
          Row()
            .width(item.value)
            .height(16)
            .backgroundColor(Token.color.primary())
            .borderRadius(Token.radius.xs)
          Text(`${item.value}vp`)
            .fontSize(Token.font.caption.size)
            .fontColor(Token.color.onSurfaceVariant())
            .margin({ left: Token.space.xs })
        }
        .width('100%')
        .padding({ top: Token.space.xxs, bottom: Token.space.xxs })
      })
    }
    .width('100%')
    .margin({ bottom: Token.space.lg })
  }
}

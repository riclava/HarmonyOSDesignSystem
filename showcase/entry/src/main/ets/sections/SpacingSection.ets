import { Token } from '@riclava/designsystem';
import { LengthMetrics } from '@kit.ArkUI';
import { SectionLabel } from './Widgets';

interface SpaceItem { name: string; value: number; }

@Component
export struct SpacingSection {
  @StorageLink('isDark') isDark: boolean = false;
  @StorageProp('compact') compact: boolean = false;

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
      SectionLabel({ text: $r('app.string.sec_spacing') })
      ForEach(this.items(), (item: SpaceItem) => {
        Row() {
          Text(`Space.${item.name}`)
            .fontSize(Token.font.bodySmall.sizeFor(this.compact))
            .lineHeight(Token.font.bodySmall.lineHeightFor(this.compact))
            .fontColor(Token.color.onSurface())
            .width(Token.size.avatarXl + Token.space.xxxl)
          Row()
            .width(item.value)
            .height(Token.size.skeletonLine)
            .backgroundColor(Token.color.primary())
            .borderRadius(Token.radius.xs)
          Text(`${item.value}vp`)
            .fontSize(Token.font.caption.sizeFor(this.compact))
            .lineHeight(Token.font.caption.lineHeightFor(this.compact))
            .fontColor(Token.color.onSurfaceVariant())
            .margin({ start: LengthMetrics.vp(Token.space.xs) })
        }
        .width('100%')
        .padding({ top: Token.space.xxs, bottom: Token.space.xxs })
      })
    }
    .width('100%')
    .margin({ bottom: Token.space.lg })
  }
}

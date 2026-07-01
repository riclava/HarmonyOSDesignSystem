import { Token } from '../designsystem/Tokens';
import { SectionLabel } from './Widgets';

interface TypeItem { name: string; size: number; lineHeight: number; weight: number; }

@Component
export struct TypographySection {
  @StorageLink('isDark') isDark: boolean = false;

  private items(): TypeItem[] {
    const f = Token.font;
    return [
      { name: 'DisplayLarge', size: f.displayLarge.size, lineHeight: f.displayLarge.lineHeight, weight: f.displayLarge.weight },
      { name: 'HeadlineLarge', size: f.headlineLarge.size, lineHeight: f.headlineLarge.lineHeight, weight: f.headlineLarge.weight },
      { name: 'HeadlineMedium', size: f.headlineMedium.size, lineHeight: f.headlineMedium.lineHeight, weight: f.headlineMedium.weight },
      { name: 'TitleLarge', size: f.titleLarge.size, lineHeight: f.titleLarge.lineHeight, weight: f.titleLarge.weight },
      { name: 'Body', size: f.body.size, lineHeight: f.body.lineHeight, weight: f.body.weight },
      { name: 'Label', size: f.label.size, lineHeight: f.label.lineHeight, weight: f.label.weight },
      { name: 'Caption', size: f.caption.size, lineHeight: f.caption.lineHeight, weight: f.caption.weight },
    ];
  }

  build() {
    Column() {
      SectionLabel({ text: 'Typography · 字体' })
      ForEach(this.items(), (t: TypeItem) => {
        Column() {
          Text(t.name)
            .fontSize(t.size)
            .lineHeight(t.lineHeight)
            .fontWeight(t.weight)
            .fontColor(Token.color.onSurface())
          Text(`${t.size}fp · line ${t.lineHeight} · weight ${t.weight}`)
            .fontSize(Token.font.caption.size)
            .fontColor(Token.color.onSurfaceVariant())
        }
        .alignItems(HorizontalAlign.Start)
        .width('100%')
        .padding({ top: Token.space.xs, bottom: Token.space.xs })
      })
    }
    .width('100%')
    .margin({ bottom: Token.space.lg })
  }
}

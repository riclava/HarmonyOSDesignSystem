import { Token } from '@riclava/designsystem';
import { SectionLabel } from './Widgets';

interface TypeItem { name: string; size: number; lineHeight: number; weight: number; }

@Component
export struct TypographySection {
  @StorageLink('isDark') isDark: boolean = false;
  @StorageProp('compact') compact: boolean = false;

  private items(): TypeItem[] {
    const f = Token.font;
    return [
      { name: 'DisplayLarge', size: f.displayLarge.sizeFor(this.compact), lineHeight: f.displayLarge.lineHeightFor(this.compact), weight: f.displayLarge.weight },
      { name: 'HeadlineLarge', size: f.headlineLarge.sizeFor(this.compact), lineHeight: f.headlineLarge.lineHeightFor(this.compact), weight: f.headlineLarge.weight },
      { name: 'HeadlineMedium', size: f.headlineMedium.sizeFor(this.compact), lineHeight: f.headlineMedium.lineHeightFor(this.compact), weight: f.headlineMedium.weight },
      { name: 'TitleLarge', size: f.titleLarge.sizeFor(this.compact), lineHeight: f.titleLarge.lineHeightFor(this.compact), weight: f.titleLarge.weight },
      { name: 'Body', size: f.body.sizeFor(this.compact), lineHeight: f.body.lineHeightFor(this.compact), weight: f.body.weight },
      { name: 'Label', size: f.label.sizeFor(this.compact), lineHeight: f.label.lineHeightFor(this.compact), weight: f.label.weight },
      { name: 'Caption', size: f.caption.sizeFor(this.compact), lineHeight: f.caption.lineHeightFor(this.compact), weight: f.caption.weight },
    ];
  }

  build() {
    Column() {
      SectionLabel({ text: $r('app.string.sec_typography') })
      ForEach(this.items(), (t: TypeItem) => {
        Column() {
          Text(t.name)
            .fontSize(t.size)
            .lineHeight(t.lineHeight)
            .fontWeight(t.weight)
            .fontColor(Token.color.onSurface())
          Text(`${t.size}fp · line ${t.lineHeight} · weight ${t.weight}`)
            .fontSize(Token.font.caption.sizeFor(this.compact))
            .lineHeight(Token.font.caption.lineHeightFor(this.compact))
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

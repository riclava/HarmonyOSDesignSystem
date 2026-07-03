import { Density, Token } from '@riclava/designsystem';
import { SectionLabel } from './Widgets';

interface TypeItem { name: string; size: number; lineHeight: number; weight: number; }

@Component
export struct TypographySection {
  @StorageLink('isDark') isDark: boolean = false;
  @StorageLink('brand') brand: string = 'default';
  @StorageProp('density') density: Density = Density.Comfortable;

  private items(): TypeItem[] {
    const f = Token.font;
    return [
      { name: 'DisplayLarge', size: f.displayLarge.sizeFor(this.density), lineHeight: f.displayLarge.lineHeightFor(this.density), weight: f.displayLarge.weight },
      { name: 'HeadlineLarge', size: f.headlineLarge.sizeFor(this.density), lineHeight: f.headlineLarge.lineHeightFor(this.density), weight: f.headlineLarge.weight },
      { name: 'HeadlineMedium', size: f.headlineMedium.sizeFor(this.density), lineHeight: f.headlineMedium.lineHeightFor(this.density), weight: f.headlineMedium.weight },
      { name: 'TitleLarge', size: f.titleLarge.sizeFor(this.density), lineHeight: f.titleLarge.lineHeightFor(this.density), weight: f.titleLarge.weight },
      { name: 'Body', size: f.body.sizeFor(this.density), lineHeight: f.body.lineHeightFor(this.density), weight: f.body.weight },
      { name: 'Label', size: f.label.sizeFor(this.density), lineHeight: f.label.lineHeightFor(this.density), weight: f.label.weight },
      { name: 'Caption', size: f.caption.sizeFor(this.density), lineHeight: f.caption.lineHeightFor(this.density), weight: f.caption.weight },
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
            .fontSize(Token.font.caption.sizeFor(this.density))
            .lineHeight(Token.font.caption.lineHeightFor(this.density))
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

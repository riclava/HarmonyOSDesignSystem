import { Token } from '@riclava/designsystem';
import { SectionLabel } from './Widgets';

interface Swatch { name: string; color: ResourceColor; onColor: ResourceColor; }

@Component
export struct ColorSection {
  @StorageLink('isDark') isDark: boolean = false;
  @StorageLink('brand') brand: string = 'default';
  @StorageProp('compact') compact: boolean = false;

  private swatches(): Swatch[] {
    const onLight = Token.color.onPrimary();
    const onDark = Token.color.onSurface();
    return [
      { name: 'Primary', color: Token.color.primary(), onColor: onLight },
      { name: 'PrimaryContainer', color: Token.color.primaryContainer(), onColor: Token.color.onSurface() },
      { name: 'Secondary', color: Token.color.secondary(), onColor: onLight },
      { name: 'Success', color: Token.color.success(), onColor: onLight },
      { name: 'Warning', color: Token.color.warning(), onColor: onLight },
      { name: 'Danger', color: Token.color.danger(), onColor: onLight },
      { name: 'Info', color: Token.color.info(), onColor: onLight },
      { name: 'Surface', color: Token.color.surface(), onColor: onDark },
      { name: 'Background', color: Token.color.background(), onColor: onDark },
      { name: 'Outline', color: Token.color.outline(), onColor: onDark },
      { name: 'Divider', color: Token.color.divider(), onColor: onDark },
      { name: 'OnSurfaceVariant', color: Token.color.onSurfaceVariant(), onColor: onLight },
    ];
  }

  build() {
    Column() {
      SectionLabel({ text: $r('app.string.sec_color') })
      GridRow({
        columns: { sm: 4, md: 8, lg: 12 },
        gutter: { x: Token.space.xs, y: Token.space.xs },
        breakpoints: { value: ['600vp', '840vp'], reference: BreakpointsReference.WindowSize }
      }) {
        ForEach(this.swatches(), (s: Swatch) => {
          GridCol({ span: { sm: 2, md: 2, lg: 3 } }) {
            Column() {
              Text(s.name)
                .fontSize(Token.font.caption.sizeFor(this.compact))
                .lineHeight(Token.font.caption.lineHeightFor(this.compact))
                .fontColor(s.onColor)
                .maxLines(2)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
            }
            .justifyContent(FlexAlign.End)
            .alignItems(HorizontalAlign.Start)
            .width('100%')
            .height(Token.size.rowMin(this.compact) + Token.space.md)
            .padding(Token.space.xs)
            .backgroundColor(s.color)
            .borderRadius(Token.radius.sm)
            .border({ width: 1, color: Token.color.outline() })
          }
        })
      }
      .width('100%')
    }
    .width('100%')
    .margin({ bottom: Token.space.lg })
  }
}

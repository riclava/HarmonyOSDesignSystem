import { Token } from '@riclava/designsystem';
import { SectionLabel } from './Widgets';

interface Swatch { name: string; color: ResourceColor; onColor: ResourceColor; }

@Component
export struct ColorSection {
  @StorageLink('isDark') isDark: boolean = false;

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
      SectionLabel({ text: 'Color · 颜色 Token' })
      Grid() {
        ForEach(this.swatches(), (s: Swatch) => {
          GridItem() {
            Column() {
              Text(s.name)
                .fontSize(Token.font.caption.size)
                .fontColor(s.onColor)
            }
            .justifyContent(FlexAlign.End)
            .alignItems(HorizontalAlign.Start)
            .width('100%')
            .height(Token.size.rowMin(false) + Token.space.md)
            .padding(Token.space.xs)
            .backgroundColor(s.color)
            .borderRadius(Token.radius.sm)
            .border({ width: 1, color: Token.color.outline() })
          }
        })
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(Token.space.xs)
      .rowsGap(Token.space.xs)
      .width('100%')
    }
    .width('100%')
    .margin({ bottom: Token.space.lg })
  }
}

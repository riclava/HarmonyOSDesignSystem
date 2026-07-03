import { Density, Token } from '@riclava/designsystem';
import { LengthMetrics } from '@kit.ArkUI';
import { SectionLabel } from './Widgets';

interface RadiusItem { name: string; value: number; }

@Component
export struct RadiusSection {
  @StorageLink('isDark') isDark: boolean = false;
  @StorageLink('brand') brand: string = 'default';
  @StorageProp('density') density: Density = Density.Comfortable;

  private items(): RadiusItem[] {
    const r = Token.radius;
    return [
      { name: 'xs', value: r.xs }, { name: 'sm', value: r.sm },
      { name: 'md', value: r.md }, { name: 'lg', value: r.lg },
      { name: 'xl', value: r.xl }, { name: 'full', value: r.full },
    ];
  }

  build() {
    Column() {
      SectionLabel({ text: $r('app.string.sec_radius') })
      Flex({ wrap: FlexWrap.Wrap }) {
        ForEach(this.items(), (item: RadiusItem) => {
          Column() {
            Column()
              .width(Token.size.progressRing)
              .height(Token.size.progressRing)
              .backgroundColor(Token.color.primaryContainer(this.brand))
              .borderRadius(item.value)
              .border({ width: 1, color: Token.color.primary(this.brand) })
            Text(item.name)
              .fontSize(Token.font.caption.sizeFor(this.density))
              .lineHeight(Token.font.caption.lineHeightFor(this.density))
              .fontColor(Token.color.onSurfaceVariant())
              .margin({ top: Token.space.xxs })
          }
          .margin({ end: LengthMetrics.vp(Token.space.md), bottom: Token.space.sm })
        })
      }
      .width('100%')
    }
    .width('100%')
    .margin({ bottom: Token.space.lg })
  }
}

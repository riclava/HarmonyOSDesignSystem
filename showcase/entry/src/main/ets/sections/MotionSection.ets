import { Token } from '@riclava/designsystem';
import { LengthMetrics } from '@kit.ArkUI';
import { SectionLabel } from './Widgets';

@Component
export struct MotionSection {
  @StorageLink('isDark') isDark: boolean = false;
  @StorageLink('brand') brand: string = 'default';
  @StorageProp('compact') compact: boolean = false;
  @State moved: boolean = false;

  build() {
    Column() {
      SectionLabel({ text: $r('app.string.sec_motion') })
      Column() {
        Stack({ alignContent: this.moved ? Alignment.End : Alignment.Start }) {
          Column()
            .width(Token.size.avatarMd)
            .height(Token.size.avatarMd)
            .backgroundColor(Token.color.primary(this.brand))
            .borderRadius(Token.radius.sm)
        }
        .width('100%')
        .height(Token.size.rowMin(this.compact))
        .padding({ start: LengthMetrics.vp(Token.space.xs), end: LengthMetrics.vp(Token.space.xs) })
        .backgroundColor(Token.color.background())
        .borderRadius(Token.radius.sm)
        .animation({
          duration: Token.motion.normal,
          curve: this.moved ? Token.motion.easeOut : Token.motion.easeIn
        })

        Text($r('app.string.motion_scale'))
          .fontSize(Token.font.caption.sizeFor(this.compact))
          .lineHeight(Token.font.caption.lineHeightFor(this.compact))
          .fontColor(Token.color.onSurfaceVariant())
          .margin({ top: Token.space.xs })
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
      .padding(this.compact ? Token.space.sm : Token.space.md)
      .backgroundColor(Token.color.surface())
      .borderRadius(Token.radius.md)
      .onClick(() => { this.moved = !this.moved; })
    }
    .width('100%')
    .margin({ bottom: Token.space.lg })
  }
}

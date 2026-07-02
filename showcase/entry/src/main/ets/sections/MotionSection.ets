import { Token } from '@riclava/designsystem';
import { SectionLabel } from './Widgets';

@Component
export struct MotionSection {
  @StorageLink('isDark') isDark: boolean = false;
  @State moved: boolean = false;

  build() {
    Column() {
      SectionLabel({ text: $r('app.string.sec_motion') })
      Column() {
        Row() {
          Column()
            .width(Token.size.avatarMd)
            .height(Token.size.avatarMd)
            .backgroundColor(Token.color.primary())
            .borderRadius(Token.radius.sm)
            .translate({ x: this.moved ? Token.size.popoverMaxWidth - Token.size.avatarMd : Token.space.none })
            .animation({
              duration: Token.motion.normal,
              curve: this.moved ? Token.motion.easeOut : Token.motion.easeIn
            })
        }
        .width('100%')
        .height(Token.size.rowMin(false))

        Text($r('app.string.motion_scale'))
          .fontSize(Token.font.caption.size)
          .fontColor(Token.color.onSurfaceVariant())
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
      .padding(Token.space.md)
      .backgroundColor(Token.color.surface())
      .borderRadius(Token.radius.md)
      .onClick(() => { this.moved = !this.moved; })
    }
    .width('100%')
    .margin({ bottom: Token.space.lg })
  }
}

import { Token } from '../theme/Tokens';

/**
 * 气泡浮层内容容器：Surface 底 + RadiusMD + Level3 阴影，最大宽 240。
 * 用于 .bindPopup 的自定义 builder（CustomPopupOptions.builder）。
 */
@Component
export struct AppPopover {
  @Prop title: string = '';
  @Prop text: string = '';
  @StorageLink('isDark') isDark: boolean = false;
  @StorageProp('compact') compact: boolean = false;

  build() {
    Column() {
      if (this.title.length > 0) {
        Text(this.title)
          .fontSize(Token.font.label.sizeFor(this.compact))
          .fontWeight(Token.font.label.weight)
          .fontColor(Token.color.onSurface())
          .margin({ bottom: Token.space.xxs })
      }
      if (this.text.length > 0) {
        Text(this.text)
          .fontSize(Token.font.bodySmall.sizeFor(this.compact))
          .fontColor(Token.color.onSurfaceVariant())
      }
    }
    .alignItems(HorizontalAlign.Start)
    .padding(Token.space.sm)
    .backgroundColor(Token.color.surface())
    .borderRadius(Token.radius.md)
    .constraintSize({ maxWidth: 240 })
    .shadow({
      radius: Token.shadow.level3.radius,
      color: Token.shadow.level3.color,
      offsetX: Token.shadow.level3.offsetX,
      offsetY: Token.shadow.level3.offsetY
    })
  }
}

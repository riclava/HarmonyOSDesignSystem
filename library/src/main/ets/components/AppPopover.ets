import { Density, Token } from '../theme/Tokens';

/**
 * 气泡浮层内容容器：Surface 底 + RadiusMD + Level3 阴影，最大宽 240。
 * 用于 .bindPopup 的自定义 builder（CustomPopupOptions.builder）。
 */
@Component
export struct AppPopover {
  @Prop title: ResourceStr = '';
  @Prop text: ResourceStr = '';
  @StorageLink('isDark') isDark: boolean = false;
  @StorageLink('brand') brand: string = 'default';
  @StorageProp('density') density: Density = Density.Comfortable;

  private hasText(value: ResourceStr): boolean {
    return typeof value !== 'string' || value.length > 0;
  }

  build() {
    Column() {
      if (this.hasText(this.title)) {
        Text(this.title)
          .fontSize(Token.font.label.sizeFor(this.density))
          .fontWeight(Token.font.label.weight)
          .fontColor(Token.color.onSurface())
          .margin({ bottom: Token.space.xxs })
      }
      if (this.hasText(this.text)) {
        Text(this.text)
          .fontSize(Token.font.bodySmall.sizeFor(this.density))
          .fontColor(Token.color.onSurfaceVariant())
      }
    }
    .alignItems(HorizontalAlign.Start)
    .padding(Token.space.sm)
    .backgroundColor(Token.color.surface())
    .borderRadius(Token.radius.md)
    .constraintSize({ maxWidth: Token.size.popoverMaxWidth })
    .shadow({
      radius: Token.shadow.level3.radius,
      color: Token.shadow.level3.color,
      offsetX: Token.shadow.level3.offsetX,
      offsetY: Token.shadow.level3.offsetY
    })
  }
}

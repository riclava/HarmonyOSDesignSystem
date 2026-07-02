import { Token } from '../theme/Tokens';
import { LengthMetrics } from '@kit.ArkUI';

/**
 * 分割线：水平（可带居中文字）或垂直。
 * - 无 text：一条 divider 色细线。
 * - 有 text：线—文字—线。
 * - vertical=true：垂直细线（需由父容器给定高度）。
 */
@Component
export struct AppDivider {
  @Prop text: ResourceStr = '';
  @Prop vertical: boolean = false;
  @StorageLink('isDark') isDark: boolean = false;
  @StorageProp('compact') compact: boolean = false;

  private hasText(value: ResourceStr): boolean {
    return typeof value !== 'string' || value.length > 0;
  }

  build() {
    if (this.vertical) {
      Divider()
        .vertical(true)
        .color(Token.color.divider())
        .strokeWidth(1)
        .height('100%')
    } else if (this.hasText(this.text)) {
      Row() {
        Divider().color(Token.color.divider()).layoutWeight(1)
        Text(this.text)
          .fontSize(Token.font.caption.sizeFor(this.compact))
          .fontColor(Token.color.onSurfaceVariant())
          .margin({ start: LengthMetrics.vp(Token.space.sm), end: LengthMetrics.vp(Token.space.sm) })
        Divider().color(Token.color.divider()).layoutWeight(1)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    } else {
      Divider().color(Token.color.divider())
    }
  }
}

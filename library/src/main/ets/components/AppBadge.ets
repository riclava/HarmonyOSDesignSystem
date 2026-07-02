import { Token } from '../theme/Tokens';
import { LengthMetrics } from '@kit.ArkUI';

/** 徽标：dot=true 显示 8vp 圆点；否则显示 count 数字（>99 显示 99+）。 */
@Component
export struct AppBadge {
  @Prop count: number = 0;
  @Prop dot: boolean = false;
  @StorageLink('isDark') isDark: boolean = false;
  @StorageLink('brand') brand: string = 'default';
  @StorageProp('compact') compact: boolean = false;

  private label(): string {
    return this.count > 99 ? '99+' : `${this.count}`;
  }

  build() {
    if (this.dot) {
      Circle({ width: Token.size.badgeDot, height: Token.size.badgeDot }).fill(Token.color.danger())
    } else {
      Text(this.label())
        .fontSize(Token.font.caption.sizeFor(this.compact))
        .fontColor(Token.color.onPrimary())
        .height(Token.size.badgeMin)
        .constraintSize({ minWidth: Token.size.badgeMin })
        .padding({ start: LengthMetrics.vp(Token.space.xxs), end: LengthMetrics.vp(Token.space.xxs) })
        .backgroundColor(Token.color.danger())
        .borderRadius(Token.radius.full)
        .textAlign(TextAlign.Center)
    }
  }
}

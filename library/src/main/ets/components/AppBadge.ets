import { Token } from '../theme/Tokens';

/** 徽标：dot=true 显示 8vp 圆点；否则显示 count 数字（>99 显示 99+）。 */
@Component
export struct AppBadge {
  @Prop count: number = 0;
  @Prop dot: boolean = false;
  @StorageLink('isDark') isDark: boolean = false;

  private label(): string {
    return this.count > 99 ? '99+' : `${this.count}`;
  }

  build() {
    if (this.dot) {
      Circle({ width: 8, height: 8 }).fill(Token.color.danger())
    } else {
      Text(this.label())
        .fontSize(Token.font.caption.size)
        .fontColor(Token.color.onPrimary())
        .height(16)
        .constraintSize({ minWidth: 16 })
        .padding({ left: Token.space.xxs, right: Token.space.xxs })
        .backgroundColor(Token.color.danger())
        .borderRadius(Token.radius.full)
        .textAlign(TextAlign.Center)
    }
  }
}

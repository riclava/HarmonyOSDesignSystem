import { Token } from '../theme/Tokens';
import { LengthMetrics } from '@kit.ArkUI';

/** 菜单项数据模型。destructive=true 时使用 Danger 色。 */
export class AppMenuItem {
  label: ResourceStr;
  destructive: boolean;
  onSelect?: () => void;
  constructor(label: ResourceStr, onSelect?: () => void, destructive: boolean = false) {
    this.label = label;
    this.onSelect = onSelect;
    this.destructive = destructive;
  }
}

/**
 * 菜单面板：RadiusMD + Level3 阴影，项高 40。
 * 用于 .bindMenu / .bindPopup 的自定义 builder，或直接内嵌浮层。
 */
@Component
export struct AppMenu {
  @Prop items: AppMenuItem[] = [];
  @StorageLink('isDark') isDark: boolean = false;
  @StorageProp('compact') compact: boolean = false;

  private menuTouch(): number {
    return Math.max(Token.size.menuItem(this.compact), Token.size.minTouch);
  }

  build() {
    Column() {
      ForEach(this.items, (item: AppMenuItem, index: number) => {
        Text(item.label)
          .fontSize(Token.font.body.sizeFor(this.compact))
          .fontColor(item.destructive ? Token.color.danger() : Token.color.onSurface())
          .width('100%')
          .height(Token.size.menuItem(this.compact))
          .padding({ start: LengthMetrics.vp(Token.space.md), end: LengthMetrics.vp(Token.space.md) })
          .textAlign(TextAlign.Start)
          .responseRegion({ x: 0, y: (Token.size.menuItem(this.compact) - this.menuTouch()) / 2, width: '100%', height: this.menuTouch() })
          .onClick(() => {
            if (item.onSelect) {
              item.onSelect();
            }
          })
        if (index < this.items.length - 1) {
          Divider().color(Token.color.divider())
        }
      })
    }
    .padding(Token.space.xxs)
    .backgroundColor(Token.color.surface())
    .borderRadius(Token.radius.md)
    .constraintSize({ minWidth: Token.size.menuMinWidth })
    .shadow({
      radius: Token.shadow.level3.radius,
      color: Token.shadow.level3.color,
      offsetX: Token.shadow.level3.offsetX,
      offsetY: Token.shadow.level3.offsetY
    })
  }
}

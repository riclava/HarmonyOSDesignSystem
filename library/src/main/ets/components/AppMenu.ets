import { Token } from '../theme/Tokens';

/** 菜单项数据模型。destructive=true 时使用 Danger 色。 */
export class AppMenuItem {
  label: string;
  destructive: boolean;
  onSelect?: () => void;
  constructor(label: string, onSelect?: () => void, destructive: boolean = false) {
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

  build() {
    Column() {
      ForEach(this.items, (item: AppMenuItem, index: number) => {
        Text(item.label)
          .fontSize(Token.font.body.size)
          .fontColor(item.destructive ? Token.color.danger() : Token.color.onSurface())
          .width('100%')
          .height(40)
          .padding({ left: Token.space.md, right: Token.space.md })
          .textAlign(TextAlign.Start)
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
    .constraintSize({ minWidth: 160 })
    .shadow({
      radius: Token.shadow.level3.radius,
      color: Token.shadow.level3.color,
      offsetX: Token.shadow.level3.offsetX,
      offsetY: Token.shadow.level3.offsetY
    })
  }
}

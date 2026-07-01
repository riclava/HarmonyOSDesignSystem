import { Token } from '../theme/Tokens';

/** 通用卡片：Surface 底色 + Level1 阴影 + RadiusMD 圆角 + MD 内边距。 */
@Component
export struct AppCard {
  @StorageLink('isDark') isDark: boolean = false;
  @BuilderParam content: () => void;

  build() {
    Column() {
      this.content()
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(Token.space.md)
    .backgroundColor(Token.color.surface())
    .borderRadius(Token.radius.md)
    .shadow({
      radius: Token.shadow.level1.radius,
      color: Token.shadow.level1.color,
      offsetX: Token.shadow.level1.offsetX,
      offsetY: Token.shadow.level1.offsetY
    })
  }
}

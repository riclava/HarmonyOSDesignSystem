import { Token } from '../theme/Tokens';

/**
 * 通用卡片：Surface 底色 + Level1 阴影 + RadiusMD 圆角 + MD 内边距。
 * clickable=true 时整卡可点，Pressed 升至 Level2。
 */
@Component
export struct AppCard {
  @Prop clickable: boolean = false;
  @StorageLink('isDark') isDark: boolean = false;
  @StorageLink('brand') brand: string = 'default';
  @StorageProp('compact') compact: boolean = false;
  @State private pressed: boolean = false;
  @BuilderParam content: () => void;
  onCardClick?: () => void;

  build() {
    Column() {
      this.content()
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(this.compact ? Token.space.sm : Token.space.md)
    .backgroundColor(Token.color.surface())
    .borderRadius(Token.radius.md)
    .shadow(this.clickable && this.pressed
      ? {
          radius: Token.shadow.level2.radius,
          color: Token.shadow.level2.color,
          offsetX: Token.shadow.level2.offsetX,
          offsetY: Token.shadow.level2.offsetY
        }
      : {
          radius: Token.shadow.level1.radius,
          color: Token.shadow.level1.color,
          offsetX: Token.shadow.level1.offsetX,
          offsetY: Token.shadow.level1.offsetY
        })
    .animation({ duration: Token.motion.fast, curve: Token.motion.easeStandard })
    .onTouch((event: TouchEvent) => {
      if (!this.clickable) {
        return;
      }
      if (event.type === TouchType.Down) {
        this.pressed = true;
      } else if (event.type === TouchType.Up || event.type === TouchType.Cancel) {
        this.pressed = false;
      }
    })
    .onClick(() => {
      if (this.clickable && this.onCardClick) {
        this.onCardClick();
      }
    })
  }
}

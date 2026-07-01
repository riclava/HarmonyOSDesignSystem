import { Token } from '../Tokens';

/**
 * 分段标签栏：等宽标签，选中项字色 Primary + 2vp 底部指示条。
 * 仅负责标签切换；内容区由调用方根据 selectedIndex 渲染。
 */
@Component
export struct AppTabs {
  @Prop tabs: string[] = [];
  @Prop selectedIndex: number = 0;
  @StorageLink('isDark') isDark: boolean = false;
  onSelect?: (index: number) => void;

  build() {
    Row() {
      ForEach(this.tabs, (label: string, index: number) => {
        Column() {
          Text(label)
            .fontSize(Token.font.label.size)
            .fontWeight(this.selectedIndex === index ? Token.font.label.weight : 400)
            .fontColor(this.selectedIndex === index ? Token.color.primary() : Token.color.onSurfaceVariant())
            .height(46)
            .textAlign(TextAlign.Center)
          Divider()
            .strokeWidth(2)
            .color(this.selectedIndex === index ? Token.color.primary() : Token.color.transparent())
            .animation({ duration: Token.motion.normal, curve: Token.motion.easeStandard })
        }
        .layoutWeight(1)
        .onClick(() => {
          this.selectedIndex = index;
          if (this.onSelect) {
            this.onSelect(index);
          }
        })
      })
    }
    .width('100%')
    .height(48)
    .backgroundColor(Token.color.surface())
  }
}

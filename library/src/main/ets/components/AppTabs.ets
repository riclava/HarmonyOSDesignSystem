import { Density, Token } from '../theme/Tokens';

/**
 * 分段标签栏：等宽标签，选中项字色 Primary + 2vp 底部指示条。
 * 仅负责标签切换；内容区由调用方根据 selectedIndex 渲染。
 */
@Component
export struct AppTabs {
  @Prop tabs: ResourceStr[] = [];
  @Prop selectedIndex: number = 0;
  @StorageLink('isDark') isDark: boolean = false;
  @StorageLink('brand') brand: string = 'default';
  @StorageProp('density') density: Density = Density.Comfortable;
  onSelect?: (index: number) => void;

  private tabTouch(): number {
    return Math.max(Token.size.tabBar(this.density), Token.size.minTouch);
  }

  build() {
    Row() {
      ForEach(this.tabs, (label: ResourceStr, index: number) => {
        Column() {
          Text(label)
            .fontSize(Token.font.label.sizeFor(this.density))
            .fontWeight(this.selectedIndex === index ? Token.font.label.weight : 400)
            .fontColor(this.selectedIndex === index ? Token.color.primary(this.brand) : Token.color.onSurfaceVariant())
            .height(Token.size.tabLabel(this.density))
            .textAlign(TextAlign.Center)
          Divider()
            .strokeWidth(2)
            .color(this.selectedIndex === index ? Token.color.primary(this.brand) : Token.color.transparent())
            .animation({ duration: Token.motion.normal, curve: Token.motion.easeStandard })
        }
        .layoutWeight(1)
        .responseRegion({ x: 0, y: (Token.size.tabBar(this.density) - this.tabTouch()) / 2, width: '100%', height: this.tabTouch() })
        .onClick(() => {
          this.selectedIndex = index;
          if (this.onSelect) {
            this.onSelect(index);
          }
        })
      }, (label: ResourceStr, index: number): string => index.toString())
    }
    .width('100%')
    .height(Token.size.tabBar(this.density))
    .backgroundColor(Token.color.surface())
  }
}

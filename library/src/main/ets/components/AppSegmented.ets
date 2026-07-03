import { Density, Token } from '../theme/Tokens';
import { LengthMetrics } from '@kit.ArkUI';

/**
 * 分段控制器：胶囊底槽 + 选中态浮起白片。
 * 与 AppTabs 的区别：Segmented 用于同级视图切换的紧凑开关，非页面级导航。
 */
@Component
export struct AppSegmented {
  @Prop segments: ResourceStr[] = [];
  @Prop selectedIndex: number = 0;
  @StorageLink('isDark') isDark: boolean = false;
  @StorageLink('brand') brand: string = 'default';
  @StorageProp('density') density: Density = Density.Comfortable;
  onSelect?: (index: number) => void;

  private trackHeight(): number {
    return Token.size.buttonMedium(this.density);
  }

  private touch(): number {
    return Math.max(this.trackHeight(), Token.size.minTouch);
  }

  build() {
    Row() {
      ForEach(this.segments, (label: ResourceStr, index: number) => {
        Text(label)
          .fontSize(Token.font.label.sizeFor(this.density))
          .fontWeight(Token.font.label.weight)
          .fontColor(this.selectedIndex === index ? Token.color.onSurface() : Token.color.onSurfaceVariant())
          .textAlign(TextAlign.Center)
          .layoutWeight(1)
          .height(this.trackHeight() - Token.space.xxs)
          .backgroundColor(this.selectedIndex === index ? Token.color.surface() : Token.color.transparent())
          .borderRadius(Token.radius.sm)
          .margin({ start: LengthMetrics.vp(Token.space.xxs), end: LengthMetrics.vp(Token.space.xxs) })
          .shadow(this.selectedIndex === index
            ? {
                radius: Token.shadow.level1.radius,
                color: Token.shadow.level1.color,
                offsetX: Token.shadow.level1.offsetX,
                offsetY: Token.shadow.level1.offsetY
              }
            : {
                radius: Token.shadow.level0.radius,
                color: Token.shadow.level0.color,
                offsetX: Token.shadow.level0.offsetX,
                offsetY: Token.shadow.level0.offsetY
              })
          .animation({ duration: Token.motion.fast, curve: Token.motion.easeOut })
          .responseRegion({ x: 0, y: (this.trackHeight() - this.touch()) / 2, width: '100%', height: this.touch() })
          .onClick(() => {
            this.selectedIndex = index;
            if (this.onSelect) {
              this.onSelect(index);
            }
          })
      }, (label: ResourceStr, index: number): string => index.toString())
    }
    .width('100%')
    .height(this.trackHeight())
    .backgroundColor(Token.color.divider())
    .borderRadius(Token.radius.md)
    .alignItems(VerticalAlign.Center)
  }
}

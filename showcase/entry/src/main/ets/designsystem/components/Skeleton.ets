import { Token } from '../Tokens';

/**
 * 骨架屏占位块：Divider 底色 + 循环微光动画（ExtraSlow）。
 * 用 width/height/radius 适配目标元素形状。
 */
@Component
export struct Skeleton {
  @Prop blockWidth: Length = '100%';
  @Prop blockHeight: Length = 16;
  @Prop radius: number = Token.radius.xs;
  @StorageLink('isDark') isDark: boolean = false;
  @State shimmer: boolean = false;

  aboutToAppear(): void {
    // 循环闪烁：透明度在 0.4~1 之间往返
    this.shimmer = true;
  }

  build() {
    Row()
      .width(this.blockWidth)
      .height(this.blockHeight)
      .backgroundColor(Token.color.divider())
      .borderRadius(this.radius)
      .opacity(this.shimmer ? 0.4 : 1)
      .animation({
        duration: Token.motion.extraSlow,
        curve: Token.motion.easeStandard,
        iterations: -1,
        playMode: PlayMode.Alternate
      })
  }
}

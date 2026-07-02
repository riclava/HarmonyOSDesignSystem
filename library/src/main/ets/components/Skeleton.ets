import { Token } from '../theme/Tokens';

/** 骨架屏占位块：Divider 底色 + 循环微光动画。 */
@Component
export struct Skeleton {
  @Prop blockWidth: Length = '100%';
  @Prop blockHeight: Length = Token.size.skeletonLine;
  @Prop radius: number = Token.radius.xs;
  @StorageLink('isDark') isDark: boolean = false;
  @State shimmer: boolean = false;

  aboutToAppear(): void {
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

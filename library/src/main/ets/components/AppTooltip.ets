import { Token } from '../theme/Tokens';
import { LengthMetrics } from '@kit.ArkUI';

/**
 * 文字提示：点击触发元素弹出简短说明气泡（移动端以点按代替悬停）。
 * 触发元素放入 content 插槽；message 为提示文案。
 */
@Component
export struct AppTooltip {
  @Prop message: ResourceStr = '';
  @Prop placement: Placement = Placement.Top;
  @StorageLink('isDark') isDark: boolean = false;
  @StorageProp('compact') compact: boolean = false;
  @State private show: boolean = false;
  @BuilderParam content: () => void;

  @Builder
  private tipBuilder() {
    Text(this.message)
      .fontSize(Token.font.caption.sizeFor(this.compact))
      .fontColor(Token.color.onSurface())
      .padding({
        start: LengthMetrics.vp(Token.space.sm),
        end: LengthMetrics.vp(Token.space.sm),
        top: LengthMetrics.vp(Token.space.xs),
        bottom: LengthMetrics.vp(Token.space.xs)
      })
      .constraintSize({ maxWidth: Token.size.popoverMaxWidth })
  }

  build() {
    Row() {
      this.content()
    }
    .bindPopup(this.show, {
      builder: this.tipBuilder,
      placement: this.placement,
      popupColor: Token.color.surface(),
      enableArrow: true,
      onStateChange: (event: PopupStateChangeParam) => {
        if (!event.isVisible) {
          this.show = false;
        }
      }
    })
    .onClick(() => {
      this.show = !this.show;
    })
  }
}

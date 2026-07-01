import { Token, isRTL } from '../theme/Tokens';
import { LengthMetrics } from '@kit.ArkUI';

/**
 * 列表项：左图标（可选）+ 主/次标题 + 右附件文本（可选）+ 箭头（可选）。
 * 单行 ≥ 56。leadingGlyph 传入 emoji 或图标字符占位。
 */
@Component
export struct AppListItem {
  @Prop title: string = '';
  @Prop subtitle: string = '';
  @Prop leadingGlyph: string = '';
  @Prop trailingText: string = '';
  @Prop showArrow: boolean = false;
  @Prop showDivider: boolean = true;
  @StorageLink('isDark') isDark: boolean = false;
  @StorageProp('compact') compact: boolean = false;
  onItemClick?: () => void;

  /** 方向性箭头：RTL 语言下指向左侧。 */
  private arrowGlyph(): string {
    return isRTL() ? '‹' : '›';
  }

  build() {
    Column() {
      Row() {
        if (this.leadingGlyph.length > 0) {
          Text(this.leadingGlyph)
            .fontSize(Token.icon.md)
            .width(Token.icon.lg)
            .textAlign(TextAlign.Center)
            .margin({ end: LengthMetrics.vp(Token.space.sm) })
        }
        Column() {
          Text(this.title)
            .fontSize(Token.font.body.sizeFor(this.compact))
            .fontColor(Token.color.onSurface())
          if (this.subtitle.length > 0) {
            Text(this.subtitle)
              .fontSize(Token.font.caption.sizeFor(this.compact))
              .fontColor(Token.color.onSurfaceVariant())
              .margin({ top: Token.space.xxs })
          }
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
        if (this.trailingText.length > 0) {
          Text(this.trailingText)
            .fontSize(Token.font.bodySmall.sizeFor(this.compact))
            .fontColor(Token.color.onSurfaceVariant())
            .margin({ start: LengthMetrics.vp(Token.space.sm) })
        }
        if (this.showArrow) {
          Text(this.arrowGlyph())
            .fontSize(Token.font.titleLarge.sizeFor(this.compact))
            .fontColor(Token.color.onSurfaceVariant())
            .margin({ start: LengthMetrics.vp(Token.space.xs) })
        }
      }
      .width('100%')
      .constraintSize({ minHeight: Token.size.rowMin(this.compact) })
      .padding({
        start: LengthMetrics.vp(Token.space.md),
        end: LengthMetrics.vp(Token.space.md),
        top: LengthMetrics.vp(this.compact ? Token.space.xs : Token.space.sm),
        bottom: LengthMetrics.vp(this.compact ? Token.space.xs : Token.space.sm)
      })
      .alignItems(VerticalAlign.Center)
      if (this.showDivider) {
        Divider()
          .color(Token.color.divider())
          .margin({ start: LengthMetrics.vp(Token.space.md) })
      }
    }
    .width('100%')
    .backgroundColor(Token.color.surface())
    .onClick(() => {
      if (this.onItemClick) {
        this.onItemClick();
      }
    })
  }
}

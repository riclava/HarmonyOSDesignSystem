import { Token } from '../theme/Tokens';

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
  onItemClick?: () => void;

  build() {
    Column() {
      Row() {
        if (this.leadingGlyph.length > 0) {
          Text(this.leadingGlyph)
            .fontSize(Token.icon.md)
            .width(Token.icon.lg)
            .textAlign(TextAlign.Center)
            .margin({ right: Token.space.sm })
        }
        Column() {
          Text(this.title)
            .fontSize(Token.font.body.size)
            .fontColor(Token.color.onSurface())
          if (this.subtitle.length > 0) {
            Text(this.subtitle)
              .fontSize(Token.font.caption.size)
              .fontColor(Token.color.onSurfaceVariant())
              .margin({ top: Token.space.xxs })
          }
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
        if (this.trailingText.length > 0) {
          Text(this.trailingText)
            .fontSize(Token.font.bodySmall.size)
            .fontColor(Token.color.onSurfaceVariant())
            .margin({ left: Token.space.sm })
        }
        if (this.showArrow) {
          Text('›')
            .fontSize(Token.font.titleLarge.size)
            .fontColor(Token.color.onSurfaceVariant())
            .margin({ left: Token.space.xs })
        }
      }
      .width('100%')
      .constraintSize({ minHeight: 56 })
      .padding({ left: Token.space.md, right: Token.space.md, top: Token.space.sm, bottom: Token.space.sm })
      .alignItems(VerticalAlign.Center)
      if (this.showDivider) {
        Divider()
          .color(Token.color.divider())
          .margin({ left: Token.space.md })
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

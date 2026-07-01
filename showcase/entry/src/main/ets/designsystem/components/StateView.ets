import { Token } from '../Tokens';

export enum StateKind { Loading, Empty, Error }

/**
 * 状态页：Loading / Empty / Error 统一结构。
 * 结构：图标区 + 标题 + 说明 + 可选行动按钮。
 */
@Component
export struct StateView {
  @Prop kind: StateKind = StateKind.Empty;
  @Prop title: string = '';
  @Prop description: string = '';
  @Prop actionLabel: string = '';
  @StorageLink('isDark') isDark: boolean = false;
  onAction?: () => void;

  private glyph(): string {
    switch (this.kind) {
      case StateKind.Loading: return '⏳';
      case StateKind.Error: return '⚠️';
      default: return '📭';
    }
  }

  private iconColor(): ResourceColor {
    return this.kind === StateKind.Error ? Token.color.danger() : Token.color.onSurfaceVariant();
  }

  build() {
    Column() {
      if (this.kind === StateKind.Loading) {
        LoadingProgress()
          .width(Token.icon.xxl)
          .height(Token.icon.xxl)
          .color(Token.color.primary())
      } else {
        Text(this.glyph())
          .fontSize(Token.icon.xxl)
          .fontColor(this.iconColor())
      }
      Text(this.title)
        .fontSize(Token.font.titleMedium.size)
        .fontWeight(Token.font.titleMedium.weight)
        .fontColor(Token.color.onSurface())
        .margin({ top: Token.space.sm })
      if (this.description.length > 0) {
        Text(this.description)
          .fontSize(Token.font.bodySmall.size)
          .fontColor(Token.color.onSurfaceVariant())
          .textAlign(TextAlign.Center)
          .margin({ top: Token.space.xxs })
      }
      if (this.actionLabel.length > 0) {
        Text(this.actionLabel)
          .fontSize(Token.font.label.size)
          .fontColor(Token.color.onPrimary())
          .height(40)
          .padding({ left: Token.space.lg, right: Token.space.lg })
          .backgroundColor(Token.color.primary())
          .borderRadius(Token.radius.sm)
          .margin({ top: Token.space.md })
          .onClick(() => { if (this.onAction) this.onAction(); })
      }
    }
    .width('100%')
    .padding(Token.space.xl)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}

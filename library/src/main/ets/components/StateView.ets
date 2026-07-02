import { Token } from '../theme/Tokens';
import { LengthMetrics } from '@kit.ArkUI';

export enum StateKind { Loading, Empty, Error }

/** 状态页：Loading / Empty / Error 统一结构（图标 + 标题 + 说明 + 可选行动）。 */
@Component
export struct StateView {
  @Prop kind: StateKind = StateKind.Empty;
  @Prop title: ResourceStr = '';
  @Prop description: ResourceStr = '';
  @Prop actionLabel: ResourceStr = '';
  @StorageLink('isDark') isDark: boolean = false;
  @StorageLink('brand') brand: string = 'default';
  @StorageProp('compact') compact: boolean = false;
  onAction?: () => void;

  private hasText(value: ResourceStr): boolean {
    return typeof value !== 'string' || value.length > 0;
  }

  private stateIconResource(): Resource {
    switch (this.kind) {
      case StateKind.Error:
        return $r('sys.symbol.exclamationmark_triangle_fill');
      default:
        return $r('sys.symbol.archivebox');
    }
  }

  private iconColor(): ResourceColor {
    return this.kind === StateKind.Error ? Token.color.danger() : Token.color.onSurfaceVariant();
  }

  build() {
    Column() {
      if (this.kind === StateKind.Loading) {
        LoadingProgress().width(Token.icon.xxl).height(Token.icon.xxl).color(Token.color.primary(this.brand))
      } else {
        SymbolGlyph(this.stateIconResource())
          .fontSize(Token.icon.xxl)
          .fontColor([this.iconColor()])
          .renderingStrategy(SymbolRenderingStrategy.MULTIPLE_OPACITY)
          .width(Token.icon.xxl)
          .height(Token.icon.xxl)
      }
      Text(this.title)
        .fontSize(Token.font.titleMedium.sizeFor(this.compact))
        .fontWeight(Token.font.titleMedium.weight)
        .fontColor(Token.color.onSurface())
        .margin({ top: Token.space.sm })
      if (this.hasText(this.description)) {
        Text(this.description)
          .fontSize(Token.font.bodySmall.sizeFor(this.compact))
          .fontColor(Token.color.onSurfaceVariant())
          .textAlign(TextAlign.Center)
          .margin({ top: Token.space.xxs })
      }
      if (this.hasText(this.actionLabel)) {
        Text(this.actionLabel)
          .fontSize(Token.font.label.sizeFor(this.compact))
          .fontColor(Token.color.onPrimary(this.brand))
          .height(Token.size.buttonMedium(this.compact))
          .padding({ start: LengthMetrics.vp(Token.space.lg), end: LengthMetrics.vp(Token.space.lg) })
          .backgroundColor(Token.color.primary(this.brand))
          .borderRadius(Token.radius.sm)
          .margin({ top: Token.space.md })
          .responseRegion({ x: 0, y: (Token.size.buttonMedium(this.compact) - Token.size.minTouch) / 2, width: '100%', height: Token.size.minTouch })
          .onClick(() => { if (this.onAction) this.onAction(); })
      }
    }
    .width('100%')
    .padding(Token.space.xl)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}

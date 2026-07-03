import { Density, Token, isRTL } from '../theme/Tokens';
import { LengthMetrics } from '@kit.ArkUI';

/**
 * 列表项：左图标（可选）+ 主/次标题 + 右附件文本（可选）+ 箭头（可选）。
 * 单行 ≥ 56。新代码使用 leadingIcon + showLeadingIcon 渲染系统 Symbol。
 */
@Component
export struct AppListItem {
  @Prop title: ResourceStr = '';
  @Prop subtitle: ResourceStr = '';
  @Prop leadingIcon: Resource = $r('sys.symbol.square_grid_2x2');
  @Prop showLeadingIcon: boolean = false;
  @Prop leadingGlyph: string = '';
  @Prop trailingText: ResourceStr = '';
  @Prop showArrow: boolean = false;
  @Prop showDivider: boolean = true;
  @StorageLink('isDark') isDark: boolean = false;
  @StorageLink('brand') brand: string = 'default';
  @StorageProp('density') density: Density = Density.Comfortable;
  onItemClick?: () => void;

  private arrowIcon(): Resource {
    return isRTL() ? $r('sys.symbol.chevron_left') : $r('sys.symbol.chevron_right');
  }

  private rowPadY(): number {
    switch (this.density) {
      case Density.SuperCompact: return Token.space.xxs;
      case Density.Compact: return Token.space.xs;
      default: return Token.space.sm;
    }
  }

  private hasText(value: ResourceStr): boolean {
    return typeof value !== 'string' || value.length > 0;
  }

  @Builder
  private leadingAccessory(): void {
    if (this.showLeadingIcon) {
      SymbolGlyph(this.leadingIcon)
        .fontSize(Token.icon.md)
        .fontColor([Token.color.primary(this.brand)])
        .renderingStrategy(SymbolRenderingStrategy.MULTIPLE_OPACITY)
        .width(Token.icon.lg)
        .height(Token.icon.lg)
        .margin({ end: LengthMetrics.vp(Token.space.sm) })
    } else if (this.leadingGlyph.length > 0) {
      Text(this.leadingGlyph)
        .fontSize(Token.icon.md)
        .width(Token.icon.lg)
        .textAlign(TextAlign.Center)
        .margin({ end: LengthMetrics.vp(Token.space.sm) })
    }
  }

  build() {
    Column() {
      Row() {
        this.leadingAccessory()
        Column() {
          Text(this.title)
            .fontSize(Token.font.body.sizeFor(this.density))
            .fontColor(Token.color.onSurface())
          if (this.hasText(this.subtitle)) {
            Text(this.subtitle)
              .fontSize(Token.font.caption.sizeFor(this.density))
              .fontColor(Token.color.onSurfaceVariant())
              .margin({ top: Token.space.xxs })
          }
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
        if (this.hasText(this.trailingText)) {
          Text(this.trailingText)
            .fontSize(Token.font.bodySmall.sizeFor(this.density))
            .fontColor(Token.color.onSurfaceVariant())
            .margin({ start: LengthMetrics.vp(Token.space.sm) })
        }
        if (this.showArrow) {
          SymbolGlyph(this.arrowIcon())
            .fontSize(Token.icon.xs)
            .fontColor([Token.color.onSurfaceVariant()])
            .renderingStrategy(SymbolRenderingStrategy.MULTIPLE_OPACITY)
            .width(Token.icon.sm)
            .height(Token.icon.sm)
            .margin({ start: LengthMetrics.vp(Token.space.xs) })
        }
      }
      .width('100%')
      .constraintSize({ minHeight: Token.size.rowMin(this.density) })
      .padding({
        start: LengthMetrics.vp(Token.space.md),
        end: LengthMetrics.vp(Token.space.md),
        top: LengthMetrics.vp(this.rowPadY()),
        bottom: LengthMetrics.vp(this.rowPadY())
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

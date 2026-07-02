import { Token } from '../theme/Tokens';
import { LengthMetrics } from '@kit.ArkUI';

/**
 * 可删除标签组：自动换行排列，每个 chip 带关闭按钮。
 * 删除动作回调 onDelete(index)，由业务更新 chips。
 */
@Component
export struct AppChipGroup {
  @Prop chips: ResourceStr[] = [];
  @Prop chipDisabled: boolean = false;
  @StorageLink('isDark') isDark: boolean = false;
  @StorageProp('compact') compact: boolean = false;
  onDelete?: (index: number) => void;

  build() {
    Flex({ wrap: FlexWrap.Wrap }) {
      ForEach(this.chips, (chip: ResourceStr, index: number) => {
        Row() {
          Text(chip)
            .fontSize(Token.font.bodySmall.sizeFor(this.compact))
            .fontColor(Token.color.onSurface())
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
          SymbolGlyph($r('sys.symbol.xmark'))
            .fontSize(Token.icon.xs)
            .fontColor([Token.color.onSurfaceVariant()])
            .width(Token.icon.sm)
            .height(Token.icon.sm)
            .margin({ start: LengthMetrics.vp(Token.space.xxs) })
            .accessibilityText($r('app.string.ds_chip_remove'))
            .onClick(() => {
              if (!this.chipDisabled && this.onDelete) {
                this.onDelete(index);
              }
            })
        }
        .height(Token.size.tagHeight)
        .padding({ start: LengthMetrics.vp(Token.space.sm), end: LengthMetrics.vp(Token.space.xs) })
        .margin({ end: LengthMetrics.vp(Token.space.xs), bottom: LengthMetrics.vp(Token.space.xs) })
        .backgroundColor(Token.color.divider())
        .borderRadius(Token.radius.full)
        .alignItems(VerticalAlign.Center)
        .opacity(this.chipDisabled ? 0.38 : 1)
      }, (chip: ResourceStr, index: number): string => index.toString())
    }
    .width('100%')
  }
}

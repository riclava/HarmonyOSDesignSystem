import { Token } from '../theme/Tokens';
import { LengthMetrics } from '@kit.ArkUI';

/**
 * 上传占位控件：虚线「添加」区 + 已选文件列表（可删除）。
 * 不内置文件选择器；由业务在 onAdd 中调用系统 Picker，并回填 files。
 */
@Component
export struct AppUpload {
  @Prop files: ResourceStr[] = [];
  @Prop hint: ResourceStr = $r('app.string.ds_upload_hint');
  @Prop uploadDisabled: boolean = false;
  @StorageLink('isDark') isDark: boolean = false;
  @StorageProp('compact') compact: boolean = false;
  onAdd?: () => void;
  onRemove?: (index: number) => void;

  build() {
    Column() {
      Row() {
        SymbolGlyph($r('sys.symbol.plus'))
          .fontSize(Token.icon.md)
          .fontColor([Token.color.primary()])
          .width(Token.icon.lg)
          .height(Token.icon.lg)
        Text(this.hint)
          .fontSize(Token.font.bodySmall.sizeFor(this.compact))
          .fontColor(Token.color.onSurfaceVariant())
          .margin({ start: LengthMetrics.vp(Token.space.xs) })
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .constraintSize({ minHeight: Token.size.field(this.compact) })
      .padding(Token.space.md)
      .borderRadius(Token.radius.md)
      .border({ width: 1, color: Token.color.outline(), style: BorderStyle.Dashed })
      .opacity(this.uploadDisabled ? 0.38 : 1)
      .enabled(!this.uploadDisabled)
      .onClick(() => {
        if (this.onAdd) {
          this.onAdd();
        }
      })
      ForEach(this.files, (name: ResourceStr, index: number) => {
        Row() {
          SymbolGlyph($r('sys.symbol.doc'))
            .fontSize(Token.icon.sm)
            .fontColor([Token.color.onSurfaceVariant()])
            .width(Token.icon.md)
            .height(Token.icon.md)
            .margin({ end: LengthMetrics.vp(Token.space.xs) })
          Text(name)
            .fontSize(Token.font.bodySmall.sizeFor(this.compact))
            .fontColor(Token.color.onSurface())
            .layoutWeight(1)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
          SymbolGlyph($r('sys.symbol.xmark'))
            .fontSize(Token.icon.sm)
            .fontColor([Token.color.onSurfaceVariant()])
            .width(Token.icon.md)
            .height(Token.icon.md)
            .responseRegion({ x: 0, y: 0, width: Token.size.minTouch, height: Token.size.minTouch })
            .accessibilityText($r('app.string.ds_upload_remove'))
            .onClick(() => {
              if (this.onRemove) {
                this.onRemove(index);
              }
            })
        }
        .width('100%')
        .constraintSize({ minHeight: Token.size.minTouch })
        .alignItems(VerticalAlign.Center)
        .margin({ top: Token.space.xs })
      }, (name: ResourceStr, index: number): string => index.toString())
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

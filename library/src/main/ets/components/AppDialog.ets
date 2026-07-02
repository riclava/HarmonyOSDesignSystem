import { Token } from '../theme/Tokens';
import { LengthMetrics } from '@kit.ArkUI';

/**
 * 通用对话框：标题 + 正文 + 操作区（取消 / 确认）。
 * 用法：new CustomDialogController({ builder: AppDialog({ ... }) })
 */
@CustomDialog
export struct AppDialog {
  controller: CustomDialogController;
  @Prop title: ResourceStr = '';
  @Prop message: ResourceStr = '';
  @Prop confirmLabel: ResourceStr = $r('app.string.ds_dialog_confirm');
  @Prop cancelLabel: ResourceStr = $r('app.string.ds_dialog_cancel');
  @StorageLink('isDark') isDark: boolean = false;
  @StorageLink('brand') brand: string = 'default';
  @StorageProp('compact') compact: boolean = false;
  confirm?: () => void;

  private actionTouchY(): number {
    return (Token.size.buttonMedium(this.compact) - Token.size.minTouch) / 2;
  }

  build() {
    Column() {
      Text(this.title)
        .fontSize(Token.font.titleLarge.sizeFor(this.compact))
        .fontWeight(Token.font.titleLarge.weight)
        .fontColor(Token.color.onSurface())
        .width('100%')
      Text(this.message)
        .fontSize(Token.font.body.sizeFor(this.compact))
        .fontColor(Token.color.onSurfaceVariant())
        .width('100%')
        .margin({ top: Token.space.sm })

      Row() {
        Text(this.cancelLabel)
          .fontSize(Token.font.label.sizeFor(this.compact))
          .fontColor(Token.color.onSurfaceVariant())
          .height(Token.size.buttonMedium(this.compact))
          .padding({ start: LengthMetrics.vp(Token.space.md), end: LengthMetrics.vp(Token.space.md) })
          .responseRegion({ x: 0, y: this.actionTouchY(), width: '100%', height: Token.size.minTouch })
          .onClick(() => { this.controller.close(); })
        Text(this.confirmLabel)
          .fontSize(Token.font.label.sizeFor(this.compact))
          .fontColor(Token.color.onPrimary())
          .height(Token.size.buttonMedium(this.compact))
          .padding({ start: LengthMetrics.vp(Token.space.lg), end: LengthMetrics.vp(Token.space.lg) })
          .backgroundColor(Token.color.primary())
          .borderRadius(Token.radius.sm)
          .margin({ start: LengthMetrics.vp(Token.space.sm) })
          .responseRegion({ x: 0, y: this.actionTouchY(), width: '100%', height: Token.size.minTouch })
          .onClick(() => {
            if (this.confirm) this.confirm();
            this.controller.close();
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.End)
      .margin({ top: Token.space.lg })
    }
    .width('100%')
    .constraintSize({ maxWidth: Token.size.dialogMaxWidth })
    .padding(this.compact ? Token.space.md : Token.space.lg)
    .backgroundColor(Token.color.surface())
    .borderRadius(Token.radius.lg)
  }
}

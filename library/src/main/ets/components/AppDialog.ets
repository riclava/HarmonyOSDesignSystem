import { Token } from '../theme/Tokens';

/**
 * 通用对话框：标题 + 正文 + 操作区（取消 / 确认）。
 * 用法：new CustomDialogController({ builder: AppDialog({ ... }) })
 */
@CustomDialog
export struct AppDialog {
  controller: CustomDialogController;
  @Prop title: string = '';
  @Prop message: string = '';
  @Prop confirmLabel: string = '确认';
  @Prop cancelLabel: string = '取消';
  @StorageLink('isDark') isDark: boolean = false;
  @StorageProp('compact') compact: boolean = false;
  confirm?: () => void;

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
          .height(40)
          .padding({ left: Token.space.md, right: Token.space.md })
          .onClick(() => { this.controller.close(); })
        Text(this.confirmLabel)
          .fontSize(Token.font.label.sizeFor(this.compact))
          .fontColor(Token.color.onPrimary())
          .height(40)
          .padding({ left: Token.space.lg, right: Token.space.lg })
          .backgroundColor(Token.color.primary())
          .borderRadius(Token.radius.sm)
          .margin({ left: Token.space.sm })
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
    .padding(this.compact ? Token.space.md : Token.space.lg)
    .backgroundColor(Token.color.surface())
    .borderRadius(Token.radius.lg)
  }
}

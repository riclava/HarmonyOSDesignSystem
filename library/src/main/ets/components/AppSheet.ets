import { Token } from '../theme/Tokens';

/**
 * 底部面板内容容器：顶部拖拽条 + 可选标题 + 自定义内容。
 * 配合调用方的 .bindSheet($$show, AppSheet(){...}) 使用。
 */
@Component
export struct AppSheet {
  @Prop title: ResourceStr = '';
  @StorageLink('isDark') isDark: boolean = false;
  @StorageProp('compact') compact: boolean = false;
  @BuilderParam content: () => void;

  private hasTitle(): boolean {
    return typeof this.title !== 'string' || this.title.length > 0;
  }

  build() {
    Column() {
      Row()
        .width(Token.size.sheetHandleWidth)
        .height(Token.size.sheetHandleHeight)
        .backgroundColor(Token.color.outline())
        .borderRadius(Token.radius.full)
        .margin({ bottom: Token.space.md })
      if (this.hasTitle()) {
        Text(this.title)
          .fontSize(Token.font.titleLarge.sizeFor(this.compact))
          .fontWeight(Token.font.titleLarge.weight)
          .fontColor(Token.color.onSurface())
          .margin({ bottom: Token.space.sm })
      }
      this.content()
    }
    .width('100%')
    .padding(Token.space.lg)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(Token.color.surface())
  }
}

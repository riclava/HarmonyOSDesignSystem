import { Token } from '../Tokens';

/**
 * 底部面板内容容器：顶部拖拽条 + 可选标题 + 自定义内容。
 * 配合调用方的 .bindSheet($$show, AppSheet(){...}) 使用。
 */
@Component
export struct AppSheet {
  @Prop title: string = '';
  @StorageLink('isDark') isDark: boolean = false;
  @StorageProp('compact') compact: boolean = false;
  @BuilderParam content: () => void;

  build() {
    Column() {
      Row()
        .width(32)
        .height(4)
        .backgroundColor(Token.color.outline())
        .borderRadius(Token.radius.full)
        .margin({ bottom: Token.space.md })
      if (this.title.length > 0) {
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

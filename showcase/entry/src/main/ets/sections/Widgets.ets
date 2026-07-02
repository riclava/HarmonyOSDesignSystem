import { Token } from '@riclava/designsystem';

/** 区块小标题 */
@Component
export struct SectionLabel {
  @Prop text: ResourceStr;
  @StorageLink('isDark') isDark: boolean = false;
  @StorageProp('compact') compact: boolean = false;

  build() {
    Text(this.text)
      .fontSize(Token.font.titleLarge.sizeFor(this.compact))
      .lineHeight(Token.font.titleLarge.lineHeightFor(this.compact))
      .fontWeight(Token.font.titleLarge.weight)
      .fontColor(Token.color.onSurface())
      .width('100%')
      .margin({ bottom: Token.space.sm })
  }
}

/** 演示块：统一 showcase 内的二级标题、边框、内边距与块间距。 */
@Component
export struct DemoBlock {
  @Prop title: ResourceStr;
  @StorageLink('isDark') isDark: boolean = false;
  @StorageProp('compact') compact: boolean = false;
  @BuilderParam content: () => void;

  build() {
    Column() {
      Text(this.title)
        .fontSize(Token.font.titleMedium.sizeFor(this.compact))
        .lineHeight(Token.font.titleMedium.lineHeightFor(this.compact))
        .fontWeight(Token.font.titleMedium.weight)
        .fontColor(Token.color.onSurface())
        .width('100%')
        .margin({ bottom: this.compact ? Token.space.xs : Token.space.sm })
      this.content()
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(this.compact ? Token.space.sm : Token.space.md)
    .backgroundColor(Token.color.surface())
    .borderRadius(Token.radius.md)
    .border({ width: 1, color: Token.color.divider() })
    .margin({ bottom: Token.space.md })
  }
}

/** 键值说明行：左标题，右取值 */
@Component
export struct SpecRow {
  @Prop name: ResourceStr;
  @Prop value: ResourceStr;
  @StorageLink('isDark') isDark: boolean = false;
  @StorageProp('compact') compact: boolean = false;

  build() {
    Row() {
      Text(this.name)
        .fontSize(Token.font.body.sizeFor(this.compact))
        .lineHeight(Token.font.body.lineHeightFor(this.compact))
        .fontColor(Token.color.onSurface())
        .layoutWeight(1)
      Text(this.value)
        .fontSize(Token.font.bodySmall.sizeFor(this.compact))
        .lineHeight(Token.font.bodySmall.lineHeightFor(this.compact))
        .fontColor(Token.color.onSurfaceVariant())
    }
    .width('100%')
    .padding({ top: Token.space.xs, bottom: Token.space.xs })
  }
}

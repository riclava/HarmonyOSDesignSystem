import { Token } from '../designsystem/Tokens';

/** 区块小标题 */
@Component
export struct SectionLabel {
  @Prop text: string;
  @StorageLink('isDark') isDark: boolean = false;
  @StorageProp('compact') compact: boolean = false;

  build() {
    Text(this.text)
      .fontSize(Token.font.titleLarge.sizeFor(this.compact))
      .fontWeight(Token.font.titleLarge.weight)
      .fontColor(Token.color.onSurface())
      .width('100%')
      .margin({ bottom: Token.space.sm })
  }
}

/** 键值说明行：左标题，右取值 */
@Component
export struct SpecRow {
  @Prop name: string;
  @Prop value: string;
  @StorageLink('isDark') isDark: boolean = false;
  @StorageProp('compact') compact: boolean = false;

  build() {
    Row() {
      Text(this.name)
        .fontSize(Token.font.body.sizeFor(this.compact))
        .fontColor(Token.color.onSurface())
        .layoutWeight(1)
      Text(this.value)
        .fontSize(Token.font.bodySmall.sizeFor(this.compact))
        .fontColor(Token.color.onSurfaceVariant())
    }
    .width('100%')
    .padding({ top: Token.space.xs, bottom: Token.space.xs })
  }
}

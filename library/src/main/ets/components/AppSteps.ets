import { Token } from '../theme/Tokens';

/**
 * 步骤条（水平）：序号圆点 + 连接线 + 标签。
 * current 为 0 基当前步；已完成/当前用 Primary，未达用 outline。
 */
@Component
export struct AppSteps {
  @Prop steps: ResourceStr[] = [];
  @Prop current: number = 0;
  @StorageLink('isDark') isDark: boolean = false;
  @StorageLink('brand') brand: string = 'default';
  @StorageProp('compact') compact: boolean = false;

  private dotSize(): number {
    return Token.size.buttonSmall(this.compact);
  }

  build() {
    Row() {
      ForEach(this.steps, (label: ResourceStr, index: number) => {
        Column() {
          Row() {
            if (index > 0) {
              Divider()
                .strokeWidth(2)
                .color(index <= this.current ? Token.color.primary(this.brand) : Token.color.outline())
                .layoutWeight(1)
            } else {
              Divider().strokeWidth(2).color(Token.color.transparent()).layoutWeight(1)
            }
            Text((index + 1).toString())
              .fontSize(Token.font.caption.sizeFor(this.compact))
              .fontColor(index <= this.current ? Token.color.onPrimary(this.brand) : Token.color.onSurfaceVariant())
              .textAlign(TextAlign.Center)
              .width(this.dotSize())
              .height(this.dotSize())
              .borderRadius(Token.radius.full)
              .backgroundColor(index <= this.current ? Token.color.primary(this.brand) : Token.color.transparent())
              .border(index <= this.current ? { width: 0 } : { width: 1, color: Token.color.outline() })
            if (index < this.steps.length - 1) {
              Divider()
                .strokeWidth(2)
                .color(index < this.current ? Token.color.primary(this.brand) : Token.color.outline())
                .layoutWeight(1)
            } else {
              Divider().strokeWidth(2).color(Token.color.transparent()).layoutWeight(1)
            }
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
          Text(label)
            .fontSize(Token.font.caption.sizeFor(this.compact))
            .fontColor(index <= this.current ? Token.color.onSurface() : Token.color.onSurfaceVariant())
            .textAlign(TextAlign.Center)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .margin({ top: Token.space.xxs })
        }
        .layoutWeight(1)
      }, (label: ResourceStr, index: number): string => index.toString())
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }
}

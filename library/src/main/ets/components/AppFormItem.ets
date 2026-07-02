import { Token } from '../theme/Tokens';
import { LengthMetrics } from '@kit.ArkUI';

/**
 * 表单项容器：统一 Label（可标必填）+ 控件插槽 + Error/Helper。
 * 校验逻辑由业务持有；本组件只负责一致的标签与错误态呈现。
 * 用法：把任意输入控件放进 content 插槽。
 */
@Component
export struct AppFormItem {
  @Prop label: ResourceStr = '';
  @Prop required: boolean = false;
  @Prop helper: ResourceStr = '';
  @Prop error: ResourceStr = '';
  @StorageLink('isDark') isDark: boolean = false;
  @StorageProp('compact') compact: boolean = false;
  @BuilderParam content: () => void;

  private hasText(value: ResourceStr): boolean {
    return typeof value !== 'string' || value.length > 0;
  }

  build() {
    Column() {
      if (this.hasText(this.label)) {
        Row() {
          if (this.required) {
            Text('*')
              .fontSize(Token.font.label.sizeFor(this.compact))
              .fontColor(Token.color.danger())
              .margin({ end: LengthMetrics.vp(Token.space.xxs) })
          }
          Text(this.label)
            .fontSize(Token.font.label.sizeFor(this.compact))
            .fontWeight(Token.font.label.weight)
            .fontColor(Token.color.onSurface())
        }
        .alignItems(VerticalAlign.Center)
        .margin({ bottom: Token.space.xxs })
      }
      this.content()
      if (this.hasText(this.error)) {
        Text(this.error)
          .fontSize(Token.font.caption.sizeFor(this.compact))
          .fontColor(Token.color.danger())
          .margin({ top: Token.space.xxs })
      } else if (this.hasText(this.helper)) {
        Text(this.helper)
          .fontSize(Token.font.caption.sizeFor(this.compact))
          .fontColor(Token.color.onSurfaceVariant())
          .margin({ top: Token.space.xxs })
      }
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

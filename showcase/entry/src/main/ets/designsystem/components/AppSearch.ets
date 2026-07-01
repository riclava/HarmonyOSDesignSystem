import { Token } from '../Tokens';

/** 搜索框：胶囊外形（RadiusFull），左侧搜索图标，有内容时右侧可清除。 */
@Component
export struct AppSearch {
  @Prop text: string = '';
  @Prop placeholder: string = '搜索…';
  @StorageLink('isDark') isDark: boolean = false;
  onTextChange?: (value: string) => void;
  onSubmit?: (value: string) => void;

  build() {
    Row() {
      Text('🔍')
        .fontSize(Token.font.bodySmall.size)
        .margin({ right: Token.space.xs })
      TextInput({ placeholder: this.placeholder, text: this.text })
        .fontSize(Token.font.body.size)
        .fontColor(Token.color.onSurface())
        .placeholderColor(Token.color.onSurfaceVariant())
        .backgroundColor(Token.color.transparent())
        .borderRadius(0)
        .padding(0)
        .layoutWeight(1)
        .onChange((v: string) => {
          this.text = v;
          if (this.onTextChange) {
            this.onTextChange(v);
          }
        })
        .onSubmit(() => {
          if (this.onSubmit) {
            this.onSubmit(this.text);
          }
        })
      if (this.text.length > 0) {
        Text('✕')
          .fontSize(Token.font.caption.size)
          .fontColor(Token.color.onSurfaceVariant())
          .width(44)
          .height(44)
          .textAlign(TextAlign.Center)
          .accessibilityText('清除')
          .onClick(() => {
            this.text = '';
            if (this.onTextChange) {
              this.onTextChange('');
            }
          })
      }
    }
    .width('100%')
    .height(48)
    .padding({ left: Token.space.md, right: Token.space.xs })
    .backgroundColor(Token.color.surface())
    .borderRadius(Token.radius.full)
    .border({ width: 1, color: Token.color.outline() })
    .alignItems(VerticalAlign.Center)
  }
}

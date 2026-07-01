import { Token } from '../theme/Tokens';

export enum AppAvatarShape { Circle, Rounded }

/** 头像：无图时用首字母 + 语义底色。尺寸建议 24/32/40/48/64。 */
@Component
export struct AppAvatar {
  @Prop text: string = '';
  @Prop avatarSize: number = 40;
  @Prop shape: AppAvatarShape = AppAvatarShape.Circle;
  @Prop bgColor: ResourceColor = '#2979FF';
  @StorageLink('isDark') isDark: boolean = false;

  private initial(): string {
    return this.text.length > 0 ? this.text.substring(0, 1).toUpperCase() : '?';
  }

  build() {
    Text(this.initial())
      .fontSize(this.avatarSize * 0.4)
      .fontWeight(Token.font.label.weight)
      .fontColor(Token.color.onPrimary())
      .textAlign(TextAlign.Center)
      .width(this.avatarSize)
      .height(this.avatarSize)
      .backgroundColor(this.bgColor)
      .borderRadius(this.shape === AppAvatarShape.Circle ? this.avatarSize / 2 : Token.radius.md)
  }
}

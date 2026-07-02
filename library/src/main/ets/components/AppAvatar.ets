import { Token } from '../theme/Tokens';

export enum AppAvatarShape { Circle, Rounded }

/** 头像：无图时用首字母 + 语义底色。尺寸建议 24/32/40/48/64。 */
@Component
export struct AppAvatar {
  @Prop text: string = '';
  @Prop avatarSize: number = Token.size.avatarMd;
  @Prop shape: AppAvatarShape = AppAvatarShape.Circle;
  @Prop bgColor: ResourceColor = Token.color.primary();
  @StorageLink('isDark') isDark: boolean = false;
  @StorageLink('brand') brand: string = 'default';
  @StorageProp('compact') compact: boolean = false;

  private initial(): string {
    return this.text.length > 0 ? this.text.substring(0, 1).toUpperCase() : '?';
  }

  private textSize(): number {
    if (this.avatarSize <= Token.size.avatarXs) {
      return Token.font.caption.sizeFor(this.compact);
    }
    if (this.avatarSize <= Token.size.avatarSm) {
      return Token.font.bodySmall.sizeFor(this.compact);
    }
    if (this.avatarSize <= Token.size.avatarMd) {
      return Token.font.body.sizeFor(this.compact);
    }
    return Token.font.titleMedium.sizeFor(this.compact);
  }

  build() {
    Text(this.initial())
      .fontSize(this.textSize())
      .fontWeight(Token.font.label.weight)
      .fontColor(Token.color.onPrimary())
      .textAlign(TextAlign.Center)
      .width(this.avatarSize)
      .height(this.avatarSize)
      .backgroundColor(this.bgColor)
      .borderRadius(this.shape === AppAvatarShape.Circle ? Token.radius.full : Token.radius.md)
  }
}

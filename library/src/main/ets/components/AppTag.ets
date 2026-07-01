import { Token } from '../theme/Tokens';

export enum AppTagTone { Neutral, Primary, Success, Warning, Danger, Info }

/** 胶囊标签，颜色使用状态语义 Token。 */
@Component
export struct AppTag {
  @Prop label: string;
  @Prop tone: AppTagTone = AppTagTone.Neutral;
  @StorageLink('isDark') isDark: boolean = false;

  private fg(): ResourceColor {
    switch (this.tone) {
      case AppTagTone.Primary: return Token.color.primary();
      case AppTagTone.Success: return Token.color.success();
      case AppTagTone.Warning: return Token.color.warning();
      case AppTagTone.Danger: return Token.color.danger();
      case AppTagTone.Info: return Token.color.info();
      default: return Token.color.onSurfaceVariant();
    }
  }

  build() {
    Text(this.label)
      .fontSize(Token.font.caption.size)
      .fontColor(this.fg())
      .height(24)
      .padding({ left: Token.space.xs, right: Token.space.xs })
      .borderRadius(Token.radius.full)
      .border({ width: 1, color: this.fg() })
      .textAlign(TextAlign.Center)
  }
}

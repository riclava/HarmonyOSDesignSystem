import { Density, Token } from '../theme/Tokens';
import { LengthMetrics } from '@kit.ArkUI';

export enum AppTagTone { Neutral, Primary, Success, Warning, Danger, Info }

/** 胶囊标签，颜色使用状态语义 Token。 */
@Component
export struct AppTag {
  @Prop label: ResourceStr = '';
  @Prop tone: AppTagTone = AppTagTone.Neutral;
  @StorageLink('isDark') isDark: boolean = false;
  @StorageLink('brand') brand: string = 'default';
  @StorageProp('density') density: Density = Density.Comfortable;

  private fg(): ResourceColor {
    switch (this.tone) {
      case AppTagTone.Primary: return Token.color.primary(this.brand);
      case AppTagTone.Success: return Token.color.success();
      case AppTagTone.Warning: return Token.color.warning();
      case AppTagTone.Danger: return Token.color.danger();
      case AppTagTone.Info: return Token.color.info();
      default: return Token.color.onSurfaceVariant();
    }
  }

  build() {
    Text(this.label)
      .fontSize(Token.font.caption.sizeFor(this.density))
      .fontColor(this.fg())
      .height(Token.size.tagHeight)
      .padding({ start: LengthMetrics.vp(Token.space.xs), end: LengthMetrics.vp(Token.space.xs) })
      .borderRadius(Token.radius.full)
      .border({ width: 1, color: this.fg() })
      .textAlign(TextAlign.Center)
  }
}

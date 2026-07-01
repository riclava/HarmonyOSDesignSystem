import { Token } from '../theme/Tokens';

export enum AppProgressKind { Linear, Ring }

/** 进度：线性（高 4）或环形（56）。前景 Primary，底 Outline。 */
@Component
export struct AppProgress {
  @Prop value: number = 0;
  @Prop total: number = 100;
  @Prop kind: AppProgressKind = AppProgressKind.Linear;
  @StorageLink('isDark') isDark: boolean = false;

  build() {
    if (this.kind === AppProgressKind.Ring) {
      Progress({ value: this.value, total: this.total, type: ProgressType.Ring })
        .color(Token.color.primary())
        .backgroundColor(Token.color.outline())
        .width(56)
        .height(56)
    } else {
      Progress({ value: this.value, total: this.total, type: ProgressType.Linear })
        .color(Token.color.primary())
        .backgroundColor(Token.color.outline())
        .width('100%')
    }
  }
}

import { Token, AppAvatar, AppAvatarShape, AppBadge, AppProgress, AppProgressKind } from '@riclava/designsystem';
import { LengthMetrics } from '@kit.ArkUI';
import { SectionLabel } from './Widgets';

@Component
export struct DataDisplaySection {
  @StorageLink('isDark') isDark: boolean = false;

  build() {
    Column() {
      // Avatar
      SectionLabel({ text: $r('app.string.sec_avatar') })
      Row() {
        AppAvatar({ text: 'A', avatarSize: Token.size.avatarSm, bgColor: Token.color.primary() })
          .margin({ end: LengthMetrics.vp(Token.space.sm) })
        AppAvatar({ text: 'B', avatarSize: Token.size.avatarMd, bgColor: Token.color.secondary() })
          .margin({ end: LengthMetrics.vp(Token.space.sm) })
        AppAvatar({ text: 'C', avatarSize: Token.size.avatarLg, bgColor: Token.color.warning() })
          .margin({ end: LengthMetrics.vp(Token.space.sm) })
        AppAvatar({ text: 'D', avatarSize: Token.size.avatarLg, shape: AppAvatarShape.Rounded, bgColor: Token.color.info() })
      }
      .width('100%')
      .margin({ bottom: Token.space.md })

      // Badge on avatar
      SectionLabel({ text: $r('app.string.sec_badge') })
      Row() {
        Stack({ alignContent: Alignment.TopEnd }) {
          AppAvatar({ text: 'M', avatarSize: Token.size.avatarLg, bgColor: Token.color.primary() })
          AppBadge({ count: 5 })
        }
        .margin({ end: LengthMetrics.vp(Token.space.lg) })

        Stack({ alignContent: Alignment.TopEnd }) {
          AppAvatar({ text: 'N', avatarSize: Token.size.avatarLg, bgColor: Token.color.secondary() })
          AppBadge({ count: 128 })
        }
        .margin({ end: LengthMetrics.vp(Token.space.lg) })

        Stack({ alignContent: Alignment.TopEnd }) {
          AppAvatar({ text: 'O', avatarSize: Token.size.avatarLg, bgColor: Token.color.info() })
          AppBadge({ dot: true })
        }
      }
      .width('100%')
      .margin({ bottom: Token.space.md })

      // Progress
      SectionLabel({ text: $r('app.string.sec_progress') })
      AppProgress({ value: 60, total: 100, kind: AppProgressKind.Linear })
        .margin({ bottom: Token.space.md })
      Row() {
        AppProgress({ value: 30, total: 100, kind: AppProgressKind.Ring })
          .margin({ end: LengthMetrics.vp(Token.space.lg) })
        AppProgress({ value: 70, total: 100, kind: AppProgressKind.Ring })
          .margin({ end: LengthMetrics.vp(Token.space.lg) })
        LoadingProgress()
          .width(Token.size.avatarMd).height(Token.size.avatarMd)
          .color(Token.color.primary())
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .margin({ bottom: Token.space.lg })
  }
}

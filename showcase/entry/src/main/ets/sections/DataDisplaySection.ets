import { Token, AppAvatar, AppAvatarShape, AppBadge, AppProgress, AppProgressKind } from '@riclava/designsystem';
import { LengthMetrics } from '@kit.ArkUI';
import { DemoBlock } from './Widgets';

@Component
export struct DataDisplaySection {
  @StorageLink('isDark') isDark: boolean = false;

  build() {
    Column() {
      // Avatar
      DemoBlock({ title: $r('app.string.sec_avatar') }) {
        Flex({ wrap: FlexWrap.Wrap, alignItems: ItemAlign.Center }) {
          AppAvatar({ text: 'A', avatarSize: Token.size.avatarSm, bgColor: Token.color.primary() })
            .margin({ end: LengthMetrics.vp(Token.space.sm), bottom: Token.space.xs })
          AppAvatar({ text: 'B', avatarSize: Token.size.avatarMd, bgColor: Token.color.secondary() })
            .margin({ end: LengthMetrics.vp(Token.space.sm), bottom: Token.space.xs })
          AppAvatar({ text: 'C', avatarSize: Token.size.avatarLg, bgColor: Token.color.warning() })
            .margin({ end: LengthMetrics.vp(Token.space.sm), bottom: Token.space.xs })
          AppAvatar({ text: 'D', avatarSize: Token.size.avatarLg, shape: AppAvatarShape.Rounded, bgColor: Token.color.info() })
            .margin({ bottom: Token.space.xs })
        }
        .width('100%')
      }

      // Badge on avatar
      DemoBlock({ title: $r('app.string.sec_badge') }) {
        Flex({ wrap: FlexWrap.Wrap, alignItems: ItemAlign.Center }) {
          Stack({ alignContent: Alignment.TopEnd }) {
            AppAvatar({ text: 'M', avatarSize: Token.size.avatarLg, bgColor: Token.color.primary() })
            AppBadge({ count: 5 })
          }
          .margin({ end: LengthMetrics.vp(Token.space.lg), bottom: Token.space.xs })

          Stack({ alignContent: Alignment.TopEnd }) {
            AppAvatar({ text: 'N', avatarSize: Token.size.avatarLg, bgColor: Token.color.secondary() })
            AppBadge({ count: 128 })
          }
          .margin({ end: LengthMetrics.vp(Token.space.lg), bottom: Token.space.xs })

          Stack({ alignContent: Alignment.TopEnd }) {
            AppAvatar({ text: 'O', avatarSize: Token.size.avatarLg, bgColor: Token.color.info() })
            AppBadge({ dot: true })
          }
          .margin({ bottom: Token.space.xs })
        }
        .width('100%')
      }

      // Progress
      DemoBlock({ title: $r('app.string.sec_progress') }) {
        AppProgress({ value: 60, total: 100, kind: AppProgressKind.Linear })
          .margin({ bottom: Token.space.md })
        Flex({ wrap: FlexWrap.Wrap, alignItems: ItemAlign.Center }) {
          AppProgress({ value: 30, total: 100, kind: AppProgressKind.Ring })
            .margin({ end: LengthMetrics.vp(Token.space.lg), bottom: Token.space.xs })
          AppProgress({ value: 70, total: 100, kind: AppProgressKind.Ring })
            .margin({ end: LengthMetrics.vp(Token.space.lg), bottom: Token.space.xs })
          LoadingProgress()
            .width(Token.size.avatarMd).height(Token.size.avatarMd)
            .color(Token.color.primary())
            .margin({ bottom: Token.space.xs })
        }
        .width('100%')
      }
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .margin({ bottom: Token.space.lg })
  }
}

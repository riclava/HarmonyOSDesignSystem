import { Token } from '../designsystem/Tokens';
import { SectionLabel } from './Widgets';
import { AppAvatar, AppAvatarShape } from '../designsystem/components/AppAvatar';
import { AppBadge } from '../designsystem/components/AppBadge';

@Component
export struct DataDisplaySection {
  @StorageLink('isDark') isDark: boolean = false;

  build() {
    Column() {
      // Avatar
      SectionLabel({ text: 'Avatar · 头像' })
      Row() {
        AppAvatar({ text: 'A', avatarSize: 32, bgColor: Token.color.primary() })
          .margin({ right: Token.space.sm })
        AppAvatar({ text: 'B', avatarSize: 40, bgColor: Token.color.secondary() })
          .margin({ right: Token.space.sm })
        AppAvatar({ text: 'C', avatarSize: 48, bgColor: Token.color.warning() })
          .margin({ right: Token.space.sm })
        AppAvatar({ text: 'D', avatarSize: 48, shape: AppAvatarShape.Rounded, bgColor: Token.color.info() })
      }
      .width('100%')
      .margin({ bottom: Token.space.md })

      // Badge on avatar
      SectionLabel({ text: 'Badge · 徽标' })
      Row() {
        Stack({ alignContent: Alignment.TopEnd }) {
          AppAvatar({ text: 'M', avatarSize: 48, bgColor: Token.color.primary() })
          AppBadge({ count: 5 })
        }
        .margin({ right: Token.space.lg })

        Stack({ alignContent: Alignment.TopEnd }) {
          AppAvatar({ text: 'N', avatarSize: 48, bgColor: Token.color.secondary() })
          AppBadge({ count: 128 })
        }
        .margin({ right: Token.space.lg })

        Stack({ alignContent: Alignment.TopEnd }) {
          AppAvatar({ text: 'O', avatarSize: 48, bgColor: Token.color.info() })
          AppBadge({ dot: true })
        }
      }
      .width('100%')
      .margin({ bottom: Token.space.md })

      // Circular progress
      SectionLabel({ text: 'Progress · 环形进度' })
      Row() {
        Progress({ value: 30, total: 100, type: ProgressType.Ring })
          .color(Token.color.primary())
          .backgroundColor(Token.color.outline())
          .width(56).height(56)
          .margin({ right: Token.space.lg })
        Progress({ value: 70, total: 100, type: ProgressType.Ring })
          .color(Token.color.success())
          .backgroundColor(Token.color.outline())
          .width(56).height(56)
          .margin({ right: Token.space.lg })
        LoadingProgress()
          .width(40).height(40)
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

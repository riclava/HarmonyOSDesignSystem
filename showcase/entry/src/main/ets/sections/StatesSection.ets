import { Token, StateView, StateKind, Skeleton, AppCard } from '@riclava/designsystem';
import { LengthMetrics } from '@kit.ArkUI';
import { SectionLabel } from './Widgets';

/** 状态展示用的边框卡片容器，内容通过 @BuilderParam 注入。 */
@Component
struct StateCard {
  @StorageLink('isDark') isDark: boolean = false;
  @BuilderParam content: () => void;

  build() {
    Column() {
      this.content()
    }
    .width('100%')
    .backgroundColor(Token.color.surface())
    .borderRadius(Token.radius.md)
    .border({ width: 1, color: Token.color.divider() })
    .margin({ bottom: Token.space.md })
  }
}

@Component
export struct StatesSection {
  @StorageLink('isDark') isDark: boolean = false;

  build() {
    Column() {
      SectionLabel({ text: $r('app.string.sec_loading') })
      StateCard() {
        StateView({ kind: StateKind.Loading, title: $r('app.string.state_loading_title'), description: $r('app.string.state_loading_desc') })
      }

      SectionLabel({ text: $r('app.string.sec_empty') })
      StateCard() {
        StateView({
          kind: StateKind.Empty,
          title: $r('app.string.state_empty_title'),
          description: $r('app.string.state_empty_desc'),
          actionLabel: $r('app.string.state_empty_action')
        })
      }

      SectionLabel({ text: $r('app.string.sec_error') })
      StateCard() {
        StateView({
          kind: StateKind.Error,
          title: $r('app.string.state_error_title'),
          description: $r('app.string.state_error_desc'),
          actionLabel: $r('app.string.state_error_action')
        })
      }

      SectionLabel({ text: $r('app.string.sec_skeleton') })
      AppCard() {
        Row() {
          Skeleton({ blockWidth: Token.size.avatarLg, blockHeight: Token.size.avatarLg, radius: Token.radius.full })
          Column({ space: Token.space.xs }) {
            Skeleton({ blockWidth: '60%', blockHeight: Token.size.skeletonLine })
            Skeleton({ blockWidth: '90%', blockHeight: Token.font.caption.size })
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)
          .margin({ start: LengthMetrics.vp(Token.space.md) })
        }
        .width('100%')
      }
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .margin({ bottom: Token.space.lg })
  }
}

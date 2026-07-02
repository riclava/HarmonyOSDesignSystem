import { Token, StateView, StateKind, Skeleton, AppCard } from '@riclava/designsystem';
import { LengthMetrics } from '@kit.ArkUI';
import { DemoBlock } from './Widgets';

@Component
export struct StatesSection {
  @StorageLink('isDark') isDark: boolean = false;
  @StorageLink('brand') brand: string = 'default';

  build() {
    Column() {
      DemoBlock({ title: $r('app.string.sec_loading') }) {
        StateView({ kind: StateKind.Loading, title: $r('app.string.state_loading_title'), description: $r('app.string.state_loading_desc') })
      }

      DemoBlock({ title: $r('app.string.sec_empty') }) {
        StateView({
          kind: StateKind.Empty,
          title: $r('app.string.state_empty_title'),
          description: $r('app.string.state_empty_desc'),
          actionLabel: $r('app.string.state_empty_action')
        })
      }

      DemoBlock({ title: $r('app.string.sec_error') }) {
        StateView({
          kind: StateKind.Error,
          title: $r('app.string.state_error_title'),
          description: $r('app.string.state_error_desc'),
          actionLabel: $r('app.string.state_error_action')
        })
      }

      DemoBlock({ title: $r('app.string.sec_skeleton') }) {
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
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .margin({ bottom: Token.space.lg })
  }
}

import { Token, StateView, StateKind, Skeleton, AppCard } from '@riclava/designsystem';
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
      SectionLabel({ text: 'Loading' })
      StateCard() {
        StateView({ kind: StateKind.Loading, title: '加载中', description: '正在获取数据…' })
      }

      SectionLabel({ text: 'Empty' })
      StateCard() {
        StateView({
          kind: StateKind.Empty,
          title: '暂无内容',
          description: '这里还什么都没有，去添加第一条吧。',
          actionLabel: '新建'
        })
      }

      SectionLabel({ text: 'Error' })
      StateCard() {
        StateView({
          kind: StateKind.Error,
          title: '加载失败',
          description: '网络异常，请稍后重试。',
          actionLabel: '重试'
        })
      }

      SectionLabel({ text: 'Skeleton · 骨架屏' })
      AppCard() {
        Row() {
          Skeleton({ blockWidth: 48, blockHeight: 48, radius: Token.radius.full })
          Column({ space: Token.space.xs }) {
            Skeleton({ blockWidth: '60%', blockHeight: 16 })
            Skeleton({ blockWidth: '90%', blockHeight: 12 })
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)
          .margin({ left: Token.space.md })
        }
        .width('100%')
      }
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .margin({ bottom: Token.space.lg })
  }
}

import { Token, AppTabs, AppListItem, AppToast } from '@riclava/designsystem';
import { SectionLabel } from './Widgets';

@Component
export struct NavigationSection {
  @StorageLink('isDark') isDark: boolean = false;
  @State activeIndex: number = 0;
  private tabs: string[] = ['全部', '进行中', '已完成'];

  build() {
    Column() {
      SectionLabel({ text: 'Tabs · 分段标签' })
      AppTabs({
        tabs: this.tabs,
        selectedIndex: this.activeIndex,
        onSelect: (i: number): void => { this.activeIndex = i; }
      })
      Text(`当前选中：${this.tabs[this.activeIndex]}`)
        .fontSize(Token.font.bodySmall.size)
        .fontColor(Token.color.onSurfaceVariant())
        .margin({ top: Token.space.sm, bottom: Token.space.md })

      SectionLabel({ text: 'List · 列表' })
      Column() {
        AppListItem({
          title: '账户与安全',
          leadingGlyph: '🔐',
          showArrow: true,
          onItemClick: (): void => { AppToast.show('账户与安全'); }
        })
        AppListItem({
          title: '通知',
          subtitle: '推送、声音与振动',
          leadingGlyph: '🔔',
          trailingText: '已开启',
          showArrow: true,
          onItemClick: (): void => { AppToast.show('通知'); }
        })
        AppListItem({
          title: '通用',
          leadingGlyph: '⚙️',
          showArrow: true,
          showDivider: false,
          onItemClick: (): void => { AppToast.show('通用'); }
        })
      }
      .clip(true)
      .borderRadius(Token.radius.md)
      .border({ width: 1, color: Token.color.divider() })
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .margin({ bottom: Token.space.lg })
  }
}

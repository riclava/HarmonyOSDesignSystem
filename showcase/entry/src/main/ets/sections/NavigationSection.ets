import { Token, AppTabs, AppListItem, AppToast } from '@riclava/designsystem';
import { SectionLabel } from './Widgets';

@Component
export struct NavigationSection {
  @StorageLink('isDark') isDark: boolean = false;
  @State activeIndex: number = 0;
  private tabs: ResourceStr[] = [
    $r('app.string.nav_tab_all'),
    $r('app.string.nav_tab_ongoing'),
    $r('app.string.nav_tab_done')
  ];

  private selectedName(): string {
    const ctx = this.getUIContext().getHostContext();
    const item = this.tabs[this.activeIndex];
    return typeof item === 'string' ? item : (ctx?.resourceManager.getStringSync(item) ?? '');
  }

  build() {
    Column() {
      SectionLabel({ text: $r('app.string.sec_tabs') })
      AppTabs({
        tabs: this.tabs,
        selectedIndex: this.activeIndex,
        onSelect: (i: number): void => { this.activeIndex = i; }
      })
      Text($r('app.string.nav_selected', this.selectedName()))
        .fontSize(Token.font.bodySmall.size)
        .fontColor(Token.color.onSurfaceVariant())
        .margin({ top: Token.space.sm, bottom: Token.space.md })

      SectionLabel({ text: $r('app.string.sec_list') })
      Column() {
        AppListItem({
          title: $r('app.string.list_account'),
          leadingIcon: $r('sys.symbol.lock_fill'),
          showLeadingIcon: true,
          showArrow: true,
          onItemClick: (): void => { AppToast.show($r('app.string.list_account')); }
        })
        AppListItem({
          title: $r('app.string.list_notification'),
          subtitle: $r('app.string.list_notification_sub'),
          leadingIcon: $r('sys.symbol.bell_fill'),
          showLeadingIcon: true,
          trailingText: $r('app.string.list_notification_trailing'),
          showArrow: true,
          onItemClick: (): void => { AppToast.show($r('app.string.list_notification')); }
        })
        AppListItem({
          title: $r('app.string.list_general'),
          leadingIcon: $r('sys.symbol.gearshape_fill'),
          showLeadingIcon: true,
          showArrow: true,
          showDivider: false,
          onItemClick: (): void => { AppToast.show($r('app.string.list_general')); }
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

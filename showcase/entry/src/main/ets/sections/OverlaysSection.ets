import { Token } from '../designsystem/Tokens';
import { SectionLabel } from './Widgets';
import { AppDialog } from '../designsystem/components/AppDialog';
import { AppButton, AppButtonType } from '../designsystem/components/AppButton';
import { AppSheet } from '../designsystem/components/AppSheet';
import { AppMenu, AppMenuItem } from '../designsystem/components/AppMenu';
import { AppPopover } from '../designsystem/components/AppPopover';
import { AppToast } from '../designsystem/components/AppToast';

@Component
export struct OverlaysSection {
  @StorageLink('isDark') isDark: boolean = false;
  @State sheetShown: boolean = false;

  private menuItems: AppMenuItem[] = [
    new AppMenuItem('编辑', (): void => { AppToast.show('编辑'); }),
    new AppMenuItem('分享', (): void => { AppToast.show('分享'); }),
    new AppMenuItem('删除', (): void => { AppToast.show('删除'); }, true)
  ];

  dialogController: CustomDialogController = new CustomDialogController({
    builder: AppDialog({
      title: '删除确认',
      message: '删除后不可恢复，确定继续吗？',
      confirmLabel: '删除',
      confirm: (): void => { AppToast.show('已删除'); }
    }),
    customStyle: true,
    alignment: DialogAlignment.Center
  });

  @Builder
  sheetBuilder() {
    AppSheet({ title: 'BottomSheet 底部面板' }) {
      Text('顶部圆角、拖拽条、Level4 阴影，支持下拉关闭。')
        .fontSize(Token.font.bodySmall.size)
        .fontColor(Token.color.onSurfaceVariant())
        .margin({ bottom: Token.space.lg })
      AppButton({ label: '关闭', type: AppButtonType.Secondary })
        .onClick((): void => { this.sheetShown = false; })
    }
  }

  build() {
    Column() {
      SectionLabel({ text: 'Overlays · 浮层' })
      Flex({ wrap: FlexWrap.Wrap }) {
        AppButton({ label: 'Dialog', type: AppButtonType.Primary })
          .margin({ right: Token.space.xs, bottom: Token.space.xs })
          .onClick((): void => { this.dialogController.open(); })

        AppButton({ label: 'Toast', type: AppButtonType.Secondary })
          .margin({ right: Token.space.xs, bottom: Token.space.xs })
          .onClick((): void => { AppToast.show('这是一条轻提示 Toast'); })

        AppButton({ label: 'BottomSheet', type: AppButtonType.Secondary })
          .margin({ right: Token.space.xs, bottom: Token.space.xs })
          .onClick((): void => { this.sheetShown = true; })

        // 系统菜单（原生 bindMenu）
        Text('Menu ▾')
          .fontSize(Token.font.label.size)
          .fontColor(Token.color.primary())
          .height(40)
          .padding({ left: Token.space.md, right: Token.space.md })
          .borderRadius(Token.radius.sm)
          .border({ width: 1, color: Token.color.outline() })
          .bindMenu([
            { value: '编辑', action: (): void => { AppToast.show('编辑'); } },
            { value: '分享', action: (): void => { AppToast.show('分享'); } },
            { value: '删除', action: (): void => { AppToast.show('删除'); } }
          ])
      }
      .width('100%')
      .bindSheet($$this.sheetShown, this.sheetBuilder(), {
        detents: [SheetSize.MEDIUM],
        backgroundColor: Token.color.surface(),
        showClose: false
      })

      // AppMenu 面板样式
      SectionLabel({ text: 'Menu · 菜单面板样式' })
      AppMenu({ items: this.menuItems })
        .margin({ bottom: Token.space.md })

      // AppPopover 气泡样式
      SectionLabel({ text: 'Popover · 气泡样式' })
      AppPopover({ title: '提示', text: '气泡浮层用于承载少量说明或操作，最大宽 240。' })
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .margin({ bottom: Token.space.lg })
  }
}

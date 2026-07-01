import { Token, AppDialog, AppButton, AppButtonType, AppSheet, AppMenu, AppMenuItem, AppPopover, AppToast } from '@riclava/designsystem';
import { SectionLabel } from './Widgets';

@Component
export struct OverlaysSection {
  @StorageLink('isDark') isDark: boolean = false;
  @StorageProp('compact') compact: boolean = false;
  @State sheetShown: boolean = false;

  private triggerTouch(): number {
    return Math.max(Token.size.buttonMedium(this.compact), Token.size.minTouch);
  }

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
      AppButton({
        label: '关闭',
        type: AppButtonType.Secondary,
        onClickAction: (): void => { this.sheetShown = false; }
      })
    }
  }

  build() {
    Column() {
      SectionLabel({ text: 'Overlays · 浮层' })
      Flex({ wrap: FlexWrap.Wrap }) {
        AppButton({
          label: 'Dialog',
          type: AppButtonType.Primary,
          onClickAction: (): void => { this.dialogController.open(); }
        })
          .margin({ right: Token.space.xs, bottom: Token.space.xs })

        AppButton({
          label: 'Toast',
          type: AppButtonType.Secondary,
          onClickAction: (): void => { AppToast.show('这是一条轻提示 Toast'); }
        })
          .margin({ right: Token.space.xs, bottom: Token.space.xs })

        AppButton({
          label: 'BottomSheet',
          type: AppButtonType.Secondary,
          onClickAction: (): void => { this.sheetShown = true; }
        })
          .margin({ right: Token.space.xs, bottom: Token.space.xs })

        // 系统菜单（原生 bindMenu；弹层密度由系统控制，触发器与同行按钮同规格随 compact 收紧）
        Text('Menu ▾')
          .fontSize(Token.font.label.size)
          .fontColor(Token.color.primary())
          .height(Token.size.buttonMedium(this.compact))
          .padding({ left: Token.space.md, right: Token.space.md })
          .borderRadius(Token.radius.sm)
          .border({ width: 1, color: Token.color.outline() })
          .responseRegion({ x: 0, y: (Token.size.buttonMedium(this.compact) - this.triggerTouch()) / 2, width: '100%', height: this.triggerTouch() })
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

      // AppMenu 面板样式（应用内菜单，随 compact 收紧）
      SectionLabel({ text: 'Menu · 应用内菜单面板（随 compact 收紧）' })
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

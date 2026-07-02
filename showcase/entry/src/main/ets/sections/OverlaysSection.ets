import { Token, AppDialog, AppButton, AppButtonType, AppSheet, AppMenu, AppMenuItem, AppPopover, AppToast } from '@riclava/designsystem';
import { LengthMetrics } from '@kit.ArkUI';
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
    new AppMenuItem($r('app.string.menu_edit'), (): void => { AppToast.show($r('app.string.menu_edit')); }),
    new AppMenuItem($r('app.string.menu_share'), (): void => { AppToast.show($r('app.string.menu_share')); }),
    new AppMenuItem($r('app.string.menu_delete'), (): void => { AppToast.show($r('app.string.menu_delete')); }, true)
  ];

  dialogController: CustomDialogController = new CustomDialogController({
    builder: AppDialog({
      title: $r('app.string.dialog_delete_title'),
      message: $r('app.string.dialog_delete_message'),
      confirmLabel: $r('app.string.menu_delete'),
      confirm: (): void => { AppToast.show($r('app.string.toast_deleted')); }
    }),
    customStyle: true,
    alignment: DialogAlignment.Center
  });

  @Builder
  sheetBuilder() {
    AppSheet({ title: $r('app.string.sheet_title') }) {
      Text($r('app.string.sheet_body'))
        .fontSize(Token.font.bodySmall.size)
        .fontColor(Token.color.onSurfaceVariant())
        .margin({ bottom: Token.space.lg })
      AppButton({
        label: $r('app.string.sheet_close'),
        type: AppButtonType.Secondary,
        onClickAction: (): void => { this.sheetShown = false; }
      })
    }
  }

  build() {
    Column() {
      SectionLabel({ text: $r('app.string.sec_overlays') })
      Flex({ wrap: FlexWrap.Wrap }) {
        AppButton({
          label: 'Dialog',
          type: AppButtonType.Primary,
          onClickAction: (): void => { this.dialogController.open(); }
        })
          .margin({ end: LengthMetrics.vp(Token.space.xs), bottom: Token.space.xs })

        AppButton({
          label: 'Toast',
          type: AppButtonType.Secondary,
          onClickAction: (): void => { AppToast.show($r('app.string.overlay_toast')); }
        })
          .margin({ end: LengthMetrics.vp(Token.space.xs), bottom: Token.space.xs })

        AppButton({
          label: 'BottomSheet',
          type: AppButtonType.Secondary,
          onClickAction: (): void => { this.sheetShown = true; }
        })
          .margin({ end: LengthMetrics.vp(Token.space.xs), bottom: Token.space.xs })

        // 系统菜单（原生 bindMenu；弹层密度由系统控制，触发器与同行按钮同规格随 compact 收紧）
        Text('Menu ▾')
          .fontSize(Token.font.label.size)
          .fontColor(Token.color.primary())
          .height(Token.size.buttonMedium(this.compact))
          .padding({ start: LengthMetrics.vp(Token.space.md), end: LengthMetrics.vp(Token.space.md) })
          .borderRadius(Token.radius.sm)
          .border({ width: 1, color: Token.color.outline() })
          .responseRegion({ x: 0, y: (Token.size.buttonMedium(this.compact) - this.triggerTouch()) / 2, width: '100%', height: this.triggerTouch() })
          .bindMenu([
            { value: $r('app.string.menu_edit'), action: (): void => { AppToast.show($r('app.string.menu_edit')); } },
            { value: $r('app.string.menu_share'), action: (): void => { AppToast.show($r('app.string.menu_share')); } },
            { value: $r('app.string.menu_delete'), action: (): void => { AppToast.show($r('app.string.menu_delete')); } }
          ])
      }
      .width('100%')
      .bindSheet($$this.sheetShown, this.sheetBuilder(), {
        detents: [SheetSize.MEDIUM],
        backgroundColor: Token.color.surface(),
        showClose: false
      })

      // AppMenu 面板样式（应用内菜单，随 compact 收紧）
      SectionLabel({ text: $r('app.string.sec_menu_panel') })
      AppMenu({ items: this.menuItems })
        .margin({ bottom: Token.space.md })

      // AppPopover 气泡样式
      SectionLabel({ text: $r('app.string.sec_popover') })
      AppPopover({ title: $r('app.string.popover_title'), text: $r('app.string.popover_text') })
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .margin({ bottom: Token.space.lg })
  }
}

import { Density, Token, AppDialog, AppButton, AppButtonType, AppSheet, AppMenu, AppMenuItem, AppPopover, AppToast } from '@riclava/designsystem';
import { LengthMetrics } from '@kit.ArkUI';
import { DemoBlock, SectionLabel } from './Widgets';

@Component
export struct OverlaysSection {
  @StorageLink('isDark') isDark: boolean = false;
  @StorageLink('brand') brand: string = 'default';
  @StorageProp('density') density: Density = Density.Comfortable;
  @State sheetShown: boolean = false;

  private triggerTouch(): number {
    return Math.max(Token.size.buttonMedium(this.density), Token.size.minTouch);
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
        .fontSize(Token.font.bodySmall.sizeFor(this.density))
        .lineHeight(Token.font.bodySmall.lineHeightFor(this.density))
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
      DemoBlock({ title: $r('app.string.sec_overlay_triggers') }) {
        Flex({ wrap: FlexWrap.Wrap }) {
          AppButton({
            label: $r('app.string.demo_overlay_dialog'),
            type: AppButtonType.Primary,
            onClickAction: (): void => { this.dialogController.open(); }
          })
            .margin({ end: LengthMetrics.vp(Token.space.xs), bottom: Token.space.xs })

          AppButton({
            label: $r('app.string.demo_overlay_toast'),
            type: AppButtonType.Secondary,
            onClickAction: (): void => { AppToast.show($r('app.string.overlay_toast')); }
          })
            .margin({ end: LengthMetrics.vp(Token.space.xs), bottom: Token.space.xs })

          AppButton({
            label: $r('app.string.demo_overlay_sheet'),
            type: AppButtonType.Secondary,
            onClickAction: (): void => { this.sheetShown = true; }
          })
            .margin({ end: LengthMetrics.vp(Token.space.xs), bottom: Token.space.xs })

          // 系统菜单（原生 bindMenu；弹层密度由系统控制，触发器与同行按钮同规格随 compact 收紧）
          Text($r('app.string.demo_overlay_menu'))
            .fontSize(Token.font.label.sizeFor(this.density))
            .lineHeight(Token.font.label.lineHeightFor(this.density))
            .fontColor(Token.color.primary(this.brand))
            .height(Token.size.buttonMedium(this.density))
            .padding({ start: LengthMetrics.vp(Token.space.md), end: LengthMetrics.vp(Token.space.md) })
            .borderRadius(Token.radius.sm)
            .border({ width: 1, color: Token.color.outline() })
            .responseRegion({
              x: 0,
              y: (Token.size.buttonMedium(this.density) - this.triggerTouch()) / 2,
              width: '100%',
              height: this.triggerTouch()
            })
            .bindMenu([
              { value: $r('app.string.menu_edit'), action: (): void => { AppToast.show($r('app.string.menu_edit')); } },
              { value: $r('app.string.menu_share'), action: (): void => { AppToast.show($r('app.string.menu_share')); } },
              { value: $r('app.string.menu_delete'), action: (): void => { AppToast.show($r('app.string.menu_delete')); } }
            ])
        }
        .width('100%')
      }

      // AppMenu 面板样式（应用内菜单，随 compact 收紧）
      DemoBlock({ title: $r('app.string.sec_menu_panel') }) {
        AppMenu({ items: this.menuItems })
      }

      // AppPopover 气泡样式
      DemoBlock({ title: $r('app.string.sec_popover') }) {
        Stack({ alignContent: Alignment.TopStart }) {
          Column() {
            Text($r('app.string.popover_canvas_hint'))
              .fontSize(Token.font.caption.sizeFor(this.density))
              .fontColor(Token.color.onSurfaceVariant())
          }
          .width('100%')
          .height(Token.size.rowMin(this.density) + Token.space.xxxl)
          .justifyContent(FlexAlign.End)
          .alignItems(HorizontalAlign.End)
          .padding(Token.space.sm)
          .backgroundColor(Token.color.background())
          .borderRadius(Token.radius.sm)
          .border({ width: 1, color: Token.color.divider() })
          AppPopover({ title: $r('app.string.popover_title'), text: $r('app.string.popover_text') })
            .margin({ start: LengthMetrics.vp(Token.space.sm), top: Token.space.sm })
        }
        .width('100%')
      }
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .margin({ bottom: Token.space.lg })
    .bindSheet($$this.sheetShown, this.sheetBuilder(), {
      detents: [SheetSize.MEDIUM],
      backgroundColor: Token.color.surface(),
      showClose: false
    })
  }
}

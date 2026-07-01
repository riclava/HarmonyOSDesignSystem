import { promptAction } from '@kit.ArkUI';
import { Token } from '../designsystem/Tokens';
import { SectionLabel } from './Widgets';
import { AppDialog } from '../designsystem/components/AppDialog';
import { AppButton, AppButtonType } from '../designsystem/components/AppButton';

@Component
export struct OverlaysSection {
  @StorageLink('isDark') isDark: boolean = false;
  @State sheetShown: boolean = false;

  dialogController: CustomDialogController = new CustomDialogController({
    builder: AppDialog({
      title: '删除确认',
      message: '删除后不可恢复，确定继续吗？',
      confirmLabel: '删除',
      confirm: () => {
        promptAction.showToast({ message: '已删除', duration: 2000 });
      }
    }),
    customStyle: true,
    alignment: DialogAlignment.Center
  });

  @Builder
  sheetContent() {
    Column() {
      // 拖拽条
      Row()
        .width(32).height(4)
        .backgroundColor(Token.color.outline())
        .borderRadius(Token.radius.full)
        .margin({ bottom: Token.space.md })
      Text('BottomSheet 底部面板')
        .fontSize(Token.font.titleLarge.size)
        .fontWeight(Token.font.titleLarge.weight)
        .fontColor(Token.color.onSurface())
      Text('顶部圆角 RadiusXL、拖拽条、Level4 阴影，支持下拉关闭。')
        .fontSize(Token.font.bodySmall.size)
        .fontColor(Token.color.onSurfaceVariant())
        .margin({ top: Token.space.xs })
      AppButton({ label: '关闭', type: AppButtonType.Secondary })
        .margin({ top: Token.space.lg })
        .onClick(() => { this.sheetShown = false; })
    }
    .width('100%')
    .padding(Token.space.lg)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(Token.color.surface())
  }

  build() {
    Column() {
      SectionLabel({ text: 'Overlays · 浮层' })
      Flex({ wrap: FlexWrap.Wrap }) {
        // Dialog
        AppButton({ label: 'Dialog', type: AppButtonType.Primary })
          .margin({ right: Token.space.xs, bottom: Token.space.xs })
          .onClick(() => { this.dialogController.open(); })

        // Toast
        AppButton({ label: 'Toast', type: AppButtonType.Secondary })
          .margin({ right: Token.space.xs, bottom: Token.space.xs })
          .onClick(() => {
            promptAction.showToast({ message: '这是一条轻提示 Toast', duration: 2000 });
          })

        // BottomSheet
        AppButton({ label: 'BottomSheet', type: AppButtonType.Secondary })
          .margin({ right: Token.space.xs, bottom: Token.space.xs })
          .onClick(() => { this.sheetShown = true; })

        // Menu
        Text('Menu ▾')
          .fontSize(Token.font.label.size)
          .fontColor(Token.color.primary())
          .height(40)
          .padding({ left: Token.space.md, right: Token.space.md })
          .borderRadius(Token.radius.sm)
          .border({ width: 1, color: Token.color.outline() })
          .bindMenu([
            { value: '编辑', action: () => promptAction.showToast({ message: '编辑' }) },
            { value: '分享', action: () => promptAction.showToast({ message: '分享' }) },
            { value: '删除', action: () => promptAction.showToast({ message: '删除' }) },
          ])
      }
      .width('100%')
      // 绑定底部面板
      .bindSheet($$this.sheetShown, this.sheetContent(), {
        detents: [SheetSize.MEDIUM],
        backgroundColor: Token.color.surface(),
        showClose: false
      })
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .margin({ bottom: Token.space.lg })
  }
}

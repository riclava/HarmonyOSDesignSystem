import promptAction from '@ohos.promptAction';
import { BusinessError } from '@kit.BasicServicesKit';

/**
 * 轻提示：对 promptAction.openToast 的封装。非阻断、无按钮。
 * 时长：短 2s / 长 3.5s。
 */
export class AppToast {
  static show(message: ResourceStr, durationMs: number = 2000): void {
    promptAction.openToast({ message: message, duration: durationMs }).catch((err: BusinessError) => {
      const e = err as BusinessError;
      console.error(`AppToast failed: ${e.code}, ${e.message}`);
    });
  }

  static showLong(message: ResourceStr): void {
    AppToast.show(message, 3500);
  }
}

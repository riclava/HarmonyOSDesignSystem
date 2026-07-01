import { promptAction } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';

/**
 * 轻提示：对 promptAction.showToast 的封装。非阻断、无按钮。
 * 时长：短 2s / 长 3.5s。
 */
export class AppToast {
  static show(message: string, durationMs: number = 2000): void {
    try {
      promptAction.showToast({ message: message, duration: durationMs });
    } catch (err) {
      const e = err as BusinessError;
      console.error(`AppToast failed: ${e.code}, ${e.message}`);
    }
  }

  static showLong(message: string): void {
    AppToast.show(message, 3500);
  }
}

import { AbilityConstant, ConfigurationConstant, Configuration, UIAbility, Want } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';
import { initColorMode } from '@riclava/designsystem';

export default class EntryAbility extends UIAbility {
  onCreate(_want: Want, _launchParam: AbilityConstant.LaunchParam): void {
    // 启动时按系统深浅色初始化
    initColorMode(this.context.config.colorMode ?? ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET);
  }

  onConfigurationUpdate(newConfig: Configuration): void {
    // 系统深浅色变化，或 App 内 setColorMode 触发时同步 isDark，并驱动全量重绘
    initColorMode(newConfig.colorMode ?? ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET);
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        console.error(`Failed to load content. Cause: ${JSON.stringify(err)}`);
      }
    });
  }
}

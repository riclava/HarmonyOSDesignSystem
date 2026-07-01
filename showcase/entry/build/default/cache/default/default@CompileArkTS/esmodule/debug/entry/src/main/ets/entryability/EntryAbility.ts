import type AbilityConstant from "@ohos:app.ability.AbilityConstant";
import ConfigurationConstant from "@ohos:app.ability.ConfigurationConstant";
import type { Configuration } from "@ohos:app.ability.Configuration";
import UIAbility from "@ohos:app.ability.UIAbility";
import type Want from "@ohos:app.ability.Want";
import type window from "@ohos:window";
import { initColorMode } from "@bundle:com.riclava.dsshowcase/entry/ets/designsystem/Tokens";
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

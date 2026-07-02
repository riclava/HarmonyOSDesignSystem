import { Token } from '@riclava/designsystem';
import { common, ConfigurationConstant } from '@kit.AbilityKit';
import { LengthMetrics } from '@kit.ArkUI';
import { ColorSection } from '../sections/ColorSection';
import { TypographySection } from '../sections/TypographySection';
import { SpacingSection } from '../sections/SpacingSection';
import { RadiusSection } from '../sections/RadiusSection';
import { ShadowSection } from '../sections/ShadowSection';
import { IconSection } from '../sections/IconSection';
import { MotionSection } from '../sections/MotionSection';
import { ComponentsSection } from '../sections/ComponentsSection';
import { FormSection } from '../sections/FormSection';
import { DataDisplaySection } from '../sections/DataDisplaySection';
import { OverlaysSection } from '../sections/OverlaysSection';
import { StatesSection } from '../sections/StatesSection';
import { AdaptiveSection } from '../sections/AdaptiveSection';
import { NavigationSection } from '../sections/NavigationSection';
import { PickersSection } from '../sections/PickersSection';

/** 可滚动页容器：统一内边距 + 关闭滚动条。内容通过 @BuilderParam 注入。 */
@Component
struct ScrollPage {
  @StorageLink('isDark') isDark: boolean = false;
  @BuilderParam content: () => void;

  build() {
    Scroll() {
      Column() {
        this.content()
      }
      .width('100%')
      .padding({
        start: LengthMetrics.vp(Token.space.md),
        end: LengthMetrics.vp(Token.space.md),
        top: LengthMetrics.vp(Token.space.lg),
        bottom: LengthMetrics.vp(Token.space.xxl)
      })
    }
    .scrollBar(BarState.Off)
    .align(Alignment.TopStart)
    .width('100%')
    .height('100%')
  }
}

@Entry
@Component
struct Index {
  // 全局深浅色开关，写入 AppStorage 后所有 Token 联动刷新
  @StorageLink('isDark') isDark: boolean = false;
  // 全局密度开关，组件通过 @StorageProp('compact') 联动收紧尺寸
  @StorageLink('compact') compact: boolean = false;
  @State activeTab: number = 0;

  @Builder
  TopBar() {
    Row() {
      Text('Design System')
        .fontSize(Token.font.titleLarge.size)
        .fontWeight(Token.font.titleLarge.weight)
        .fontColor(Token.color.onSurface())
        .layoutWeight(1)

      Text('紧凑')
        .fontSize(Token.font.caption.size)
        .fontColor(this.compact ? Token.color.primary() : Token.color.onSurfaceVariant())
        .margin({ end: LengthMetrics.vp(Token.space.xxs) })
      Toggle({ type: ToggleType.Switch, isOn: this.compact })
        .selectedColor(Token.color.primary())
        .margin({ end: LengthMetrics.vp(Token.space.md) })
        .onChange((on: boolean) => { this.compact = on; })

      Text(this.isDark ? '🌙' : '☀️')
        .fontSize(Token.font.body.size)
        .margin({ end: LengthMetrics.vp(Token.space.xxs) })
      Toggle({ type: ToggleType.Switch, isOn: this.isDark })
        .selectedColor(Token.color.primary())
        .onChange((on: boolean) => {
          this.isDark = on;
          // 切换 App 级色彩模式，触发配置变更 → 全量重绘，令所有 Token 颜色重新求值
          const ctx = this.getUIContext().getHostContext() as common.UIAbilityContext;
          ctx.getApplicationContext()
            .setColorMode(on
              ? ConfigurationConstant.ColorMode.COLOR_MODE_DARK
              : ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT);
        })
    }
    .width('100%')
    .height(Token.size.rowMin(false))
    .padding({ start: LengthMetrics.vp(Token.space.md), end: LengthMetrics.vp(Token.space.md) })
    .backgroundColor(Token.color.surface())
  }

  @Builder
  Foundation() {
    ScrollPage() {
      ColorSection()
      TypographySection()
      SpacingSection()
      RadiusSection()
      ShadowSection()
      IconSection()
      MotionSection()
    }
  }

  @Builder
  Components() {
    ScrollPage() {
      ComponentsSection()
      FormSection()
      DataDisplaySection()
      NavigationSection()
    }
  }

  build() {
    Column() {
      this.TopBar()
      Tabs({ index: this.activeTab }) {
        TabContent() { this.Foundation() }.tabBar(this.tabItem('Foundation', 0))
        TabContent() { this.Components() }.tabBar(this.tabItem('Components', 1))
        TabContent() { ScrollPage() { OverlaysSection() } }.tabBar(this.tabItem('Overlays', 2))
        TabContent() { ScrollPage() { PickersSection() } }.tabBar(this.tabItem('Pickers', 3))
        TabContent() { ScrollPage() { StatesSection() } }.tabBar(this.tabItem('States', 4))
        TabContent() { ScrollPage() { AdaptiveSection() } }.tabBar(this.tabItem('Adaptive', 5))
      }
      .barPosition(BarPosition.Start)
      .barMode(BarMode.Scrollable)
      .onChange((i: number) => { this.activeTab = i; })
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Token.color.background())
  }

  @Builder
  tabItem(label: string, index: number) {
    Text(label)
      .fontSize(Token.font.label.size)
      .fontWeight(this.activeTab === index ? Token.font.label.weight : Token.font.caption.weight)
      .fontColor(this.activeTab === index ? Token.color.primary() : Token.color.onSurfaceVariant())
      .padding(Token.space.sm)
  }
}

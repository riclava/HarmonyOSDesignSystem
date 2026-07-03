import { Token, Density } from '@riclava/designsystem';
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
import { ExtrasSection } from '../sections/ExtrasSection';
import { ShowcaseSettingsStore } from '../state/ShowcaseSettingsStore';

/** 可滚动页容器：统一内边距 + 关闭滚动条。内容通过 @BuilderParam 注入。 */
@Component
struct ScrollPage {
  @StorageLink('isDark') isDark: boolean = false;
  @StorageLink('brand') brand: string = 'default';
  @StorageProp('density') density: Density = Density.Comfortable;
  @BuilderParam content: () => void;

  private padStart(): number {
    return this.density === Density.Comfortable ? Token.space.md : Token.space.sm;
  }

  private padTop(): number {
    return this.density === Density.Comfortable ? Token.space.lg : Token.space.md;
  }

  build() {
    Scroll() {
      Column() {
        this.content()
      }
      .width('100%')
      .padding({
        start: LengthMetrics.vp(this.padStart()),
        end: LengthMetrics.vp(this.padStart()),
        top: LengthMetrics.vp(this.padTop()),
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
  @StorageLink('brand') brand: string = 'default';
  // 全局密度：组件通过 @StorageProp('density') 联动收紧尺寸/字号（舒适 / 紧凑 / 超紧凑）
  @StorageLink('density') density: Density = Density.Comfortable;
  @State activeTab: number = 0;
  // 应用内语言：true 表示已切到英文（覆盖系统语言）
  @State prefersEnglish: boolean = false;

  aboutToAppear(): void {
    this.prefersEnglish = ShowcaseSettingsStore.prefersEnglish();
  }

  // 在中文 / 英文之间切换应用首选语言，触发配置更新 → 资源随语言重新求值
  private toggleLanguage(): void {
    const next: boolean = !this.prefersEnglish;
    ShowcaseSettingsStore.saveLanguage(this.hostContext(), next ? 'en-US' : 'zh-Hans');
    this.prefersEnglish = next;
  }

  private hostContext(): common.UIAbilityContext {
    return this.getUIContext().getHostContext() as common.UIAbilityContext;
  }

  private topBarPadY(): number {
    return this.density === Density.Comfortable ? Token.space.sm : Token.space.xs;
  }

  @Builder
  TopBar() {
    Column({ space: this.density === Density.Comfortable ? Token.space.xs : Token.space.xxs }) {
      Row() {
        Text($r('app.string.app_name'))
          .fontSize(Token.font.titleLarge.sizeFor(this.density))
          .lineHeight(Token.font.titleLarge.lineHeightFor(this.density))
          .fontWeight(Token.font.titleLarge.weight)
          .fontColor(Token.color.onSurface())
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .layoutWeight(1)

        // 品牌切换（蓝 / 紫），写入 @StorageLink('brand') 触发全量重绘
        Text(this.brand === 'violet' ? $r('app.string.brand_violet') : $r('app.string.brand_default'))
          .fontSize(Token.font.label.sizeFor(this.density))
          .lineHeight(Token.font.label.lineHeightFor(this.density))
          .fontWeight(Token.font.label.weight)
          .fontColor(Token.color.primary(this.brand))
          .textAlign(TextAlign.Center)
          .constraintSize({ minWidth: Token.icon.xl })
          .height(Token.size.buttonSmall(this.density))
          .padding({ start: LengthMetrics.vp(Token.space.xs), end: LengthMetrics.vp(Token.space.xs) })
          .borderRadius(Token.radius.sm)
          .border({ width: 1, color: Token.color.outline() })
          .margin({ end: LengthMetrics.vp(Token.space.xs) })
          .responseRegion({
            x: 0,
            y: (Token.size.buttonSmall(this.density) - Token.size.minTouch) / 2,
            width: '100%',
            height: Token.size.minTouch
          })
          .accessibilityText($r('app.string.topbar_brand_a11y'))
          .onClick(() => {
            const nextBrand: string = this.brand === 'violet' ? 'default' : 'violet';
            ShowcaseSettingsStore.saveBrand(this.hostContext(), nextBrand);
            this.brand = nextBrand;
          })

        // 应用内语言切换（中 / EN），命中区兜底到 44×44
        Text(this.prefersEnglish ? 'EN' : '中')
          .fontSize(Token.font.label.sizeFor(this.density))
          .lineHeight(Token.font.label.lineHeightFor(this.density))
          .fontWeight(Token.font.label.weight)
          .fontColor(Token.color.primary(this.brand))
          .textAlign(TextAlign.Center)
          .constraintSize({ minWidth: Token.icon.xl })
          .height(Token.size.buttonSmall(this.density))
          .padding({ start: LengthMetrics.vp(Token.space.xs), end: LengthMetrics.vp(Token.space.xs) })
          .borderRadius(Token.radius.sm)
          .border({ width: 1, color: Token.color.outline() })
          .responseRegion({
            x: 0,
            y: (Token.size.buttonSmall(this.density) - Token.size.minTouch) / 2,
            width: '100%',
            height: Token.size.minTouch
          })
          .accessibilityText($r('app.string.topbar_language_a11y'))
          .onClick(() => { this.toggleLanguage(); })
      }
      .width('100%')
      .constraintSize({ minHeight: Token.size.minTouch })

      Row() {
        // 密度三档切换（舒适 / 紧凑 / 超紧凑），写入 @StorageLink('density') 联动全量重绘
        Row() {
          Text($r('app.string.topbar_density'))
            .fontSize(Token.font.caption.sizeFor(this.density))
            .lineHeight(Token.font.caption.lineHeightFor(this.density))
            .fontColor(Token.color.onSurfaceVariant())
            .margin({ end: LengthMetrics.vp(Token.space.xs) })
          this.densityChip($r('app.string.density_comfortable'), Density.Comfortable)
          this.densityChip($r('app.string.density_compact'), Density.Compact)
          this.densityChip($r('app.string.density_super'), Density.SuperCompact)
        }
        .layoutWeight(1)
        .constraintSize({ minHeight: Token.size.minTouch })
        .alignItems(VerticalAlign.Center)

        Row() {
          Text($r('app.string.topbar_dark'))
            .fontSize(Token.font.caption.sizeFor(this.density))
            .lineHeight(Token.font.caption.lineHeightFor(this.density))
            .fontColor(this.isDark ? Token.color.primary(this.brand) : Token.color.onSurfaceVariant())
            .margin({ end: LengthMetrics.vp(Token.space.xxs) })
          Toggle({ type: ToggleType.Switch, isOn: this.isDark })
            .selectedColor(Token.color.primary(this.brand))
            .onChange((on: boolean) => {
              const ctx = this.hostContext();
              this.isDark = on;
              ShowcaseSettingsStore.saveDarkMode(ctx, on);
              // 切换 App 级色彩模式，触发配置变更 → 全量重绘，令所有 Token 颜色重新求值
              ctx.getApplicationContext()
                .setColorMode(on
                  ? ConfigurationConstant.ColorMode.COLOR_MODE_DARK
                  : ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT);
            })
        }
        .constraintSize({ minHeight: Token.size.minTouch })
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
    }
    .width('100%')
    .padding({
      start: LengthMetrics.vp(Token.space.md),
      end: LengthMetrics.vp(Token.space.md),
      top: LengthMetrics.vp(this.topBarPadY()),
      bottom: LengthMetrics.vp(this.topBarPadY())
    })
    .backgroundColor(Token.color.surface())
  }

  @Builder
  densityChip(label: ResourceStr, value: Density) {
    Text(label)
      .fontSize(Token.font.caption.sizeFor(this.density))
      .lineHeight(Token.font.caption.lineHeightFor(this.density))
      .fontWeight(this.density === value ? Token.font.label.weight : Token.font.caption.weight)
      .fontColor(this.density === value ? Token.color.onPrimary(this.brand) : Token.color.onSurfaceVariant())
      .textAlign(TextAlign.Center)
      .constraintSize({ minWidth: Token.size.buttonLarge(this.density) })
      .height(Token.size.buttonSmall(this.density))
      .padding({ start: LengthMetrics.vp(Token.space.xs), end: LengthMetrics.vp(Token.space.xs) })
      .borderRadius(Token.radius.sm)
      .backgroundColor(this.density === value ? Token.color.primary(this.brand) : Token.color.surface())
      .border({ width: 1, color: this.density === value ? Token.color.primary(this.brand) : Token.color.outline() })
      .margin({ end: LengthMetrics.vp(Token.space.xxs) })
      .responseRegion({
        x: 0,
        y: (Token.size.buttonSmall(this.density) - Token.size.minTouch) / 2,
        width: '100%',
        height: Token.size.minTouch
      })
      .onClick(() => {
        this.density = value;
        ShowcaseSettingsStore.saveDensity(this.hostContext(), value);
      })
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
      ExtrasSection()
    }
  }

  build() {
    Column() {
      this.TopBar()
      Tabs({ index: this.activeTab }) {
        TabContent() { this.Foundation() }.tabBar(this.tabItem($r('app.string.tab_foundation'), 0))
        TabContent() { this.Components() }.tabBar(this.tabItem($r('app.string.tab_components'), 1))
        TabContent() { ScrollPage() { OverlaysSection() } }.tabBar(this.tabItem($r('app.string.tab_overlays'), 2))
        TabContent() { ScrollPage() { PickersSection() } }.tabBar(this.tabItem($r('app.string.tab_pickers'), 3))
        TabContent() { ScrollPage() { StatesSection() } }.tabBar(this.tabItem($r('app.string.tab_states'), 4))
        TabContent() { ScrollPage() { AdaptiveSection() } }.tabBar(this.tabItem($r('app.string.tab_adaptive'), 5))
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
  tabItem(label: ResourceStr, index: number) {
    Text(label)
      .fontSize(Token.font.label.sizeFor(this.density))
      .lineHeight(Token.font.label.lineHeightFor(this.density))
      .fontWeight(this.activeTab === index ? Token.font.label.weight : Token.font.caption.weight)
      .fontColor(this.activeTab === index ? Token.color.primary(this.brand) : Token.color.onSurfaceVariant())
      .maxLines(1)
      .textOverflow({ overflow: TextOverflow.Ellipsis })
      .padding(this.density === Density.Comfortable ? Token.space.sm : Token.space.xs)
  }
}

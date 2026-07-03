---
inclusion: always
---

# HarmonyOS Design System — Kiro 使用规则

在本仓库（及任何拷贝此 steering 的项目）中生成 ArkUI 代码时，遵守以下规则。

## 黄金法则

所有颜色 / 字号 / 行高 / 字重 / 间距 / 圆角 / 阴影 / 动画时长必须来自 `Token`，禁止硬编码。

```ts
import { Token } from '@riclava/designsystem';
Text('标题')
  .fontSize(Token.font.titleMedium.size)
  .fontColor(Token.color.primary())
  .padding(Token.space.md)
```

## Token 引用方式

- 颜色：`Token.color.primary()`（函数调用，返回随深浅色切换）
- 字体：`Token.font.body.size / .lineHeight / .weight`
- 间距：`Token.space.md`（4 的倍数）
- 圆角：`Token.radius.md`
- 图标：`Token.icon.md`（默认 24）
- 阴影：`Token.shadow.level1`
- 动画：`Token.motion.normal` + `Token.motion.easeOut`

## 组件优先

需要 UI 时先用现成组件（全部从 `@riclava/designsystem` 导入）：

- 基础：`AppButton`（含 `loading`）`AppCard`（含 `clickable`）`AppTag` `AppBadge` `AppAvatar` `AppDivider` `AppChipGroup`
- 表单：`AppTextField` `AppSearch` `AppSwitch` `AppCheckbox` `AppRadioGroup` `AppSlider` `AppProgress` `AppSelect` `AppStepper` `AppSegmented` `AppRating` `AppUpload` `AppFormItem`
- 导航/列表：`AppTabs` `AppListItem` `AppNavBar` `AppBreadcrumb` `AppPagination` `AppSteps`
- 数据展示：`AppTable` `AppAccordion` `AppTree` `AppSwiper`
- 浮层/反馈：`AppDialog` `AppMenu` `AppSheet` `AppPopover` `AppTooltip` `AppToast`
- 选择器：`AppDatePicker` `AppTimePicker` `AppCalendar`
- 状态：`StateView` `Skeleton`

## 硬性约束

1. 深浅色只靠 Token；组件持有 `@StorageLink('isDark') isDark: boolean` 与 `@StorageLink('brand') brand: string`（多品牌换肤，见 `docs/19-theming.md`）；跟随系统在 Ability 调 `initColorMode(config.colorMode)`，多品牌用 `initTheme(brandId, config.colorMode)`。
2. 密度：三档 `Density`（`Comfortable` / `Compact` / `SuperCompact`），数据密集/超密集场景用 `setDensity(Density.Compact)` 或 `setDensity(Density.SuperCompact)`（旧布尔用 `setCompact(true)` 兼容）。组件持有 `@StorageProp('density') density: Density = Density.Comfortable`，尺寸走 `Token.size.*(this.density)`、字体走 `Token.font.*.sizeFor(this.density)`，且在 build 里直接引用 `this.density`；命中区用 `.responseRegion` 兜底到 44；逐档收紧尺寸/内边距/字号行高，不动圆角、颜色。
3. 可交互命中区 ≥ 44×44vp；图标按钮加 `.accessibilityText(...)`；信息不只靠颜色。
4. 一屏一个 Primary 行动；破坏性操作用 `Danger` + 二次确认。
5. 动画 ≤ 400ms，进 easeOut / 出 easeIn。
6. 国际化：面向用户的文案走 `$r('app.string.*')`；内边距/外边距用逻辑方向 `start/end`（`LengthMetrics.vp(...)`），禁用物理 `left/right`；文本对齐用 `TextAlign.Start/End`；日期时间数字用标准 `Intl`（`Intl.DateTimeFormat`/`Intl.NumberFormat`）按系统区域格式化；方向性图标用 `isRTL()` 镜像。

## 权威来源

- 完整规范：`docs/01-design-principles.md` ~ `docs/18-internationalization.md`
- Token 单一事实来源（机器可读）：

#[[file:tokens/design-tokens.json]]

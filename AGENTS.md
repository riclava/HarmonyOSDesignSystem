# AGENTS.md — HarmonyOS Design System Rules

> 面向 AI 编码助手（Kiro / Claude / Cursor / Copilot 等）的硬性规则。
> 在本仓库或任何依赖 `@riclava/designsystem` 的项目中生成 ArkUI 代码时，必须遵守。

## 黄金法则

**所有颜色、字号、行高、字重、间距、圆角、阴影、动画时长都必须来自 Token。禁止硬编码。**

```ts
// ❌ 禁止
Text('Hi').fontSize(18).fontColor('#2979FF').padding(16)

// ✅ 正确
import { Token } from '@riclava/designsystem';
Text('Hi')
  .fontSize(Token.font.titleMedium.size)
  .fontColor(Token.color.primary())
  .padding(Token.space.md)
```

## Token 速查

| 类别 | 引用方式 | 可选值 |
| --- | --- | --- |
| 颜色 | `Token.color.X()` | primary, primaryContainer, onPrimary, secondary, secondaryContainer, success, warning, danger, info, surface, background, onSurface, onSurfaceVariant, outline, divider, mask, transparent |
| 字体 | `Token.font.X.size / .lineHeight / .weight` | displayLarge, displayMedium, headlineLarge, headlineMedium, titleLarge, titleMedium, body, bodySmall, label, caption |
| 间距 | `Token.space.X` | none, xxs(4), xs(8), sm(12), md(16), lg(24), xl(32), xxl(40), xxxl(48), xxxxl(56), xxxxxl(64) |
| 圆角 | `Token.radius.X` | none, xs(4), sm(8), md(12), lg(16), xl(20), xxl(24), xxxl(32), full(999) |
| 图标 | `Token.icon.X` | xs(16), sm(20), md(24), lg(28), xl(32), xxl(48) |
| 阴影 | `Token.shadow.levelN` | level0..level4（含 radius/color/offsetX/offsetY） |
| 动画 | `Token.motion.X` | instant(100), fast(200), normal(250), slow(300), extraSlow(400), easeStandard, easeOut, easeIn |
| 尺寸 | `Token.size.X(compact)` | buttonLarge/buttonMedium/buttonSmall, field, tabBar, tabLabel, rowMin, menuItem；`minTouch`(44 常量) |

## 组件优先

优先使用现成组件，不要重复造样式：

```ts
import {
  // 基础
  AppButton, AppButtonType, AppButtonSize, AppCard, AppTag, AppTagTone,
  AppBadge, AppAvatar, AppAvatarShape, AppDivider, AppChipGroup,
  // 表单
  AppTextField, AppSearch, AppSwitch, AppCheckbox, AppRadioGroup, AppRadioOption,
  AppSlider, AppProgress, AppProgressKind,
  AppSelect, AppStepper, AppSegmented, AppRating, AppUpload, AppFormItem,
  // 导航 / 列表
  AppTabs, AppListItem, AppNavBar, AppBreadcrumb, AppPagination, AppSteps,
  // 数据展示
  AppTable, AppTableColumn, AppAccordion, AppTree, AppTreeNode, AppSwiper,
  // 浮层 / 反馈
  AppDialog, AppMenu, AppMenuItem, AppSheet, AppPopover, AppToast, AppTooltip,
  // 选择器
  AppDatePicker, AppTimePicker, AppTimePickerMode, AppCalendar,
  // 状态页 / 占位
  StateView, StateKind, Skeleton
} from '@riclava/designsystem';
```

- 按钮 → `AppButton`（type: Primary/Secondary/Text/Danger；支持 `loading`）
- 容器 → `AppCard`（`clickable` 可点）；分割 → `AppDivider`（水平/带文字/垂直）
- 标签 → `AppTag`；数字/圆点 → `AppBadge`；头像 → `AppAvatar`；可删标签组 → `AppChipGroup`
- 输入 → `AppTextField`；搜索 → `AppSearch`；下拉 → `AppSelect`；步进 → `AppStepper`
- 开关 → `AppSwitch`；复选 → `AppCheckbox`；单选 → `AppRadioGroup`；分段 → `AppSegmented`
- 滑块 → `AppSlider`；进度 → `AppProgress`（Linear/Ring）；评分 → `AppRating`；上传 → `AppUpload`
- 表单项 → `AppFormItem`（Label + 必填 + 插槽 + Error）
- 分段导航 → `AppTabs`；列表项 → `AppListItem`；顶栏 → `AppNavBar`；面包屑 → `AppBreadcrumb`
- 分页 → `AppPagination`；步骤 → `AppSteps`；表格 → `AppTable`；折叠 → `AppAccordion`；树 → `AppTree`；轮播 → `AppSwiper`
- 弹窗 → `AppDialog`；菜单 → `AppMenu`；底部面板 → `AppSheet`；气泡 → `AppPopover`；提示 → `AppTooltip`；轻提示 → `AppToast.show(...)`
- 日期 → `AppDatePicker`；时间 → `AppTimePicker`；日历 → `AppCalendar`
- 空/错/加载 → `StateView`；加载占位 → `Skeleton`

## 密度 / Compact 模式

面向数据密集型 / 大屏多面板等超复杂应用，可整体收紧控件尺寸、内边距**与字号/行高**（圆角、颜色不变；caption 保持 12 为可读下限）。

- 开启：`AppStorage.setOrCreate('compact', true)`，可随场景实时切换。
- 组件持有 `@StorageProp('compact') compact: boolean`，尺寸统一走 `Token.size.*(this.compact)`。
- 自定义控件必须在 build 里**直接引用 `this.compact`**（作为 `Token.size.*` / `Token.font.*.sizeFor` 的入参），否则切换不会重绘（compact 无系统级触发，不能只靠"持有"）。
- 无障碍：compact 下控件视觉可小于 44，但要用 `.responseRegion(...)` 把命中区兜底到 `Token.size.minTouch`(44)。
- 影响范围：控件高度、内边距、字号/行高（Button / 输入 / 搜索 / Tabs / 列表 / 卡片 / 弹窗 / 标签 / 文案等）；**不动**圆角、颜色。字体取值用 `Token.font.X.sizeFor(this.compact)`。

## 强制约束

1. 深浅色：颜色只用 `Token.color.*`，两套值自动切换。持有 `@StorageLink('isDark') isDark: boolean` 以触发重绘。跟随系统：在 Ability 里调用 `initColorMode(config.colorMode)`。
2. 无障碍：可交互元素命中区 ≥ 44×44vp；图标按钮必须带 `.accessibilityText(...)`；信息不能只靠颜色传达。
3. 一屏一个主行动（Primary），破坏性操作用 `Danger` 色并二次确认。
4. 间距只取 8pt Grid 值（4 的倍数），禁止 13/15/18 等随意数值。
5. 动画总时长 ≤ 400ms，进场用 `easeOut`、退场用 `easeIn`。

## 国际化（i18n）

面向多语言 / RTL 场景，生成代码必须满足：

1. **文案外置**：面向用户的文字不硬编码，走资源 `$r('app.string.xxx')`（组件内置默认文案已资源化）。业务侧新增文案放 `resources/base/element/string.json` 并补 `resources/en_US/.../string.json` 等目标语言。
2. **逻辑方向（RTL）**：内边距 / 外边距禁止用物理 `left/right`，一律用逻辑 `start/end`：
   ```ts
   import { LengthMetrics } from '@kit.ArkUI';
   .padding({ start: LengthMetrics.vp(Token.space.md), end: LengthMetrics.vp(Token.space.md) })
   .margin({ start: LengthMetrics.vp(Token.space.sm) })
   ```
   文本对齐用 `TextAlign.Start / End`（禁用 `Left / Right`）。方向性图标（箭头等）用 `isRTL()` 判定后镜像。
3. **区域化格式**：日期 / 时间 / 数字不手拼字符串，用标准 `Intl.DateTimeFormat` / `Intl.NumberFormat`（省略 locale 走系统默认区域）。日期 / 日历优先用系统 `DatePicker / CalendarPicker`（自带区域化）。注意 `@ohos.intl` 与 `i18n.System.getSystemLocale()` 已废弃，用标准 `Intl`。
4. **判定 RTL**：`import { isRTL } from '@riclava/designsystem'`，仅用于镜像方向性图标；布局镜像由 `start/end` 自动完成，不要手动交换左右。

## 完整规范

详见 `docs/01`~`docs/18`。Token 源：`tokens/design-tokens.json`。国际化见 `docs/18-internationalization.md`。
生成代码前，若不确定取值，先查 `tokens/design-tokens.json` 与 `docs/16-design-token.md`。

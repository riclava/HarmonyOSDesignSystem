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

## 组件优先

优先使用现成组件，不要重复造样式：

```ts
import {
  // 基础
  AppButton, AppButtonType, AppButtonSize, AppCard, AppTag, AppTagTone,
  AppBadge, AppAvatar, AppAvatarShape,
  // 表单
  AppTextField, AppSearch, AppSwitch, AppCheckbox, AppRadioGroup, AppRadioOption,
  AppSlider, AppProgress, AppProgressKind,
  // 导航 / 列表
  AppTabs, AppListItem,
  // 浮层 / 反馈
  AppDialog, AppMenu, AppMenuItem, AppSheet, AppPopover, AppToast,
  // 选择器
  AppDatePicker, AppCalendar,
  // 状态页 / 占位
  StateView, StateKind, Skeleton
} from '@riclava/designsystem';
```

- 按钮 → `AppButton`（type: Primary/Secondary/Text/Danger；支持 `loading`）
- 容器 → `AppCard`（`clickable` 可点）
- 标签 → `AppTag`；数字/圆点 → `AppBadge`；头像 → `AppAvatar`
- 输入 → `AppTextField`；搜索 → `AppSearch`
- 开关 → `AppSwitch`；复选 → `AppCheckbox`；单选 → `AppRadioGroup`
- 滑块 → `AppSlider`；进度 → `AppProgress`（Linear/Ring）
- 分段导航 → `AppTabs`；列表项 → `AppListItem`
- 弹窗 → `AppDialog`；菜单 → `AppMenu`；底部面板 → `AppSheet`；气泡 → `AppPopover`；轻提示 → `AppToast.show(...)`
- 日期 → `AppDatePicker`；日历 → `AppCalendar`
- 空/错/加载 → `StateView`；加载占位 → `Skeleton`

## 强制约束

1. 深浅色：颜色只用 `Token.color.*`，两套值自动切换。持有 `@StorageLink('isDark') isDark: boolean` 以触发重绘。跟随系统：在 Ability 里调用 `initColorMode(config.colorMode)`。
2. 无障碍：可交互元素命中区 ≥ 44×44vp；图标按钮必须带 `.accessibilityText(...)`；信息不能只靠颜色传达。
3. 一屏一个主行动（Primary），破坏性操作用 `Danger` 色并二次确认。
4. 间距只取 8pt Grid 值（4 的倍数），禁止 13/15/18 等随意数值。
5. 动画总时长 ≤ 400ms，进场用 `easeOut`、退场用 `easeIn`。

## 完整规范

详见 `docs/01`~`docs/17`。Token 源：`tokens/design-tokens.json`。
生成代码前，若不确定取值，先查 `tokens/design-tokens.json` 与 `docs/16-design-token.md`。

# 16 Design Token · 设计令牌（核心）

整套规范最重要的一章。**Token 是设计与代码的单一事实来源（Single Source of Truth）。**

ArkUI 只引用 Token，不直接写具体值。配合 Figma Variables，设计稿与代码共享同一套 Token。

## 命名体系

采用三段式：`category.group.variant`，例如 `color.primary`、`space.md`、`radius.md`。

```
Color
├── Primary          ├── Secondary       ├── Success
├── Warning          ├── Error / Danger  ├── Info
├── Surface          ├── Background       ├── Outline
└── OnPrimary / OnSurface ...

Typography
├── Display   ├── Headline  ├── Title
├── Body      ├── Label     └── Caption

Spacing
└── 0 · 4 · 8 · 12 · 16 · 20 · 24 · 32 · 40 · 48

Radius
└── None · XS · SM · MD · LG · XL · Full

Elevation
└── Level0 · Level1 · Level2 · Level3 · Level4

Motion
└── Fast · Normal · Slow · ExtraSlow

Size（控件尺寸，随 Density 三档切换）
└── buttonLarge/Medium/Small · field · tabBar · rowMin · menuItem · avatar · badge · progress · menu/popover · minTouch(44)
```

## 分层：Reference → System → Component

现代设计系统（Material 3 / HarmonyOS）将 Token 分三层：

| 层 | 说明 | 示例 |
| --- | --- | --- |
| **Reference（基础）** | 原始调色板 / 尺寸原子值 | `blue.500 = #126AFF` |
| **System（语义）** | 语义化，业务引用这一层 | `color.primary → blue.500` |
| **Component（组件）** | 组件专属，映射到 System | `button.container → color.primary` |

> 业务代码只引用 **System / Component** 层，永不引用 Reference 层或字面量。

## Token 命名对照

| 类别 | Token 示例 | 值来源 |
| --- | --- | --- |
| 颜色 | `color.primary` / `color.surface` | [02 Color](02-color.md) |
| 字体 | `font.body` / `font.title` | [03 Typography](03-typography.md) |
| 间距 | `space.md` / `space.lg` | [04 Spacing](04-spacing.md) |
| 圆角 | `radius.md` | [05 Radius](05-radius.md) |
| 阴影 | `shadow.level1` | [06 Shadow](06-shadow.md) |
| 动画 | `motion.fast` / `motion.normal` / `motion.slow` | [08 Motion](08-motion.md) |
| 尺寸 | `size.buttonMedium` / `size.field`（随 Density 切换） | 本页「密度 / Density」小节 |

## 密度 / Density（控件尺寸）

面向数据密集型 / 大屏多面板等超复杂应用，提供三档密度 **`Density`**：`Comfortable`（舒适，默认）/ `Compact`（紧凑）/ `SuperCompact`（超紧凑）。逐档收紧控件高度、内边距**与字号/行高**（圆角、颜色始终不变；caption 保持 12 为可读下限）。

> 这里的密度指**信息密度**，与 [15 自适应布局](15-adaptive-layout.md) 里的断点 `Compact`（宽度 < 600vp）无关，两者可组合。

| 尺寸 Token | 舒适 | 紧凑 | 超紧凑 | 用于 |
| --- | --- | --- | --- | --- |
| `size.buttonLarge` | 48 | 40 | 36 | 大按钮高 |
| `size.buttonMedium` | 40 | 32 | 28 | 中按钮高 |
| `size.buttonSmall` | 32 | 28 | 24 | 小按钮高 |
| `size.field` | 48 | 40 | 36 | 输入框 / 搜索框高 |
| `size.tabBar` | 48 | 40 | 36 | 分段标签栏高 |
| `size.tabLabel` | 46 | 38 | 34 | 分段标签文字区高 |
| `size.rowMin` | 56 | 48 | 40 | 列表项最小高 |
| `size.menuItem` | 40 | 36 | 32 | 菜单项高 |
| `size.minTouch` | 44 | 44 | 44 | 无障碍最小命中区（常量） |

组件固定尺寸（不随密度变化，仍来自 Token）：

| 尺寸 Token | 值 | 用于 |
| --- | --- | --- |
| `size.avatarXs/sm/md/lg/xl` | 24 / 32 / 40 / 48 / 64 | 头像尺寸 |
| `size.badgeDot` / `size.badgeMin` | 8 / 16 | 徽标圆点与数字徽标 |
| `size.tagHeight` | 24 | 标签高度 |
| `size.sliderValueWidth` | 40 | 滑块右侧数值区 |
| `size.skeletonLine` | 16 | 默认骨架行高 |
| `size.progressRing` / `size.progressTrack` | 56 / 4 | 环形进度与线性进度轨道 |
| `size.sheetHandleWidth/Height` | 32 / 4 | BottomSheet 拖拽条 |
| `size.dialogMaxWidth` | 400 | Dialog 最大宽度 |
| `size.menuMinWidth` / `size.popoverMaxWidth` | 160 / 240 | 菜单与气泡面板 |

字号（size / lineHeight 随密度切换，weight 不变）：

| 字阶 | 舒适 | 紧凑 | 超紧凑 |
| --- | --- | --- | --- |
| displayLarge | 48/56 | 40/48 | 36/44 |
| displayMedium | 36/44 | 32/40 | 30/38 |
| headlineLarge | 30/38 | 26/34 | 24/30 |
| headlineMedium | 24/32 | 22/28 | 20/26 |
| titleLarge | 20/28 | 18/24 | 17/22 |
| titleMedium | 18/26 | 16/22 | 15/20 |
| body | 16/24 | 14/20 | 13/18 |
| bodySmall | 14/20 | 13/18 | 12/16 |
| label | 14/20 | 13/18 | 12/16 |
| caption | 12/16 | 12/16 | 12/16（可读下限，不缩） |

- 运行时（尺寸）：`Token.size.buttonMedium(density)`，`density: Density`。
- 运行时（字体）：`Token.font.body.sizeFor(density)` / `.lineHeightFor(density)`；原 `.size` / `.lineHeight` 仍返回舒适档常规值。
- 组件持有 `@StorageProp('density') density: Density = Density.Comfortable` 并在 build 里引用（作为 `Token.size.*` / `Token.font.*.sizeFor` 的入参），切换即重绘。
- 全局切换：`setDensity(Density.SuperCompact)`（或启动时 `initDensity(...)`）；`currentDensity()` 读取当前档，兼容旧布尔键 `'compact'`；`setCompact(true)` 映射为 `Compact`。
- **无障碍**：紧凑 / 超紧凑下控件视觉可小于 44，但用 `.responseRegion(...)` 把命中区兜底到 `size.minTouch`（44）。

## 源文件

| 文件 | 用途 |
| --- | --- |
| [tokens/design-tokens.json](../tokens/design-tokens.json) | 单一事实来源，遵循 W3C Design Tokens 格式，可导入 Figma / Style Dictionary |
| [library/src/main/ets/theme/Tokens.ets](../library/src/main/ets/theme/Tokens.ets) | ArkUI 运行时 Token（`@riclava/designsystem` 导出） |
| [library/src/main/resources](../library/src/main/resources) | ArkUI 资源（Light / Dark 颜色，随包分发） |

## 工作流

```
design-tokens.json  ──┬──▶  Figma Variables（设计）
 (Single Source)      │
                      ├──▶  node tools/design-system.mjs generate
                      │       └──▶ library/ Tokens.ets + resources（开发）
                      │
                      └──▶  node tools/design-system.mjs check（漂移校验）
```

## 变更规则

- Token 变更走评审；破坏性变更（删除/改名）升主版本号。
- 新增语义色前先确认现有 Token 不能满足。
- 保持语义颜色 Token ≤ 16 个（另有 `transparent` 功能色），字阶 ≤ 10 个。
- 改 `tokens/design-tokens.json` 后必须运行 `node tools/design-system.mjs generate`，提交生成物；CI / 本地检查运行 `node tools/design-system.mjs check`。

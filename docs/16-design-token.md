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

Size（控件尺寸，随 compact 密度切换）
└── buttonLarge/Medium/Small · field · tabBar · tabLabel · rowMin · menuItem · minTouch(44)
```

## 分层：Reference → System → Component

现代设计系统（Material 3 / HarmonyOS）将 Token 分三层：

| 层 | 说明 | 示例 |
| --- | --- | --- |
| **Reference（基础）** | 原始调色板 / 尺寸原子值 | `blue.500 = #2979FF` |
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
| 尺寸 | `size.buttonMedium` / `size.field`（随 compact 切换） | 本页「密度 / Compact」小节 |

## 密度 / Compact（控件尺寸）

面向数据密集型 / 大屏多面板等超复杂应用，提供 **compact 紧凑密度**：整体收紧控件高度与内边距，**字号、行高、圆角、颜色均不变**。

> 这里的 "compact" 指**信息密度**，与 [15 自适应布局](15-adaptive-layout.md) 里的断点 `Compact`（宽度 < 600vp）无关，两者可组合。

| 尺寸 Token | 常规 | 紧凑 | 用于 |
| --- | --- | --- | --- |
| `size.buttonLarge` | 48 | 40 | 大按钮高 |
| `size.buttonMedium` | 40 | 32 | 中按钮高 |
| `size.buttonSmall` | 32 | 28 | 小按钮高 |
| `size.field` | 48 | 40 | 输入框 / 搜索框高 |
| `size.tabBar` | 48 | 40 | 分段标签栏高 |
| `size.tabLabel` | 46 | 38 | 分段标签文字区高 |
| `size.rowMin` | 56 | 48 | 列表项最小高 |
| `size.menuItem` | 40 | 36 | 菜单项高 |
| `size.minTouch` | 44 | 44 | 无障碍最小命中区（常量） |

- 运行时：`Token.size.buttonMedium(compact)` 返回对应值；`compact` 取自 `AppStorage['compact']`。
- 组件持有 `@StorageProp('compact') compact` 并在 build 里引用（作为 `Token.size.*` 入参），切换即重绘。
- **无障碍**：紧凑下控件视觉可小于 44，但用 `.responseRegion(...)` 把命中区兜底到 `size.minTouch`（44）。

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
                      ├──▶  library/ Tokens.ets + resources（开发）
                      │
                      └──▶  对比度 / 命名校验（测试 CI）
```

## 变更规则

- Token 变更走评审；破坏性变更（删除/改名）升主版本号。
- 新增语义色前先确认现有 Token 不能满足。
- 保持颜色 Token ≤ 16 个，字阶 ≤ 10 个。

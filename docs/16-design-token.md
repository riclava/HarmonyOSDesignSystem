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

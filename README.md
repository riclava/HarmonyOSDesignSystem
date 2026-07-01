# HarmonyOS Design System

一套面向 **长期维护多个鸿蒙 App** 的通用设计系统（Design System）。

参考并融合了业界主流体系的组织方式：

- HarmonyOS Design Language（华为官方）
- Material Design 3（Google）
- Apple Human Interface Guidelines
- Ant Design（Ant Group）
- Carbon Design System（IBM）

核心理念：**设计、开发、测试共享同一套 Design Token**。
所有颜色、字体、间距、圆角、阴影、动画都来自 Token，ArkUI 只引用 Token，不直接写具体值。

---

## 目录结构

| 章节 | 说明 |
| --- | --- |
| [01 Design Principles](docs/01-design-principles.md) | 设计原则 |
| [02 Color](docs/02-color.md) | 颜色规范 |
| [03 Typography](docs/03-typography.md) | 字体规范 |
| [04 Spacing](docs/04-spacing.md) | 间距规范 |
| [05 Radius](docs/05-radius.md) | 圆角规范 |
| [06 Shadow](docs/06-shadow.md) | 阴影 / 高度 |
| [07 Icon](docs/07-icon.md) | 图标规范 |
| [08 Motion](docs/08-motion.md) | 动画规范 |
| [09 Layout](docs/09-layout.md) | 布局规范 |
| [10 Components](docs/10-components.md) | 组件规范 |
| [11 Navigation](docs/11-navigation.md) | 导航规范 |
| [12 Interaction](docs/12-interaction.md) | 交互规范 |
| [13 Accessibility](docs/13-accessibility.md) | 无障碍 |
| [14 Dark Mode](docs/14-dark-mode.md) | 深色模式 |
| [15 Adaptive Layout](docs/15-adaptive-layout.md) | 自适应布局 |
| [16 Design Token](docs/16-design-token.md) | 设计令牌（核心） |
| [17 Coding Specification](docs/17-coding-specification.md) | 开发规范 |

## 可复用代码包（新 App 直接安装）

`@riclava/designsystem`（HAR），源码在 [`library/`](library)，导出 Token 与全部组件。

| 文件 | 用途 |
| --- | --- |
| [library/Index.ets](library/Index.ets) | 公共 API 出口（`import { Token, AppButton } from '@riclava/designsystem'`，含 Token + 20+ 组件） |
| [library/src/main/ets/theme/Tokens.ets](library/src/main/ets/theme/Tokens.ets) | ArkUI 运行时 Token（canonical） |
| [tokens/design-tokens.json](tokens/design-tokens.json) | 单一事实来源（Figma / 工具链 / AI 共享） |

## 示例

| 目录 | 用途 |
| --- | --- |
| [showcase/](showcase/README.md) | 活文档 App：用真实 ArkUI 代码展示全部 Token 与组件，带深色、紧凑密度实时切换 |

## AI 接入（暴露给新项目的 AI 助手）

| 文件 | 用途 |
| --- | --- |
| [AGENTS.md](AGENTS.md) | 面向任意 AI 工具的硬性规则 + Token 速查（**核心，一个就够**） |
| [.kiro/steering/design-system.md](.kiro/steering/design-system.md) | Kiro 用户可选：Steering（always 生效） |

---

## 快速开始

- 新 App 接入 / AI 接入的完整步骤见 **[Getting Started](docs/GETTING-STARTED.md)**。

1. 阅读 [01 Design Principles](docs/01-design-principles.md) 理解原则。
2. 所有取值都在 [16 Design Token](docs/16-design-token.md) 中定义。
3. 开发时遵循 [17 Coding Specification](docs/17-coding-specification.md)，只引用 Token。

## 版本

- 版本：`1.0.0`
- 命名：可将本系统命名为你自己的体系（例如 `AnyOS Design System`）。
- 维护：Token 变更遵循语义化版本；破坏性变更升主版本号。

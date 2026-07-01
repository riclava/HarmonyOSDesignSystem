# Getting Started · 新 App 如何快速接入

分两部分：**新 App 如何用**（人）与 **如何暴露给 AI**（工具）。

---

## 一、新 App 快速接入

设计系统以 HAR 包 `@riclava/designsystem` 分发（源码在 [`library/`](../library)）。三选一：

### 方式 A：ohpm 私有仓库（团队推荐）

发布一次，各 App 直接安装。

```bash
# 在 library/ 目录发布到私有 ohpm registry
ohpm publish

# 在新 App 里安装
ohpm install @riclava/designsystem
```

### 方式 B：本地路径依赖（快速试用 / 单机）

在新 App 的 `oh-package.json5`：

```json5
{
  "dependencies": {
    "@riclava/designsystem": "file:../HarmonyOSDesignSystem/library"
  }
}
```

然后 `ohpm install`。

### 方式 C：作为模块加入工程（Monorepo）

把 `library/` 作为一个 HAR 模块加入 DevEco 工程的 `build-profile.json5` `modules` 列表，`entry` 模块依赖它。

---

### 接入后：3 步用起来

1) 让主题跟随系统深浅色 —— 在 `EntryAbility.ets`：

```ts
import { initColorMode } from '@riclava/designsystem';
import { AbilityConstant, ConfigurationConstant, UIAbility, Want } from '@kit.AbilityKit';

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, _: AbilityConstant.LaunchParam): void {
    initColorMode(this.context.config.colorMode);
  }
  onConfigurationUpdate(config): void {
    initColorMode(config.colorMode); // 系统切换深浅色时同步
  }
}
```

2) 页面里只引用 Token + 组件：

```ts
import { Token, AppButton, AppButtonType, AppCard } from '@riclava/designsystem';

@Entry
@Component
struct Home {
  @StorageLink('isDark') isDark: boolean = false; // 保证深浅色切换时重绘

  build() {
    Column({ space: Token.space.md }) {
      Text('欢迎')
        .fontSize(Token.font.headlineMedium.size)
        .fontColor(Token.color.onSurface())
      AppCard() {
        Text('这是一张卡片').fontColor(Token.color.onSurfaceVariant())
      }
      AppButton({ label: '开始', type: AppButtonType.Primary })
    }
    .padding(Token.space.md)
    .backgroundColor(Token.color.background())
    .width('100%').height('100%')
  }
}
```

3) 遵循 [17 Coding Specification](17-coding-specification.md)：不写死任何样式值。

### 可选：数据密集场景开启紧凑密度（compact）

超复杂应用（管理后台、大屏多面板）可全局开启 compact，组件整体收紧尺寸、内边距**与字号/行高**（圆角、颜色不变；caption 保持可读下限；命中区仍 ≥ 44）：

```ts
AppStorage.setOrCreate('compact', true); // 任意位置切换，全局组件联动收紧
```

自定义控件若也要跟随：持有 `@StorageProp('compact') compact`，并在 build 里用 `Token.size.*(this.compact)` 取尺寸、`Token.font.X.sizeFor(this.compact)` 取字号。详见 [16 Design Token](16-design-token.md) 的「密度 / Compact」小节。

---

## 二、如何暴露给新项目的 AI

目标：让新项目的 AI 助手"知道"这套规则，自动只用 Token、优先用现成组件。

### 1. 通用（任何 AI 工具）：`AGENTS.md`

把仓库根目录的 [`AGENTS.md`](../AGENTS.md) 拷到新项目根目录。
Cursor / Claude Code / Copilot 等会读取它作为项目规则，内含黄金法则 + Token 速查 + 组件清单。

### 2. Kiro：Steering 文件

把 [`.kiro/steering/design-system.md`](../.kiro/steering/design-system.md) 拷到新项目的 `.kiro/steering/`。
它是 `inclusion: always`，Kiro 每次对话都会自动带上规则，并通过 `#[[file:...]]` 引用机器可读的
`tokens/design-tokens.json`（把该文件一并放入新项目，或改成指向 HAR 包内路径）。

### 3. 机器可读 Token：`design-tokens.json`

[`tokens/design-tokens.json`](../tokens/design-tokens.json) 是 W3C Design Tokens 格式，
既能被 Figma / Style Dictionary 导入，也能被 AI 直接解析出全部合法取值——
AI 生成代码前查它即可避免"编造"颜色或间距。

### 推荐做法（组合拳）

```
新项目/
├── AGENTS.md                       # 从本仓库拷贝（核心，一个就够）
├── tokens/design-tokens.json       # 从本仓库拷贝（供 AI/工具读取，可选）
├── .kiro/steering/design-system.md # Kiro 用户可选
└── oh-package.json5                # 依赖 @riclava/designsystem
```

这样：**代码层**通过 HAR 复用组件与 Token，**AI 层**通过 `AGENTS.md` 复用规则，两者同源、不漂移。

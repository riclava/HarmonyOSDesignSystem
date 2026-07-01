# Design System Showcase · 设计系统示例 App

一个"活文档"式的 HarmonyOS 应用，用**真实的 ArkUI 代码**展示设计系统的全部 Token 与组件。

所有页面的取值都来自 [`Tokens.ets`](entry/src/main/ets/designsystem/Tokens.ets)，
证明"只引用 Token、不硬编码"的规范是可落地的。

## 功能

- **顶部深色开关**：一键切换 Light / Dark，所有 Token 实时联动。
- **Foundation**：Color、Typography、Spacing、Radius、Shadow、Icon、Motion（可点击演示动画）。
- **Components**：Button、Tag、Card、TextField、Switch、Slider、Progress（线性/环形）、Search、Checkbox、Radio、Avatar、Badge。
- **Overlays**：Dialog、BottomSheet、Toast、Menu。
- **States**：Loading、Empty、Error、Skeleton（骨架屏微光动画）。
- **Adaptive**：响应式栅格（GridRow 断点）、触摸命中区 44×44、对比度示例。

## 目录

```
showcase/
├── AppScope/app.json5
├── build-profile.json5 · oh-package.json5 · hvigorfile.ts
└── entry/
    └── src/main/
        ├── module.json5
        ├── resources/
        │   ├── base/element/{color,string}.json   # 浅色 Token
        │   ├── dark/element/color.json             # 深色 Token
        │   └── base/profile/main_pages.json
        └── ets/
            ├── entryability/EntryAbility.ets
            ├── designsystem/
            │   ├── Tokens.ets                      # Token 出口（响应式）
            │   └── components/
            │       ├── AppButton · AppCard · AppTag
            │       ├── AppAvatar · AppBadge
            │       ├── AppDialog（CustomDialog）
            │       ├── Skeleton（骨架屏）
            │       └── StateView（Loading/Empty/Error）
            ├── sections/                           # 各展示区块
            │   ├── Widgets.ets
            │   ├── ColorSection … IconSection … MotionSection
            │   ├── ComponentsSection · FormSection · DataDisplaySection
            │   ├── OverlaysSection · StatesSection
            │   └── AdaptiveSection
            └── pages/Index.ets                     # 首页 + 5 个 Tab + 深色开关
```

## 运行

1. 用 **DevEco Studio**（API 12 / HarmonyOS 5.0 及以上）打开 `showcase/` 目录。
2. 等待 `hvigor` 同步依赖。
3. 选择模拟器或真机，点击 Run 运行 `entry` 模块。

## 一次性手动步骤

工程引用了应用图标 `$media:app_icon`，但图标是二进制文件无法随文本生成。
首次打开时请补一张图标：

- 在 `entry/src/main/resources/base/media/` 放入 `app_icon.png`（建议 216×216）。
- 或用 DevEco Studio 的 `New > Image Asset` 生成。

## 与规范的关系

- Token 值与仓库根目录 [`tokens/`](../tokens/) 保持同源。
- 深色切换在 showcase 中通过 `AppStorage('isDark')` 驱动，便于 App 内实时演示；
  生产项目建议直接用 ArkUI 资源系统（`$r('app.color.*')` + `theme.json`）跟随系统。
- 组件封装示例见 `designsystem/components/`，对应规范 [10 Components](../docs/10-components.md) 与 [17 Coding Specification](../docs/17-coding-specification.md)。

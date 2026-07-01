# Design System Showcase · 设计系统示例 App

一个"活文档"式的 HarmonyOS 应用，用**真实的 ArkUI 代码**展示设计系统的全部 Token 与组件。

所有页面的取值都来自 [`Tokens.ets`](entry/src/main/ets/designsystem/Tokens.ets)，
证明"只引用 Token、不硬编码"的规范是可落地的。

## 功能

- **顶部开关**：深色（Light / Dark，App 级 `setColorMode` 全量重绘）+ 紧凑密度（compact），Token 与控件尺寸实时联动。
- **Foundation**：Color、Typography、Spacing、Radius、Shadow、Icon、Motion（可点击演示动画）。
- **Components**：Button（含 loading）、Tag、Card（可点击）、Avatar、Badge、Progress（线性 / 环形）。
- **Form**：TextField、Search、Checkbox、Radio、Switch、Slider。
- **Navigation**：Tabs（分段）、List（列表项）。
- **Overlays**：Dialog、BottomSheet、Toast、Menu、Popover。
- **Pickers**：DatePicker、Calendar。
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
            │   ├── Tokens.ets                      # Token 出口（响应式，含 size 密度）
            │   └── components/                     # 20+ 组件（App* + StateView / Skeleton）
            ├── sections/                           # 各展示区块
            │   ├── Widgets.ets
            │   ├── ColorSection … MotionSection            # Foundation
            │   ├── ComponentsSection · FormSection · DataDisplaySection · NavigationSection
            │   ├── OverlaysSection · PickersSection · StatesSection
            │   └── AdaptiveSection
            └── pages/Index.ets                     # 首页 + 6 个 Tab + 深色 / 紧凑开关
```

## 运行

1. 用 **DevEco Studio**（API 12 / HarmonyOS 5.0 及以上）打开 `showcase/` 目录。
2. 等待 `hvigor` 同步依赖。
3. 选择模拟器或真机，点击 Run 运行 `entry` 模块。

## 应用图标

工程已内置一张占位 SVG 图标 `app_icon.svg`（`entry/src/main/resources/base/media/` 与 `AppScope/resources/base/media/`），
使用设计系统的 Primary 色，可直接构建运行。替换为品牌图标即可：

- 覆盖上述两处 `app_icon.svg`（或换成 `app_icon.png`，建议 216×216，并同步 `module.json5` / `app.json5` 的引用）。
- 或用 DevEco Studio 的 `New > Image Asset` 生成。

## 与规范的关系

- Token 值与仓库根目录 [`tokens/`](../tokens/) 保持同源。
- 深色切换在 showcase 中通过 App 级 `setColorMode` 驱动（配合 `AppStorage('isDark')`），令所有 Token 颜色全量重绘；生产项目也可直接用 ArkUI 资源系统（`$r('app.color.*')` + `theme.json`）跟随系统。
- 紧凑密度通过 `AppStorage('compact')` 驱动，组件持有 `@StorageProp('compact')` 并用 `Token.size.*(compact)` 取尺寸；详见 [16 Design Token](../docs/16-design-token.md)。
- 组件封装示例见 `designsystem/components/`，对应规范 [10 Components](../docs/10-components.md) 与 [17 Coding Specification](../docs/17-coding-specification.md)。

# 19 Theming · 主题与品牌化

设计系统支持两个正交维度：**品牌（brand）** 与 **深浅色（light/dark）**。同一套组件结构、间距、字体、圆角保持不变，仅品牌相关颜色随 brand 切换，深浅色随系统/开关切换。

## 模型

- **深浅色**：每个颜色 Token 都有 `light` / `dark` 两套值，运行时按 `isDark` 求值。
- **品牌**：部分颜色（主色族）可为不同 brand 提供覆盖值；未覆盖的颜色（中性色、语义色）所有 brand 共用。
- 运行时最终颜色 = `resolve(brand)` → 再按 `isDark` 取 `light` / `dark`。

默认 brand 为 `default`。目前内置示例 brand：`violet`（紫色主色族）。

## Token 中定义品牌

在 `tokens/design-tokens.json` 里，给需要区分品牌的颜色加 `$extensions.brands.<brandId>`：

```json5
"primary": {
  "$type": "color",
  "$value": { "light": "#126AFF", "dark": "#6EA8FF" },      // default 品牌
  "$extensions": {
    "brands": {
      "violet": { "light": "#6D28D9", "dark": "#A78BFA" }   // violet 品牌覆盖
    }
  }
}
```

改完执行 `npm run tokens:generate`，生成器会把带品牌覆盖的颜色渲染为按 `currentBrand()` 分支的方法（无覆盖的颜色保持单一取值，零额外开销）。

> **约束**：品牌切换只作用于运行时 `Token.color.*()`。资源文件 `color.json`（`$r('app.color.*')`）只承载 `default` 品牌值。设计系统组件统一走 `Token.color.*()`，因此天然支持换肤；业务若直接用 `$r('app.color.*')` 则不随 brand 切换。

## 运行时 API

从 `@riclava/designsystem` 导入：

```ts
import { initTheme, setBrand, currentBrand } from '@riclava/designsystem';
import { ConfigurationConstant } from '@kit.AbilityKit';

// 启动时（Ability.onCreate / onWindowStageCreate）确定品牌 + 深浅色
initTheme('violet', config.colorMode);

// 运行时切换品牌（会触发所有组件重绘）
setBrand('default');

// 读取当前品牌
const brand: string = currentBrand();   // 'default' | 'violet' | ...
```

## 组件如何随品牌重绘

与 `isDark` 一致：组件持有 `@StorageLink('brand') brand: string = 'default'`。
`setBrand(id)`（或直接写 `AppStorage.setOrCreate('brand', id)`）更新后，所有持有该 link 的组件重绘，`build` 内的 `Token.color.*()` 重新按新品牌求值。

自定义业务组件若要随品牌切换，同样持有 `@StorageLink('brand')` 即可（无需引用其值）。

## 新增一个品牌

1. 在 `tokens/design-tokens.json` 给主色族（至少 `primary` / `primaryContainer` / `onPrimary`，可含 `secondary` 等）加 `$extensions.brands.<你的brandId>`。
2. `npm run tokens:generate` 重新生成运行时。
3. `npm run contrast:check`：对比度门禁会**对每个品牌**校验（文本 ≥ 4.5、状态指示 ≥ 3.0）。不达标需调整品牌色。
4. 业务侧 `initTheme('<你的brandId>', colorMode)` 或 `setBrand('<你的brandId>')`。

## 无障碍

每个品牌都必须满足 WCAG 对比度（见 [02 Color](02-color.md)、[13 Accessibility](13-accessibility.md)）。CI 硬门禁会逐品牌校验 `onPrimary/primary` 等文本对，新增品牌若不达标会直接失败。

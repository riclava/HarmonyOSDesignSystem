# 17 Coding Specification · 开发规范

**所有颜色、字体、Padding、Margin、Radius、Shadow、Animation 都来自 Token。**

## 核心规则

### 禁止 ❌ 硬编码

```ts
Text('标题')
  .fontSize(18)        // ❌ 魔法数字
  .fontColor('#2979FF') // ❌ 硬编码颜色
  .padding(16)          // ❌ 硬编码间距
```

### 统一 ✅ 引用 Token

```ts
import { Token } from '@riclava/designsystem';
import { LengthMetrics } from '@kit.ArkUI';

@StorageLink('brand') brand: string = 'default';

Text('标题')
  .fontSize(Token.font.titleMedium.size)
  .fontColor(Token.color.primary(this.brand))
  .padding({
    start: LengthMetrics.vp(Token.space.md),
    end: LengthMetrics.vp(Token.space.md)
  })
```

## 检查项

| 维度 | 必须来自 |
| --- | --- |
| 颜色 | `Token.color.*()`；有品牌覆盖的颜色在组件内用 `Token.color.*(this.brand)` |
| 字体大小 / 行高 / 字重 | `Token.font.*` |
| 间距（padding/margin/space） | `Token.space.*` |
| 圆角 | `Token.radius.*` |
| 阴影 | `Token.shadow.*` |
| 动画时长 / 曲线 | `Token.motion.*` |

## 组件封装

- 优先封装通用组件（`AppButton`、`AppCard`），内部消费 Token，业务层不重复写样式。
- 组件通过 props 暴露语义变体（`type: 'primary' | 'secondary'`），不暴露原始颜色。

```ts
import { LengthMetrics } from '@kit.ArkUI';
import { Token } from '@riclava/designsystem';

@Component
struct AppButton {
  @Prop label: ResourceStr = '';
  @Prop primary: boolean = true;
  @StorageLink('brand') brand: string = 'default';

  build() {
    Text(this.label)
      .fontSize(Token.font.label.size)
      .fontColor(this.primary ? Token.color.onPrimary(this.brand) : Token.color.primary(this.brand))
      .backgroundColor(this.primary ? Token.color.primary(this.brand) : Token.color.transparent())
      .padding({ start: LengthMetrics.vp(Token.space.lg), end: LengthMetrics.vp(Token.space.lg) })
      .height(Token.size.buttonLarge(false))
      .borderRadius(Token.radius.sm)
  }
}
```

## 深色模式

- 优先使用 ArkUI 资源系统（`$r('app.color.*')`，颜色资源随 `@riclava/designsystem` 分发），系统自动切换。
- 或在 Token 中根据 `ColorMode` 返回对应值，禁止业务层判断深浅。

## Lint / CI 约束

建议在 CI 中加入静态检查，拦截以下模式：

- 字面量颜色：`#[0-9a-fA-F]{3,8}`、`rgb(` / `rgba(`
- 数值样式属性直接传数字字面量（`fontSize(18)`、`padding(16)`）
- 未引用 `Token` 的样式调用
- 有品牌覆盖的 Token 裸调用（如 `Token.color.primary()`），组件内必须传 `this.brand`
- Token 生成物与 `tokens/design-tokens.json` 不一致
- 面向文本 / 图标使用的颜色组合低于 [无障碍](13-accessibility.md) 要求

本仓库已提供基础校验：

```sh
node tools/design-system.mjs check
```

## 命名约定

- 组件文件 `PascalCase.ets`；变量 `camelCase`；运行时 Token 使用 `Token.color.primary(this.brand)` / `Token.space.md` 这种 lower camel API。
- 组件前缀统一（如 `App*`），便于跨项目复用与检索。

## 复用与维护

- 多 App 共享同一 `tokens/` 与通用组件库（建议独立为 HAR 包）。
- 升级 Token 走版本发布，App 通过依赖版本获取，避免各自魔改。

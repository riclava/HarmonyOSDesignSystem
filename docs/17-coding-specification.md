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

Text('标题')
  .fontSize(Token.Font.TitleMedium.size)
  .fontColor(Token.Color.Primary)
  .padding(Token.Space.MD)
```

## 检查项

| 维度 | 必须来自 |
| --- | --- |
| 颜色 | `Token.Color.*` |
| 字体大小 / 行高 / 字重 | `Token.Font.*` |
| 间距（padding/margin/space） | `Token.Space.*` |
| 圆角 | `Token.Radius.*` |
| 阴影 | `Token.Shadow.*` |
| 动画时长 / 曲线 | `Token.Motion.*` |

## 组件封装

- 优先封装通用组件（`AppButton`、`AppCard`），内部消费 Token，业务层不重复写样式。
- 组件通过 props 暴露语义变体（`type: 'primary' | 'secondary'`），不暴露原始颜色。

```ts
@Component
struct AppButton {
  @Prop label: string;
  @Prop type: 'primary' | 'secondary' = 'primary';

  build() {
    Text(this.label)
      .fontSize(Token.Font.Label.size)
      .fontColor(this.type === 'primary' ? Token.Color.OnPrimary : Token.Color.Primary)
      .backgroundColor(this.type === 'primary' ? Token.Color.Primary : Token.Color.Transparent)
      .padding({ left: Token.Space.LG, right: Token.Space.LG })
      .height(48)
      .borderRadius(Token.Radius.SM)
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

## 命名约定

- 组件文件 `PascalCase.ets`；变量 `camelCase`；Token 常量 `PascalCase`。
- 组件前缀统一（如 `App*`），便于跨项目复用与检索。

## 复用与维护

- 多 App 共享同一 `tokens/` 与通用组件库（建议独立为 HAR 包）。
- 升级 Token 走版本发布，App 通过依赖版本获取，避免各自魔改。

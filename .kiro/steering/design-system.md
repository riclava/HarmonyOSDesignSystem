---
inclusion: always
---

# HarmonyOS Design System — Kiro 使用规则

在本仓库（及任何拷贝此 steering 的项目）中生成 ArkUI 代码时，遵守以下规则。

## 黄金法则

所有颜色 / 字号 / 行高 / 字重 / 间距 / 圆角 / 阴影 / 动画时长必须来自 `Token`，禁止硬编码。

```ts
import { Token } from '@riclava/designsystem';
Text('标题')
  .fontSize(Token.font.titleMedium.size)
  .fontColor(Token.color.primary())
  .padding(Token.space.md)
```

## Token 引用方式

- 颜色：`Token.color.primary()`（函数调用，返回随深浅色切换）
- 字体：`Token.font.body.size / .lineHeight / .weight`
- 间距：`Token.space.md`（4 的倍数）
- 圆角：`Token.radius.md`
- 图标：`Token.icon.md`（默认 24）
- 阴影：`Token.shadow.level1`
- 动画：`Token.motion.normal` + `Token.motion.easeOut`

## 组件优先

需要 UI 时先用现成组件：`AppButton` `AppCard` `AppTag` `AppBadge` `AppAvatar` `AppDialog` `StateView` `Skeleton`。都从 `@riclava/designsystem` 导入。

## 硬性约束

1. 深浅色只靠 Token；组件持有 `@StorageLink('isDark') isDark: boolean`；跟随系统在 Ability 调 `initColorMode(config.colorMode)`。
2. 可交互命中区 ≥ 44×44vp；图标按钮加 `.accessibilityText(...)`；信息不只靠颜色。
3. 一屏一个 Primary 行动；破坏性操作用 `Danger` + 二次确认。
4. 动画 ≤ 400ms，进 easeOut / 出 easeIn。

## 权威来源

- 完整规范：`docs/01-design-principles.md` ~ `docs/17-coding-specification.md`
- Token 单一事实来源（机器可读）：

#[[file:tokens/design-tokens.json]]

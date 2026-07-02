# 05 Radius · 圆角规范

## 圆角 Token

| Token | 值 (vp) | 用途 |
| --- | --- | --- |
| `Token.radius.none` | 0 | 贴边元素、全屏 |
| `Token.radius.xs` | 4 | 标签 Tag、Badge |
| `Token.radius.sm` | 8 | 按钮、输入框、小卡片 |
| `Token.radius.md` | 12 | 卡片、列表项 |
| `Token.radius.lg` | 16 | 大卡片、弹窗 Dialog |
| `Token.radius.xl` | 20 | BottomSheet、大面板 |
| `Token.radius.xxl` | 24 | 特殊容器 |
| `Token.radius.xxxl` | 32 | 超大容器 |
| `Token.radius.full` | 999 | 胶囊按钮、头像、圆形 |

## 使用规则

- 同一组件所有圆角一致，除非刻意做单边圆角（如 BottomSheet 顶部）。
- 嵌套元素：内层圆角 = 外层圆角 − 内边距，保持同心。
- 圆形头像、开关滑块、胶囊标签统一用 `Token.radius.full`。
- 禁止随意写 `6`、`10`、`14` 等非 Token 值。

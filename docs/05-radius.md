# 05 Radius · 圆角规范

## 圆角 Token

| Token | 值 (vp) | 用途 |
| --- | --- | --- |
| `RadiusNone` | 0 | 贴边元素、全屏 |
| `RadiusXS` | 4 | 标签 Tag、Badge |
| `RadiusSM` | 8 | 按钮、输入框、小卡片 |
| `RadiusMD` | 12 | 卡片、列表项 |
| `RadiusLG` | 16 | 大卡片、弹窗 Dialog |
| `RadiusXL` | 20 | BottomSheet、大面板 |
| `Radius2XL` | 24 | 特殊容器 |
| `Radius3XL` | 32 | 超大容器 |
| `RadiusFull` | 999 | 胶囊按钮、头像、圆形 |

## 使用规则

- 同一组件所有圆角一致，除非刻意做单边圆角（如 BottomSheet 顶部）。
- 嵌套元素：内层圆角 = 外层圆角 − 内边距，保持同心。
- 圆形头像、开关滑块、胶囊标签统一用 `RadiusFull`。
- 禁止随意写 `6`、`10`、`14` 等非 Token 值。

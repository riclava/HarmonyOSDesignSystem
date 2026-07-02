# 04 Spacing · 间距规范

采用 **8pt Grid**（4 为最小微调单位）。所有 margin / padding / gap 只能取以下值。

## 间距 Token

| Token | 值 (vp) | 典型用途 |
| --- | --- | --- |
| `Token.space.none` | 0 | 紧贴 |
| `Token.space.xxs` | 4 | 图标与文字间距、微调 |
| `Token.space.xs` | 8 | 标签内边距、列表项内间距 |
| `Token.space.sm` | 12 | 紧凑组件内边距 |
| `Token.space.md` | 16 | 默认内边距、页面左右边距 |
| `Token.space.lg` | 24 | 区块（Section）间距 |
| `Token.space.xl` | 32 | 大区块分隔 |
| `Token.space.xxl` | 40 | 页面级留白 |
| `Token.space.xxxl` | 48 | 空状态 / 首屏留白 |
| `Token.space.xxxxl` | 56 | 超大留白 |
| `Token.space.xxxxxl` | 64 | 特殊场景 |

## 使用规则

- 优先使用 `4 / 8 / 12 / 16 / 24 / 32`，其余为特殊场景。
- 同一层级元素间距一致；父子层级间距递增（如 8 → 16 → 24）。
- 组件内部间距 ≤ 组件外部间距，保证视觉分组。
- 禁止出现 `13`、`15`、`18` 等非 Token 值。

## 常用组合

| 场景 | 间距 |
| --- | --- |
| 页面左右 Padding | `Token.space.md` (16) |
| 列表项之间 | `Token.space.xs` (8) |
| 卡片内边距 | `Token.space.md` (16) |
| Section 之间 | `Token.space.lg` (24) |
| 图标与文字 | `Token.space.xxs` (4) ~ `Token.space.xs` (8) |

# 04 Spacing · 间距规范

采用 **8pt Grid**（4 为最小微调单位）。所有 margin / padding / gap 只能取以下值。

## 间距 Token

| Token | 值 (vp) | 典型用途 |
| --- | --- | --- |
| `SpaceNone` | 0 | 紧贴 |
| `SpaceXXS` | 4 | 图标与文字间距、微调 |
| `SpaceXS` | 8 | 标签内边距、列表项内间距 |
| `SpaceSM` | 12 | 紧凑组件内边距 |
| `SpaceMD` | 16 | 默认内边距、页面左右边距 |
| `SpaceLG` | 24 | 区块（Section）间距 |
| `SpaceXL` | 32 | 大区块分隔 |
| `SpaceXXL` | 40 | 页面级留白 |
| `Space3XL` | 48 | 空状态 / 首屏留白 |
| `Space4XL` | 56 | 超大留白 |
| `Space5XL` | 64 | 特殊场景 |

## 使用规则

- 优先使用 `4 / 8 / 12 / 16 / 24 / 32`，其余为特殊场景。
- 同一层级元素间距一致；父子层级间距递增（如 8 → 16 → 24）。
- 组件内部间距 ≤ 组件外部间距，保证视觉分组。
- 禁止出现 `13`、`15`、`18` 等非 Token 值。

## 常用组合

| 场景 | 间距 |
| --- | --- |
| 页面左右 Padding | `SpaceMD` (16) |
| 列表项之间 | `SpaceXS` (8) |
| 卡片内边距 | `SpaceMD` (16) |
| Section 之间 | `SpaceLG` (24) |
| 图标与文字 | `SpaceXXS` (4) ~ `SpaceXS` (8) |

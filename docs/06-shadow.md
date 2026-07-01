# 06 Shadow · 阴影 / 高度（Elevation）

**禁止自己随便写阴影。** 阴影表达元素的层级高度（Elevation），共分 5 级。

## Elevation Token

| Token | 高度 | 用途 | 参数（Light） |
| --- | --- | --- | --- |
| `Level0` | 0 | 页面背景、贴合元素 | 无阴影 |
| `Level1` | 1 | 卡片 Card、列表项 | y=1, blur=3, `rgba(0,0,0,0.08)` |
| `Level2` | 3 | 悬浮按钮、下拉、Tab 栏 | y=2, blur=6, `rgba(0,0,0,0.10)` |
| `Level3` | 6 | 弹窗 Dialog、Popover | y=4, blur=12, `rgba(0,0,0,0.14)` |
| `Level4` | 12 | 抽屉、全屏浮层 | y=8, blur=24, `rgba(0,0,0,0.18)` |

## 深色模式

深色模式下阴影不可见，改用 **表面叠加色**（Surface Overlay）表达高度：高度越高，Surface 越亮。

| 高度 | 叠加亮度 |
| --- | --- |
| Level1 | +5% |
| Level2 | +8% |
| Level3 | +11% |
| Level4 | +14% |

## 使用规则

- 阴影只用于表达"浮起"，不用于装饰。
- 同一层级元素使用同一 Elevation。
- 静止 Card 用 `Level1`，交互浮起时可升至 `Level2`。
- 高度不叠加：一个元素只有一个 Elevation。

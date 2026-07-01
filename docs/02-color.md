# 02 Color · 颜色规范

**采用 Token，不写具体颜色名（蓝、绿）。** 全系统颜色控制在 12~16 个语义 Token 以内。

## 语义 Token

| Token | 含义 | Light | Dark |
| --- | --- | --- | --- |
| `Primary` | 主色，品牌与主行动 | `#2979FF` | `#6EA8FF` |
| `PrimaryContainer` | 主色容器（浅底） | `#D6E4FF` | `#00429A` |
| `OnPrimary` | 主色上的文字/图标 | `#FFFFFF` | `#00285C` |
| `Secondary` | 次要强调色 | `#00C48C` | `#4FE0B5` |
| `SecondaryContainer` | 次色容器 | `#C8F5E7` | `#00513A` |
| `Success` | 成功 | `#34C759` | `#4ADE80` |
| `Warning` | 警告 | `#FF9F0A` | `#FBBF24` |
| `Danger` | 危险 / 错误 | `#FF3B30` | `#FF6B6B` |
| `Info` | 信息提示 | `#0A84FF` | `#64B5FF` |
| `Surface` | 卡片 / 面板底色 | `#FFFFFF` | `#1E1E1E` |
| `Background` | 页面背景 | `#F6F6F6` | `#000000` |
| `OnSurface` | 主文字 | `#1A1A1A` | `#F5F5F5` |
| `OnSurfaceVariant` | 次要文字 | `#666666` | `#A8A8A8` |
| `Outline` / `Border` | 边框 | `#E0E0E0` | `#3A3A3A` |
| `Divider` | 分割线 | `#EEEEEE` | `#2A2A2A` |
| `Mask` / `Overlay` | 遮罩层 | `rgba(0,0,0,0.45)` | `rgba(0,0,0,0.6)` |

## 使用规则

- **只用语义 Token**，禁止在业务代码中写 `#RRGGBB`。
- 文字与背景对比度需满足 [无障碍](13-accessibility.md) 要求（正文 ≥ 4.5:1）。
- `Container` 系列用于浅色填充背景，`On*` 系列用于其上的内容。
- 状态色（Success / Warning / Danger / Info）仅用于反馈，不用于装饰。

## 状态透明度

| 状态 | 叠加透明度 |
| --- | --- |
| Hover | 8% |
| Pressed | 12% |
| Focused | 12% + Outline |
| Disabled | 38%（内容） |
| Dragged | 16% |

## 调色板层级（可选扩展）

如需生成色阶，每个语义色可派生 `50 / 100 / 200 ... 900`，但业务层仍只引用语义 Token，不直接引用色阶数字。

# 08 Motion · 动画规范

动画表达空间关系与因果反馈，**总时长不超过 400ms**。

## 时长 Token

| Token | 时长 | 用途 |
| --- | --- | --- |
| `MotionInstant` | 100ms | 点击反馈、开关 |
| `MotionFast` | 200ms | 退出、消失、小元素 |
| `MotionNormal` | 250ms | 进入、展开 |
| `MotionSlow` | 300ms | 页面转场 |
| `MotionExtraSlow` | 400ms | 大面板 / 复杂转场（上限） |

## 缓动曲线 Token

| Token | 曲线 | 用途 |
| --- | --- | --- |
| `EaseStandard` | `cubic-bezier(0.2, 0, 0, 1)` | 通用 |
| `EaseOut` (Decelerate) | `cubic-bezier(0, 0, 0, 1)` | 进入（由快到慢） |
| `EaseIn` (Accelerate) | `cubic-bezier(0.3, 0, 1, 1)` | 退出（由慢到快） |
| `EaseSpring` | 弹性 | 拖拽回弹、滑动 |

## 常用规则

| 场景 | 时长 | 曲线 |
| --- | --- | --- |
| 进入 / 出现 | `MotionNormal` (250) | `EaseOut` |
| 退出 / 消失 | `MotionFast` (200) | `EaseIn` |
| 点击反馈 | `MotionInstant` (100) | `EaseStandard` |
| 页面转场 | `MotionSlow` (300) | `EaseStandard` |
| 拖动 / 滑动 | — | `EaseSpring` |

## 原则

- 动效有目的：解释来源与去向，不为炫技。
- 进场慢出场快（EaseOut 进、EaseIn 出）。
- 尊重系统"减弱动态效果"设置，开启时降级为淡入淡出或无动画。
- 避免同时超过 3 个元素做大位移动画。

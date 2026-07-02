# 08 Motion · 动画规范

动画表达空间关系与因果反馈，**总时长不超过 400ms**。

## 时长 Token

| Token | 时长 | 用途 |
| --- | --- | --- |
| `Token.motion.instant` | 100ms | 点击反馈、开关 |
| `Token.motion.fast` | 200ms | 退出、消失、小元素 |
| `Token.motion.normal` | 250ms | 进入、展开 |
| `Token.motion.slow` | 300ms | 页面转场 |
| `Token.motion.extraSlow` | 400ms | 大面板 / 复杂转场（上限） |

## 缓动曲线 Token

| Token | 曲线 | 用途 |
| --- | --- | --- |
| `Token.motion.easeStandard` | `cubic-bezier(0.2, 0, 0, 1)` | 通用 |
| `Token.motion.easeOut` (Decelerate) | `cubic-bezier(0, 0, 0, 1)` | 进入（由快到慢） |
| `Token.motion.easeIn` (Accelerate) | `cubic-bezier(0.3, 0, 1, 1)` | 退出（由慢到快） |

## 常用规则

| 场景 | 时长 | 曲线 |
| --- | --- | --- |
| 进入 / 出现 | `Token.motion.normal` (250) | `Token.motion.easeOut` |
| 退出 / 消失 | `Token.motion.fast` (200) | `Token.motion.easeIn` |
| 点击反馈 | `Token.motion.instant` (100) | `Token.motion.easeStandard` |
| 页面转场 | `Token.motion.slow` (300) | `Token.motion.easeStandard` |
| 拖动 / 滑动 | 系统组件默认 | 系统组件默认弹性反馈 |

## 原则

- 动效有目的：解释来源与去向，不为炫技。
- 进场慢出场快（Token.motion.easeOut 进、Token.motion.easeIn 出）。
- 尊重系统"减弱动态效果"设置，开启时降级为淡入淡出或无动画。
- 避免同时超过 3 个元素做大位移动画。

# 09 Layout · 布局规范

统一栅格（Grid）与页面结构，配合 [自适应布局](15-adaptive-layout.md) 使用。

## 栅格 Grid

| 断点 | 列数 | 间距 Gutter | 边距 Margin |
| --- | --- | --- | --- |
| Compact (<600) | 4 | 16 | 16 |
| Medium (600~840) | 8 | 24 | 24 |
| Expanded (>840) | 12 | 24 | 32 |

## 页面结构间距

| 区域 | 间距 Token |
| --- | --- |
| 页面左右 Padding | `Token.space.md` (16) |
| 页面上下 Padding | `Token.space.lg` (24) |
| Section 之间 | `Token.space.lg` (24) |
| Card 内边距 | `Token.space.md` (16) |
| 列表项之间 | `Token.space.xs` (8) |
| 表单字段之间 | `Token.space.md` (16) |

## 布局原则

- 内容最大宽度：正文阅读场景 ≤ 640vp，避免过宽行长。
- 使用 `Column` / `Row` + `space` 属性做等距排列，不手动堆叠 margin。
- 对齐优先：左对齐为主，避免混合对齐。
- 安全区：适配刘海、圆角屏、底部手势条（`expandSafeArea`）。
- 一屏聚焦一个主任务，主行动放在拇指易达区（底部）。

## 示例

```ts
import { LengthMetrics } from '@kit.ArkUI';
import { Token } from '@riclava/designsystem';

Column({ space: Token.space.lg }) {
  // sections...
}
.padding({
  start: LengthMetrics.vp(Token.space.md),
  end: LengthMetrics.vp(Token.space.md),
  top: LengthMetrics.vp(Token.space.lg)
})
```

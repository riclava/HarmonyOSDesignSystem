# 15 Adaptive Layout · 自适应布局

鸿蒙重点。一套设计适配 **Phone · Fold · Tablet · Desktop / 2in1**。

## 断点（Breakpoints）

| 断点 | 宽度 (vp) | 典型设备 | 列布局 |
| --- | --- | --- | --- |
| `Compact` | < 600 | 手机竖屏、折叠外屏 | Single Column |
| `Medium` | 600 ~ 840 | 折叠内屏、小平板、手机横屏 | Two Column |
| `Expanded` | > 840 | 平板、桌面、2in1 | Three Column |

## 布局响应策略

| 断点 | 导航 | 内容 | 边距 |
| --- | --- | --- | --- |
| Compact | Bottom Tabs | 单列，全宽卡片 | 16 |
| Medium | Navigation Rail | 双列（列表 + 详情） | 24 |
| Expanded | Side Menu | 三列（导航 + 列表 + 详情） | 32 |

## 自适应能力

- **List-Detail（一多）**：Compact 为跳转两页，Medium/Expanded 并排展示。
- **网格列数**：随宽度增加列数（`GridRow` / `GridCol` 或 `lanes`）。
- **折叠屏**：监听折叠状态（展开/半折/折叠），处理悬停态（Hover Mode）。
- **多窗口 / 自由窗口**：布局随窗口尺寸实时响应，不假设全屏。

## 实现要点

```ts
// 使用断点监听 + GridRow/GridCol
GridRow({ breakpoints: { value: ['600vp', '840vp'] } }) {
  GridCol({ span: { sm: 12, md: 6, lg: 4 } }) { /* ... */ }
}
```

- 用相对布局（百分比 / 弹性 / 栅格），避免固定宽高。
- 图片用 `objectFit` 自适应；避免拉伸变形。
- 触控与鼠标/键盘并存时，兼顾 Hover 与 Focus 态。

## 信息密度 / Compact

除了随宽度自适应，超复杂应用（管理后台、数据密集大屏）还可开启 **compact 密度**收紧控件尺寸：

- 开启：`AppStorage.setOrCreate('compact', true)`；组件走 `Token.size.*(compact)`。
- 与本页断点 `Compact`（宽度 < 600vp）**不是一回事**：这里指**信息密度**。两者可组合，例如 Expanded 宽屏 + compact 密度做多面板高信息量界面。
- 收紧尺寸 / 内边距 / 字号 / 行高（圆角、颜色不变，caption 保持可读下限）；命中区用 `responseRegion` 保持 ≥ 44。详见 [16 Design Token](16-design-token.md) 的「密度 / Compact」小节。

## 原则

- 一次设计，多端一致体验；不是简单拉伸。
- 大屏利用空间展示更多信息，而非放大元素。
- 关键操作在各形态下都保持易达。

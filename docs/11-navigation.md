# 11 Navigation · 导航规范

统一四类导航：Navigation Bar（顶栏）· Bottom Tabs（底部）· Side Menu / Navigation Rail（侧栏）· Back（返回）。

## Navigation Bar 顶部栏

| 属性 | 值 |
| --- | --- |
| 高度 | 56（不含状态栏） |
| 标题字阶 | `TitleLarge`（居中或左对齐） |
| 图标尺寸 | `Token.icon.md` (24) |
| 左右 Padding | `Token.space.md` (16) |
| 图标命中区 | 44×44 |
| 背景 | `Surface`，滚动时升 `Level2` |

- 返回按钮固定在左侧；操作图标不超过 3 个，多则收入溢出菜单。

## Bottom Tabs 底部标签栏

| 属性 | 值 |
| --- | --- |
| 高度 | 56 + 底部安全区 |
| 项数 | 3~5 |
| 图标尺寸 | `Token.icon.md` (24) |
| 文字字阶 | `Caption` (12) |
| 图标文字间距 | `Token.space.xxs` (4) |
| 选中色 | `Primary`（Filled 图标） |
| 未选中色 | `OnSurfaceVariant`（Outline 图标） |

- 切换动画 `Token.motion.fast`；不做页面滑动转场，直接切换。

## Navigation Rail / Side Menu 侧栏

- 用于 Medium / Expanded 屏（见 [自适应布局](15-adaptive-layout.md)）。
- Rail 宽 80，图标 `Token.icon.md` + `Caption`；抽屉宽 280~320。
- 选中项 `PrimaryContainer` 背景 + `Primary` 内容，圆角 `Token.radius.sm`。

## Back 返回

- 手势：左缘右滑返回；顶栏返回箭头 `Token.icon.md`。
- 转场：新页从右侧进入 `Token.motion.slow` / `Token.motion.easeStandard`，返回反向。

## 原则

- 导航层级 ≤ 3 层，避免深层嵌套。
- 当前位置始终可见（高亮 + 标题）。
- 同一层级导航方式在全 App 一致。

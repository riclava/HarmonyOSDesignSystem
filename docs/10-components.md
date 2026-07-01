# 10 Components · 组件规范

最大的章节。每个组件都遵循统一的 **规范模板**，所有取值引用 Token。

## 规范模板

每个组件按以下维度描述：

> 用途 · 尺寸 · Padding · 状态 · 颜色 · 圆角 · 阴影 · 动画 · 禁用 · 错误 · Hover · Pressed · Focused

## 组件清单

Button · TextField · Search · Card · List · Dialog · Toast · Tag · Badge · Tabs ·
BottomSheet · Checkbox · Radio · Switch · Slider · Progress · Avatar · Menu ·
Popover · DatePicker · Calendar · Loading · Empty · Error · Skeleton

## 实现：@riclava/designsystem 组件

上述规范已落地为可复用组件，全部从 `@riclava/designsystem` 导入。命名对照：

| 规范 | 组件 | 规范 | 组件 |
| --- | --- | --- | --- |
| Button | `AppButton` | Switch | `AppSwitch` |
| TextField | `AppTextField` | Slider | `AppSlider` |
| Search | `AppSearch` | Progress | `AppProgress` |
| Card | `AppCard` | Avatar | `AppAvatar` |
| List | `AppListItem` | Menu | `AppMenu` |
| Dialog | `AppDialog` | Popover | `AppPopover` |
| Toast | `AppToast`（工具类） | DatePicker | `AppDatePicker` |
| Tag / Badge | `AppTag` / `AppBadge` | Calendar | `AppCalendar` |
| Tabs | `AppTabs` | Loading / Empty / Error | `StateView` |
| BottomSheet | `AppSheet` | Skeleton | `Skeleton` |
| Checkbox / Radio | `AppCheckbox` / `AppRadioGroup` | | |

交互 / 容器类组件支持 **compact 紧凑密度**（收紧尺寸，字号行高不变，命中区仍 ≥ 44）；
详见 [16 Design Token](16-design-token.md)「密度 / Compact」小节。

---

## Button 按钮

- **用途**：触发操作。一屏一个主行动。
- **变体**：Primary（实心）/ Secondary（描边）/ Text（文字）/ Danger。
- **尺寸**：

| 尺寸 | 高度 | 水平 Padding | 字阶 | 圆角 |
| --- | --- | --- | --- | --- |
| Large | 48 | `SpaceLG` (24) | `Label` | `RadiusSM` |
| Medium | 40 | `SpaceMD` (16) | `Label` | `RadiusSM` |
| Small | 32 | `SpaceSM` (12) | `BodySmall` | `RadiusXS` |

- **颜色**：Primary = 底 `Primary` / 字 `OnPrimary`；Secondary = 边 `Outline` / 字 `Primary`。
- **阴影**：默认 `Level0`，浮起按钮 `Level2`。
- **状态**：Hover +8% / Pressed +12% / Focused +12%+Outline / Disabled 内容 38%。
- **动画**：Pressed 缩放 0.98，`MotionInstant`。
- **加载态**：显示 `Loading` 图标，禁用点击。

## TextField 输入框

- **用途**：单行/多行文本输入。
- **尺寸**：高度 48（单行），内边距 `SpaceMD`，圆角 `RadiusSM`。
- **结构**：Label（上）+ 输入区 + Helper/Error（下）+ 可选前后图标。
- **状态**：
  - Default：边框 `Outline`。
  - Focused：边框 `Primary`（2vp）+ Focused 叠加。
  - Error：边框 `Danger` + 底部错误文案（`Caption` / `Danger`）。
  - Disabled：背景 `Divider`，内容 38%。
- **动画**：Label 上浮 `MotionFast` / `EaseStandard`。

## Search 搜索框

- 基于 TextField，左侧 `IconSM` 搜索图标，右侧可清除。
- 圆角 `RadiusFull`（胶囊）或 `RadiusSM`（融入导航）。
- 背景 `Surface` 或 `Background` 的次级色。

## Card 卡片

- **用途**：聚合相关信息的容器。
- **内边距**：`SpaceMD`；圆角 `RadiusMD`；阴影 `Level1`。
- **可点击**：整卡可点，Pressed 时升 `Level2` + 12% 叠加。
- 内部元素间距 `SpaceXS` ~ `SpaceSM`。

## List 列表

- **列表项高度**：单行 56 / 双行 72 / 三行 88。
- 内边距左右 `SpaceMD`；项间分割线用 `Divider`（可选）。
- 左图标 `IconMD` + 文字（`Body` + `Caption`）+ 右附件（箭头/开关）。
- 项间距 `SpaceXS`（卡片式列表）。

## Dialog 对话框

- **用途**：需要用户决策的模态。
- 宽度：Compact 屏边距 `SpaceLG`；最大宽 400。
- 圆角 `RadiusLG`；阴影 `Level3`；遮罩 `Mask`。
- 结构：标题（`TitleLarge`）+ 正文（`Body`）+ 操作区（右下，主行动在右）。
- 动画：进入 缩放 0.9→1 + 淡入 `MotionNormal` / `EaseOut`。

## Toast 轻提示

- **用途**：非阻断的短暂反馈。
- 位置：底部或中部；圆角 `RadiusSM`；阴影 `Level2`。
- 时长：短 2s / 长 3.5s；无操作自动消失。
- 不承载关键决策，不带按钮（带按钮用 Snackbar/BottomSheet）。

## Tag 标签 / Badge 徽标

- **Tag**：高度 24，内边距 `SpaceXS`，圆角 `RadiusXS` 或 `RadiusFull`，字阶 `Caption`。
- **Badge**：小圆点（8vp）或数字（高 16，圆角 `RadiusFull`），色 `Danger`。

## Tabs 标签页

- 高度 48；选中项字 `Primary` + 2vp 底部指示条；未选中 `OnSurfaceVariant`。
- 指示条滑动动画 `MotionNormal` / `EaseStandard`。

## BottomSheet 底部面板

- 顶部圆角 `RadiusXL`；顶部拖拽条（32×4，`Outline`）。
- 阴影 `Level4`；遮罩 `Mask`；支持拖拽关闭（`EaseSpring`）。
- 进入 上滑 `MotionSlow` / `EaseOut`。

## Checkbox / Radio / Switch

- 命中区 ≥ 44×44；控件视觉尺寸 20~24。
- 选中色 `Primary`；未选边框 `Outline`；Disabled 38%。
- Switch 滑块圆角 `RadiusFull`，切换 `MotionInstant`。

## Slider 滑块

- 轨道高 4，圆角 `RadiusFull`；已选段 `Primary`，未选 `Outline`。
- 滑块 20，阴影 `Level1`；拖拽放大至 24。

## Progress 进度

- 线性：高 4，圆角 `RadiusFull`，`Primary` 前景。
- 环形：线宽 4，`Primary`；不确定态循环动画 `MotionSlow`。

## Avatar 头像

- 尺寸：24 / 32 / 40 / 48 / 64；圆角 `RadiusFull`（圆形）或 `RadiusMD`（方形）。
- 无图时显示首字母，背景取语义色。

## Menu / Popover

- 圆角 `RadiusMD`；阴影 `Level3`；内边距 `SpaceXS`。
- 项高 40；Hover/Pressed 叠加；分组用 `Divider`。
- 出现 淡入 + 缩放 0.95→1 `MotionFast` / `EaseOut`。

## DatePicker / Calendar

- 单元格命中 ≥ 44；今天描边 `Primary`；选中填充 `Primary` / 字 `OnPrimary`。
- 范围选择用 `PrimaryContainer` 填充连续区间。

## Loading / Empty / Error / Skeleton（状态页）

- **Loading**：环形指示器居中，可带 `Caption` 文案。
- **Empty**：`Icon2XL` 插画 + `TitleMedium` 标题 + `BodySmall` 说明 + 可选行动按钮。
- **Error**：同 Empty 结构，配 `Danger` 色图标 + 重试按钮。
- **Skeleton**：占位块用 `Divider` 底色 + 微光动画 `MotionExtraSlow` 循环，圆角同目标元素。

---

所有组件的具体取值均来自 [16 Design Token](16-design-token.md)，实现方式见 [17 Coding Specification](17-coding-specification.md)。

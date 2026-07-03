# 10 Components · 组件规范

最大的章节。每个组件都遵循统一的 **规范模板**，所有取值引用 Token。

## 规范模板

每个组件按以下维度描述：

> 用途 · 尺寸 · Padding · 状态 · 颜色 · 圆角 · 阴影 · 动画 · 禁用 · 错误 · Hover · Pressed · Focused

## 组件清单

Button · TextField · Search · Card · List · Dialog · Toast · Tag · Badge · Tabs ·
BottomSheet · Checkbox · Radio · Switch · Slider · Progress · Avatar · Menu ·
Popover · DatePicker · Calendar · Loading · Empty · Error · Skeleton ·
Select · Stepper · Segmented · Rating · Upload · FormItem · Divider · ChipGroup ·
NavBar · Breadcrumb · Pagination · Steps · Table · Accordion · Tree · Swiper · Tooltip

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
| Checkbox / Radio | `AppCheckbox` / `AppRadioGroup` | TimePicker | `AppTimePicker` |

交互 / 容器类组件支持三档密度 **`Density`**（Comfortable / Compact / SuperCompact，逐档收紧尺寸、内边距与字号/行高，命中区仍 ≥ 44）；
详见 [16 Design Token](16-design-token.md)「密度 / Density」小节。

---

## Button 按钮

- **用途**：触发操作。一屏一个主行动。
- **变体**：Primary（实心）/ Secondary（描边）/ Text（文字）/ Danger。
- **尺寸**：

| 尺寸 | 高度 | 水平 Padding | 字阶 | 圆角 |
| --- | --- | --- | --- | --- |
| Large | `Token.size.buttonLarge(density)` | `Token.space.lg` | `Token.font.label` | `Token.radius.sm` |
| Medium | `Token.size.buttonMedium(density)` | `Token.space.md` | `Token.font.label` | `Token.radius.sm` |
| Small | `Token.size.buttonSmall(density)` | `Token.space.sm` | `Token.font.bodySmall` | `Token.radius.xs` |

- **颜色**：Primary = 底 `Primary` / 字 `OnPrimary`；Secondary = 边 `Outline` / 字 `Primary`。
- **阴影**：默认 `Level0`，浮起按钮 `Level2`。
- **状态**：Hover +8% / Pressed +12% / Focused +12%+Outline / Disabled 内容 38%。
- **动画**：Pressed 缩放 0.98，`Token.motion.instant`。
- **加载态**：显示 `Loading` 图标，禁用点击。

## TextField 输入框

- **用途**：单行/多行文本输入。
- **尺寸**：高度 `Token.size.field(density)`（单行），内边距 `Token.space.md`，圆角 `Token.radius.sm`。
- **结构**：Label（上）+ 输入区 + Helper/Error（下）+ 可选前后图标。
- **状态**：
  - Default：边框 `Outline`。
  - Focused：边框 `Primary`（2vp）+ Focused 叠加。
  - Error：边框 `Danger` + 底部错误文案（`Caption` / `Danger`）。
  - Disabled：背景 `Divider`，内容 38%。
- **动画**：Label 上浮 `Token.motion.fast` / `Token.motion.easeStandard`。

## Search 搜索框

- 基于 TextField，左侧 `Token.icon.sm` 搜索图标，右侧可清除。
- 圆角 `Token.radius.full`（胶囊）或 `Token.radius.sm`（融入导航）。
- 背景 `Surface` 或 `Background` 的次级色。

## Card 卡片

- **用途**：聚合相关信息的容器。
- **内边距**：`Token.space.md`；圆角 `Token.radius.md`；阴影 `Level1`。
- **可点击**：整卡可点，Pressed 时升 `Level2` + 12% 叠加。
- 内部元素间距 `Token.space.xs` ~ `Token.space.sm`。

## List 列表

- **列表项高度**：最小高度 `Token.size.rowMin(density)`，双行/三行由内容自然撑开。
- 内边距左右 `Token.space.md`；项间分割线用 `Divider`（可选）。
- 左图标 `Token.icon.md` + 文字（`Body` + `Caption`）+ 右附件（箭头/开关）。
- 项间距 `Token.space.xs`（卡片式列表）。

## Dialog 对话框

- **用途**：需要用户决策的模态。
- 宽度：Compact 屏边距 `Token.space.lg`；最大宽 `Token.size.dialogMaxWidth`。
- 圆角 `Token.radius.lg`；阴影 `Level3`；遮罩 `Mask`。
- 结构：标题（`TitleLarge`）+ 正文（`Body`）+ 操作区（右下，主行动在右）。
- 动画：进入 缩放 0.9→1 + 淡入 `Token.motion.normal` / `Token.motion.easeOut`。

## Toast 轻提示

- **用途**：非阻断的短暂反馈。
- 位置：底部或中部；圆角 `Token.radius.sm`；阴影 `Level2`。
- 时长：短 2s / 长 3.5s；无操作自动消失。
- 不承载关键决策，不带按钮（带按钮用 Snackbar/BottomSheet）。

## Tag 标签 / Badge 徽标

- **Tag**：高度 `Token.size.tagHeight`，内边距 `Token.space.xs`，圆角 `Token.radius.xs` 或 `Token.radius.full`，字阶 `Token.font.caption`。
- **Badge**：小圆点 `Token.size.badgeDot` 或数字（高 `Token.size.badgeMin`，圆角 `Token.radius.full`），色 `Danger`。

## Tabs 标签页

- 高度 48；选中项字 `Primary` + 2vp 底部指示条；未选中 `OnSurfaceVariant`。
- 指示条滑动动画 `Token.motion.normal` / `Token.motion.easeStandard`。

## BottomSheet 底部面板

- 顶部圆角 `Token.radius.xl`；顶部拖拽条（`Token.size.sheetHandleWidth` × `Token.size.sheetHandleHeight`，`Outline`）。
- 阴影 `Level4`；遮罩 `Mask`；拖拽关闭使用系统组件默认弹性反馈。
- 进入 上滑 `Token.motion.slow` / `Token.motion.easeOut`。

## Checkbox / Radio / Switch

- 命中区 ≥ 44×44；控件视觉尺寸 20~24。
- 选中色 `Primary`；未选边框 `Outline`；Disabled 38%。
- Switch 滑块圆角 `Token.radius.full`，切换 `Token.motion.instant`。

## Slider 滑块

- 轨道高 `Token.size.progressTrack`，圆角 `Token.radius.full`；已选段 `Primary`，未选 `Outline`。
- 滑块 20，阴影 `Level1`；拖拽放大至 24。

## Progress 进度

- 线性：高 `Token.size.progressTrack`，圆角 `Token.radius.full`，`Primary` 前景。
- 环形：尺寸 `Token.size.progressRing`，`Primary`；不确定态循环动画 `Token.motion.slow`。

## Avatar 头像

- 尺寸：`Token.size.avatarXs/sm/md/lg/xl`；圆角 `Token.radius.full`（圆形）或 `Token.radius.md`（方形）。
- 无图时显示首字母，背景取语义色。

## Menu / Popover

- 圆角 `Token.radius.md`；阴影 `Level3`；内边距 `Token.space.xs`。
- 项高 `Token.size.menuItem(density)`；菜单最小宽 `Token.size.menuMinWidth`；Popover 最大宽 `Token.size.popoverMaxWidth`。
- 出现 淡入 + 缩放 0.95→1 `Token.motion.fast` / `Token.motion.easeOut`。

## DatePicker / Calendar

- 单元格命中 ≥ 44；今天描边 `Primary`；选中填充 `Primary` / 字 `OnPrimary`。
- 范围选择用 `PrimaryContainer` 填充连续区间。

## Loading / Empty / Error / Skeleton（状态页）

- **Loading**：环形指示器居中，可带 `Caption` 文案。
- **Empty**：`Token.icon.xxl` 插画 + `TitleMedium` 标题 + `BodySmall` 说明 + 可选行动按钮。
- **Error**：同 Empty 结构，配 `Danger` 色图标 + 重试按钮。
- **Skeleton**：占位块用 `Divider` 底色 + 微光动画 `Token.motion.extraSlow` 循环，圆角同目标元素。

---

## 扩展组件（P2）

以下组件遵循同一 Token 与无障碍约束（深浅色、密度 Density、命中区 ≥ 44、逻辑方向 start/end），全部从 `@riclava/designsystem` 导入。

### 表单 / 录入

| 组件 | 用途 | 关键属性 |
| --- | --- | --- |
| `AppSelect` | 下拉单选（封装系统 Select 主题化） | `options` `selectedIndex` `placeholder` `onSelectIndex` |
| `AppStepper` | 数字步进（±，受 min/max/step 约束） | `value` `min` `max` `step` `onChange` |
| `AppSegmented` | 分段控制（同级视图切换） | `segments` `selectedIndex` `onSelect` |
| `AppRating` | 星级评分 | `rating` `max` `ratingReadonly` `onRate` |
| `AppUpload` | 上传占位（业务接系统 Picker） | `files` `onAdd` `onRemove` |
| `AppFormItem` | 表单项容器（Label + 必填 + 插槽 + Error） | `label` `required` `error` `helper` + `content` |
| `AppChipGroup` | 可删除标签组（自动换行） | `chips` `onDelete` |

### 导航

| 组件 | 用途 | 关键属性 |
| --- | --- | --- |
| `AppNavBar` | 顶部导航栏（返回 + 标题 + 尾部插槽） | `title` `showBack` `onBack` + `trailing?` |
| `AppBreadcrumb` | 面包屑（末项为当前，RTL 镜像） | `items` `onSelect` |
| `AppPagination` | 分页器（窗口化页码） | `current` `pageCount` `maxButtons` `onChange` |
| `AppSteps` | 步骤条（序号 + 连接线 + 标签） | `steps` `current` |

### 数据展示

| 组件 | 用途 | 关键属性 |
| --- | --- | --- |
| `AppTable` | 轻量表格（表头 + 行，随密度收紧） | `columns`（`AppTableColumn`）`rows` |
| `AppAccordion` | 折叠面板（标题切换 + 内容插槽） | `title` `expanded` `onToggle` + `content` |
| `AppTree` | 树形控件（可展开层级列表） | `nodes`（`AppTreeNode`）`onSelect` |
| `AppSwiper` | 轮播容器（封装系统 Swiper） | `autoPlay` `interval` `loop` + `pages` |

### 通用

| 组件 | 用途 | 关键属性 |
| --- | --- | --- |
| `AppDivider` | 分割线（水平/带文字/垂直） | `text` `vertical` |
| `AppTooltip` | 文字提示气泡（点按触发） | `message` `placement` + `content` |

---

所有组件的具体取值均来自 [16 Design Token](16-design-token.md)，实现方式见 [17 Coding Specification](17-coding-specification.md)。

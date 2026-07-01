# 18 · 国际化（Internationalization / i18n）

本设计系统面向多语言与 RTL（从右到左）场景。核心原则：**文案外置、方向逻辑化、格式区域化**。

## 18.1 三条铁律

1. **文案外置**：面向用户的文字不硬编码，走资源 `$r('app.string.*')`。
2. **逻辑方向**：布局用 `start / end`，不用物理 `left / right`；文本对齐用 `TextAlign.Start / End`。
3. **区域化格式**：日期 / 时间 / 数字用 `intl`（`@kit.LocalizationKit`）按系统区域格式化，不手拼字符串。

## 18.2 文案资源化

组件内置的默认文案已资源化，放在库的 `library/src/main/resources`：

- `base/element/string.json`：默认语言（中文）。
- `en_US/element/string.json`：英文覆盖。

内置键（前缀 `ds_` 避免与宿主 App 命名冲突）：

| 键 | 中文 | 英文 |
| --- | --- | --- |
| `ds_dialog_confirm` | 确认 | Confirm |
| `ds_dialog_cancel` | 取消 | Cancel |
| `ds_search_placeholder` | 搜索… | Search… |
| `ds_search_clear` | 清除 | Clear |
| `ds_time_placeholder` | 选择时间 | Select time |

组件中这些文案的 Prop 类型为 `ResourceStr`，默认值为 `$r('app.string.ds_*')`，调用方可覆盖：

```ts
// 用内置本地化默认值
AppDialog({ title: '删除', message: '确认删除？' })

// 覆盖为自己的资源（推荐）或纯字符串
AppDialog({ confirmLabel: $r('app.string.my_delete'), cancelLabel: '再想想' })
```

业务侧新增语言：在 App 工程补 `resources/<locale>/element/string.json`（如 `zh_CN`、`en_US`、`ar` 等），把用户可见文案都放进去，用 `$r('app.string.xxx')` 引用。

## 18.3 RTL：逻辑方向

物理方向（`left/right`）在阿拉伯语 / 希伯来语等 RTL 语言下不会镜像。统一改用逻辑方向：

```ts
import { LengthMetrics } from '@kit.ArkUI';

// ❌ 禁止
.padding({ left: Token.space.md, right: Token.space.xs })
.margin({ left: Token.space.sm })

// ✅ 正确（LTR 下 start=左、end=右；RTL 下自动镜像）
.padding({ start: LengthMetrics.vp(Token.space.md), end: LengthMetrics.vp(Token.space.xs) })
.margin({ start: LengthMetrics.vp(Token.space.sm) })
```

- 文本对齐：用 `TextAlign.Start / End`，禁用 `Left / Right`。
- 行 / 列内元素顺序：RTL 下由系统自动镜像，**不要**手动交换左右。
- 方向性图标（箭头、返回等）需要镜像：用 `isRTL()` 判定后选择字形 / 资源。

```ts
import { isRTL } from '@riclava/designsystem';
Text(isRTL() ? '‹' : '›')   // 列表箭头随语言方向
```

> `AppListItem` 的箭头已内置该逻辑。`start/end` 的镜像由框架完成，`isRTL()` 只用于图标字形选择。

## 18.4 区域化格式：日期 / 时间 / 数字

不要手拼时间字符串（AM/PM、次序在不同语言中不同）。用 `intl`：

```ts
import { i18n, intl } from '@kit.LocalizationKit';

const options: intl.DateTimeOptions = { hour: '2-digit', minute: '2-digit', hour12: true };
const fmt = new intl.DateTimeFormat(i18n.System.getSystemLocale(), options);
fmt.format(new Date());   // en-US: "3:05 PM"；zh-CN: "下午3:05"
```

- `AppTimePicker` 的字段展示已改用 `intl.DateTimeFormat`（AM/PM 与次序随语言）。
- `AppDatePicker` / `AppCalendar` 直接用系统 `DatePicker` / `CalendarPicker`，自带区域化。
- 数字 / 百分比 / 货币用 `intl.NumberFormat`。

## 18.5 提供的工具

- `isRTL(): boolean` — 当前系统语言是否 RTL（从 `@riclava/designsystem` 导出）。仅用于镜像方向性图标。

## 18.6 检查清单

- [ ] 无硬编码用户可见文案（全部 `$r('app.string.*')`）。
- [ ] 无 `left/right` 内外边距，无 `TextAlign.Left/Right`。
- [ ] 方向性图标已按 `isRTL()` 镜像。
- [ ] 日期 / 时间 / 数字经 `intl` 或系统组件格式化。
- [ ] 目标语言的 `string.json` 已补齐。

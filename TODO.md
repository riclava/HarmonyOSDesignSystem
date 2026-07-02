# TODO — 专业化路线图

现状：Token 单一事实来源 + 生成器、24 组件、18 篇规范、showcase、AI 接入规则。
已完成 **P0（工程化质量门禁）** 与 **P1（发布与协作治理）**，见 `CHANGELOG.md`。

下面是 P2 / P3 / P4 规划。优先级：P2 > P3 > P4。

---

## P2 — 组件覆盖度

现有 24 个组件偏基础，补齐专业体系常见组件。每个组件遵循 `CONTRIBUTING.md` 的验收标准（Token、深浅色、compact、无障碍、i18n、showcase、文档）。

### 高优先（表单 / 数据录入）
- [ ] `AppSelect` 下拉选择（单选/多选，支持搜索）
- [ ] `AppStepper` 数字步进器（+/- 与输入）
- [ ] `AppSegmented` 分段控制器
- [ ] `AppForm` 表单校验容器（统一校验、错误态、必填标记）
- [ ] `AppRating` 评分
- [ ] `AppUpload` 文件/图片上传

### 中优先（数据展示 / 导航）
- [ ] `AppTable` / `AppDataGrid` 表格（排序、固定列、compact 密度）
- [ ] `AppPagination` 分页
- [ ] `AppAccordion` / `AppCollapse` 折叠面板
- [ ] `AppSteps` 步骤条
- [ ] `AppBreadcrumb` 面包屑
- [ ] `AppNavBar` 顶栏 / `AppToolbar`
- [ ] `AppDivider` 分割线（含带文字）

### 低优先（增强）
- [ ] `AppTooltip` 文字提示（区别于已有 `AppPopover`）
- [ ] `AppSwiper` / 轮播
- [ ] `AppChipGroup` 可删除标签组
- [ ] `AppTree` 树形控件

> 交付建议：按「高→中→低」分批，每批一个 PR 一组相关组件，同步更新 showcase 分类页与 `docs/10-components.md`。

---

## P3 — 主题与品牌化（多品牌换肤）

当前是单一品牌（固定主色）+ 深浅两套值。让同一套结构支持多 App 换肤。

- [ ] 抽象「品牌」层：将 `primary / secondary` 等品牌色从固定值改为可注入的 **brand token 组**。
- [ ] `tokens/design-tokens.json` 支持多主题（如 `brand.default` / `brand.xxx`），生成器按主题产出多套色值。
- [ ] 运行时主题切换 API：`initTheme(brandId)` + `Token.color.*()` 按当前 brand + 深浅色解析（现有 `isDark` 机制扩展为 `theme + isDark` 二维）。
- [ ] showcase 增加「品牌切换」演示（default / 自定义品牌实时切换）。
- [ ] 文档：`docs/` 增补「主题与品牌化」章节 + 接入指南（新 App 如何定义自己的品牌色）。
- [ ] 校验：对每套品牌运行对比度检查（见 P4 对比度门禁）。

---

## P4 — Token 工具链与文档自动化

让「设计-开发共享 Token」形成真正闭环，减少手工维护。

### 设计侧闭环
- [ ] 对接 **Style Dictionary** 或 Figma Tokens 插件：`tokens/design-tokens.json` ↔ Figma 双向同步。
- [ ] 提供 Figma 可导入格式导出（W3C Design Tokens 已基本对齐，补导出脚本）。

### 文档自动化
- [ ] 组件 **API 文档自动生成**：从 `.ets` 的 `@Prop` / 枚举解析出 props 表，注入 `docs/10-components.md`。
- [ ] Token 变更 **diff 可视化**：PR 中对 `design-tokens.json` 变更生成人类可读的色值/尺寸对比。
- [ ] 自动生成 Token 速查表（README / AGENTS.md 的表格由脚本产出，避免漂移）。

### 门禁与发布增强（P0/P1 的延伸）
- [ ] **对比度门禁转为阻断**：先决定 primary/danger 按钮文案按「大文本/UI 组件」阈值（WCAG 3.0）还是修正品牌色达到 4.5，再把 `contrast:check` 设为 CI 硬门禁（当前非阻断）。
- [ ] 自动化发布：打 tag 触发 CI 构建 HAR 并 `ohpm publish`（见 `docs/PUBLISHING.md`）。
- [ ] 无障碍自动检查扩展：命中区尺寸、`accessibilityText` 缺失的静态扫描规则（并入 `lint-hardcode.mjs` 或独立扫描器）。

---

## P0 遗留（需你拍板）

`npm run contrast:check` 当前对以下浅色组合低于 WCAG AA 4.5：

- `primary/onPrimary` 3.98、`danger/onPrimary` 3.55（按钮文案，可能适用大文本/UI 3.0 阈值）
- `success/warning/info` 于 surface 上（多用于图标/状态点，非正文）

两条路线（见 P4 对比度门禁）：**(a)** 微调品牌色达到 4.5；**(b)** 对 UI/大文本组合采用 3.0 阈值并在门禁中区分。定后即可把对比度设为 CI 硬门禁。

# TODO — 专业化路线图

现状：Token 单一事实来源 + 生成器、24 组件、18 篇规范、showcase、AI 接入规则。
已完成 **P0（工程化质量门禁）** 与 **P1（发布与协作治理）**，见 `CHANGELOG.md`。

下面是 P2 / P3 / P4 规划。优先级：P2 > P3 > P4。

---

## P2 — 组件覆盖度 ✅（已实现，待真机编译验证 + showcase 接入）

已按 `CONTRIBUTING.md` 约定实现并从 `@riclava/designsystem` 导出。仅使用 Token，通过 `lint:hardcode`。

### 高优先（表单 / 数据录入）
- [x] `AppSelect` 下拉选择（封装系统 Select 主题化）
- [x] `AppStepper` 数字步进器（±，min/max/step）
- [x] `AppSegmented` 分段控制器
- [x] `AppFormItem` 表单项容器（Label + 必填 + 插槽 + Error）
- [x] `AppRating` 评分
- [x] `AppUpload` 上传占位（业务接系统 Picker）

### 中优先（数据展示 / 导航）
- [x] `AppTable` 轻量表格（`AppTableColumn`，compact 密度）
- [x] `AppPagination` 分页
- [x] `AppAccordion` 折叠面板
- [x] `AppSteps` 步骤条
- [x] `AppBreadcrumb` 面包屑（RTL 镜像）
- [x] `AppNavBar` 顶栏
- [x] `AppDivider` 分割线（含带文字 / 垂直）

### 低优先（增强）
- [x] `AppTooltip` 文字提示气泡
- [x] `AppSwiper` 轮播容器
- [x] `AppChipGroup` 可删除标签组
- [x] `AppTree` 树形控件（`AppTreeNode`，可展开）

### 收尾（P2 剩余）
- [ ] **真机 / DevEco 编译验证**：本批组件在无 ArkTS 编译器环境下编写，需 IDE 编译确认（重点：可选 `@BuilderParam`、系统 `Select`/`Swiper` API、`sys.symbol.*` 图标名）。
- [ ] **showcase 接入**：把新组件加入对应 section 页并加深浅色/compact 演示。
- [ ] 视觉回归 / 快照测试（依赖 P0 测试体系扩展）。

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
- [x] **对比度门禁转为阻断**：Light 值已按 WCAG 调校（`primary/danger/info` ≥ 4.5 文本、`success/warning` ≥ 3.0 非文本），`contrast:check` 已是 CI 硬门禁。
- [ ] 自动化发布：打 tag 触发 CI 构建 HAR 并 `ohpm publish`（见 `docs/PUBLISHING.md`）。
- [ ] 无障碍自动检查扩展：命中区尺寸、`accessibilityText` 缺失的静态扫描规则（并入 `lint-hardcode.mjs` 或独立扫描器）。

---

## 已完成

- **P0 遗留（对比度）**：Light 模式 `primary #126AFF / danger #EA0C00 / info #0072E5`（≥ 4.5 文本），`success #2CA74B / warning #D17F00`（≥ 3.0 状态指示），保持色相。对比度校验转为 CI 硬门禁并加回归测试。

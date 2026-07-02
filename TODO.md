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
- [x] **showcase 接入**：新增 `ExtrasSection` 演示全部 17 个组件，接入 Components 页。
- [ ] 视觉回归 / 快照测试（依赖 P0 测试体系扩展）。

---

## P3 — 主题与品牌化（多品牌换肤）✅（基础设施 + 示例品牌已落地）

当前是单一品牌（固定主色）+ 深浅两套值。让同一套结构支持多 App 换肤。

- [x] 抽象「品牌」层：主色族（`primary` / `primaryContainer` / `onPrimary`）通过 `$extensions.brands.<id>` 注入品牌覆盖值。
- [x] `tokens/design-tokens.json` 支持多主题：生成器对带品牌覆盖的颜色产出 `currentBrand()` 分支（无覆盖零开销、向后兼容）。
- [x] 运行时主题切换 API：`initTheme(brand, colorMode)` / `setBrand(id)` / `currentBrand()`；组件持有 `@StorageLink('brand')` 实现全量重绘（与 `isDark` 同机制）。
- [x] showcase 增加「品牌切换」演示（蓝 / 紫 实时切换）。
- [x] 文档：`docs/19-theming.md` 主题与品牌化 + 新增品牌接入指南；README / AGENTS / steering 同步。
- [x] 校验：对比度门禁逐品牌校验（新增品牌不达标即 CI 失败）。
- [ ] 更多品牌色族覆盖（`secondary` / 语义色）与品牌级 `color.json` 资源导出（供 `$r('app.color.*')` 也换肤）。
- [ ] 品牌切换动画过渡（颜色渐变）。

---

## P4 — Token 工具链与文档自动化 ✅（核心已落地）

让「设计-开发共享 Token」形成真正闭环，减少手工维护。

### 设计侧闭环
- [x] `npm run tokens:export` 导出 `tokens/build/`（扁平 JSON + CSS 变量，无第三方依赖）。
- [x] `tokens/style-dictionary.config.json`：`design-tokens.json` 已是 W3C DTCG，Tokens Studio（Figma）/ Style Dictionary 可直接消费。
- [ ] Figma ↔ 仓库双向自动同步（CI webhook / Tokens Studio sync），当前为单向导出 + 手动导入。

### 文档自动化
- [x] 组件 **API 文档自动生成**：`tools/docs.mjs` 从 `.ets` 解析 `@Prop`/事件/`@BuilderParam`/枚举 → `docs/generated/components-api.md`，`docs:check` 门禁。
- [x] 自动生成 **Token 速查表** → `docs/generated/token-reference.md`（含品牌覆盖列）。
- [ ] Token 变更 **diff 可视化**（PR 中人类可读的色值/尺寸对比）。

### 门禁与发布增强
- [x] 对比度门禁转为阻断（逐品牌）。
- [x] **无障碍静态扫描**：`tools/lint-a11y.mjs` 检测无 `accessibilityText` 的图标按钮，`lint:a11y` 硬门禁。
- [x] 发布 workflow 脚手架 `.github/workflows/release.yml`（tag 触发跑门禁 + 建 Release；HAR 构建 / `ohpm publish` 需带 HarmonyOS SDK 的 runner，已留占位）。
- [ ] 接入自建/自托管 runner 完成 HAR 自动构建与 OHPM 发布。

> 注：`.github/workflows/*.yml` 需带 `workflow` scope 的凭据才能推送（见下）。

---

## 已完成

- **P0 遗留（对比度）**：Light 模式 `primary #126AFF / danger #EA0C00 / info #0072E5`（≥ 4.5 文本），`success #2CA74B / warning #D17F00`（≥ 3.0 状态指示），保持色相。对比度校验转为 CI 硬门禁并加回归测试。

# Changelog

本项目遵循 [语义化版本](https://semver.org/lang/zh-CN/)（SemVer）。

变更类型：`Added` 新增 / `Changed` 变更 / `Deprecated` 废弃 / `Removed` 移除 / `Fixed` 修复 / `Security` 安全。

Token 变更规则：新增 Token → minor；破坏性变更（重命名/删除/改值影响视觉）→ major；修复不影响使用的取值 → patch。

## [Unreleased]

### Added
- **P0 对比度门禁**：Light 模式语义色按 WCAG 调校（保持色相）——`primary #126AFF`、`danger #EA0C00`、`info #0072E5`（文本 ≥ 4.5），`success #2CA74B`、`warning #D17F00`（状态指示 ≥ 3.0）。对比度校验（文本 4.5 / 非文本 3.0）转为 CI 硬门禁并加回归测试。
- **P2 扩展组件（17 个）**：`AppSelect` `AppStepper` `AppSegmented` `AppRating` `AppUpload` `AppFormItem` `AppChipGroup` `AppDivider` `AppNavBar` `AppBreadcrumb` `AppPagination` `AppSteps` `AppTable`（含 `AppTableColumn`）`AppAccordion` `AppTree`（含 `AppTreeNode`）`AppSwiper` `AppTooltip`。全部从 `@riclava/designsystem` 导出，遵循 Token / 深浅色 / compact / 无障碍 / i18n 约定；showcase 新增 `ExtrasSection` 演示。
- **P3 多品牌换肤（基础设施 + 示例品牌 `violet`）**：Token 通过 `$extensions.brands.<id>` 注入品牌覆盖值；生成器产出 `currentBrand()` 分支（向后兼容、无覆盖零开销）；新增运行时 API `initTheme` / `setBrand` / `currentBrand`；全部组件持有 `@StorageLink('brand')` 实现实时换肤；对比度门禁逐品牌校验；新增 `docs/19-theming.md`；showcase 顶栏加「蓝 / 紫」品牌切换。
- 新组件默认文案资源（`ds_stepper_*` `ds_upload_*` `ds_pagination_*` `ds_navbar_back` `ds_chip_remove`），含 `en_US`。
- 工程化质量门禁：`tools/lint-hardcode.mjs` 硬编码扫描（禁止字面量颜色/字号/字重/行高/间距/圆角）。
- Token 工具链单元测试（`tools/design-system.test.mjs`）与扫描器测试（`tools/lint-hardcode.test.mjs`）。
- 根 `package.json` 脚本：`tokens:generate` / `tokens:check` / `contrast:check` / `lint:hardcode` / `test` / `verify`。
- GitHub Actions CI（`.github/workflows/ci.yml`）：Token 同步、对比度、硬编码、单测全部硬门禁。
- 项目治理：`LICENSE`、`CONTRIBUTING.md`、Issue/PR 模板、`docs/PUBLISHING.md`。
- `TODO.md`：P2（组件补齐）/ P3（多品牌换肤）/ P4（Token 工具链与文档自动化）路线图。

### Changed
- `tools/design-system.mjs` 重构为可导入模块（导出纯函数），CLI 仅在直接执行时运行。
- 文档同步新色值：`docs/02-color.md`、`docs/14-dark-mode.md`、`docs/16-design-token.md`；showcase 资源色与应用图标。
- `docs/10-components.md`、`AGENTS.md`、Kiro steering 补齐新组件清单与导入示例。

## [1.0.0]

### Added
- Token 单一事实来源（`tokens/design-tokens.json`）与 ArkTS 运行时生成器。
- 24 个组件、18 篇规范文档、showcase 活文档 App。
- AI 接入规则（`AGENTS.md` / `.kiro/steering`）、i18n / 深浅色 / compact 支持。

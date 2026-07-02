# Changelog

本项目遵循 [语义化版本](https://semver.org/lang/zh-CN/)（SemVer）。

变更类型：`Added` 新增 / `Changed` 变更 / `Deprecated` 废弃 / `Removed` 移除 / `Fixed` 修复 / `Security` 安全。

Token 变更规则：新增 Token → minor；破坏性变更（重命名/删除/改值影响视觉）→ major；修复不影响使用的取值 → patch。

## [Unreleased]

### Added
- 工程化质量门禁：`tools/lint-hardcode.mjs` 硬编码扫描（禁止字面量颜色/字号/字重/行高/间距/圆角）。
- Token 工具链单元测试（`tools/design-system.test.mjs`）与扫描器测试（`tools/lint-hardcode.test.mjs`）。
- 根 `package.json` 脚本：`tokens:generate` / `tokens:check` / `contrast:check` / `lint:hardcode` / `test` / `verify`。
- GitHub Actions CI（`.github/workflows/ci.yml`）：Token 同步、硬编码、单测门禁 + 对比度报告。
- 项目治理：`LICENSE`、`CONTRIBUTING.md`、Issue/PR 模板、`docs/PUBLISHING.md`。
- `TODO.md`：P2（组件补齐）/ P3（多品牌换肤）/ P4（Token 工具链与文档自动化）路线图。

### Changed
- `tools/design-system.mjs` 重构为可导入模块（导出纯函数），CLI 仅在直接执行时运行。

## [1.0.0]

### Added
- Token 单一事实来源（`tokens/design-tokens.json`）与 ArkTS 运行时生成器。
- 24 个组件、18 篇规范文档、showcase 活文档 App。
- AI 接入规则（`AGENTS.md` / `.kiro/steering`）、i18n / 深浅色 / compact 支持。

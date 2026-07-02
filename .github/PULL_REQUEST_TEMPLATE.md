## 变更说明

<!-- 这个 PR 做了什么，为什么 -->

## 变更类型

- [ ] 新增组件 / 能力（minor）
- [ ] Bug 修复（patch）
- [ ] Token 变更
- [ ] 文档 / 工具链
- [ ] 破坏性变更（major）

## 检查清单

- [ ] `npm run verify` 全绿（token 同步 + 硬编码扫描 + 单测）
- [ ] 未硬编码颜色/字号/间距/圆角，仅使用 `Token.*`
- [ ] 若改 Token：只改 `tokens/design-tokens.json` 后 `npm run tokens:generate`，未手改生成物
- [ ] 支持深浅色与 compact，命中区 ≥ 44×44vp
- [ ] 面向用户文案已资源化并补齐目标语言
- [ ] 已更新 `CHANGELOG.md` 的 `[Unreleased]`
- [ ] 若新增/改动组件：已更新 showcase 与 `docs/10-components.md`

## 关联 Issue

<!-- Closes #xxx -->

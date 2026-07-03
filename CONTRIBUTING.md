# 贡献指南

感谢参与 HarmonyOS Design System。本文档说明如何提交改动、Token 与组件的验收标准，以及发布流程。

## 核心原则

所有颜色 / 字号 / 行高 / 字重 / 间距 / 圆角 / 阴影 / 动画时长**必须来自 Token**，禁止硬编码。完整规则见 [AGENTS.md](AGENTS.md)。

## 本地开发

需要 Node.js ≥ 18（CI 使用 22）。

```bash
npm run tokens:generate   # 从 tokens/design-tokens.json 重新生成 Tokens.ets 与 color.json
npm run verify            # 一次性跑全部门禁：token 同步 + 硬编码扫描 + 单测
```

单项命令：

| 命令 | 作用 |
| --- | --- |
| `npm run tokens:check` | 校验生成物与 `tokens/design-tokens.json` 一致 |
| `npm run contrast:check` | WCAG 对比度报告（当前非阻断，见 TODO.md） |
| `npm run lint:hardcode` | 扫描 `.ets` 中的硬编码设计值 |
| `npm test` | 工具链单元测试 |

## 提交前检查清单

1. `npm run verify` 全绿。
2. 若改了 **Token**：只改 `tokens/design-tokens.json`，然后 `npm run tokens:generate`，**不要手改** `Tokens.ets` / `color.json`。
3. 面向用户文案已资源化（`$r('app.string.*')`），并补齐 `en_US` 等目标语言。
4. 更新 `CHANGELOG.md` 的 `[Unreleased]` 段。

## 新增组件验收标准

新组件（`library/src/main/ets/components/AppXxx.ets`）合入前需满足：

- [ ] 仅使用 `Token.*`，通过 `npm run lint:hardcode`。
- [ ] 支持深浅色：持有 `@StorageLink('isDark')`，颜色走 `Token.color.*()`。
- [ ] 支持密度：持有 `@StorageProp('density') density: Density`，尺寸走 `Token.size.*(this.density)`，字体走 `Token.font.*.sizeFor(this.density)`，并在 `build` 内直接引用 `this.density`（三档 Comfortable/Compact/SuperCompact）。
- [ ] 命中区 ≥ 44×44vp（紧凑 / 超紧凑下用 `.responseRegion` 兜底）。
- [ ] 图标按钮带 `.accessibilityText(...)`；信息不只靠颜色传达。
- [ ] 内外边距用逻辑方向 `start/end`（`LengthMetrics.vp`），文本对齐用 `TextAlign.Start/End`。
- [ ] 在 `library/Index.ets` 导出，并在 showcase 中新增展示。
- [ ] 更新 `docs/10-components.md` 与 `CHANGELOG.md`。

## 分支与提交

- 从 `main` 切分支：`feat/xxx`、`fix/xxx`、`docs/xxx`。
- 提交信息建议遵循 [Conventional Commits](https://www.conventionalcommits.org/)：`feat(button): ...`、`fix(tokens): ...`。
- PR 请填写模板并确保 CI 通过。

## 发布

发布与版本流程见 [docs/PUBLISHING.md](docs/PUBLISHING.md)。

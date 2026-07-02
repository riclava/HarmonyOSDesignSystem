# 发布流程（Publishing）

`@riclava/designsystem` 以 HAR 形式发布，供外部 HarmonyOS App 通过 OHPM 安装。

## 版本策略（SemVer）

- **major**：破坏性变更（组件 API 变更、Token 重命名/删除、影响视觉的取值调整）。
- **minor**：新增组件、新增 Token、向后兼容的能力。
- **patch**：修复、不影响使用的内部调整。

Token 变更须先改 `tokens/design-tokens.json` 再 `npm run tokens:generate`，二者与生成物一并提交。

## 发布步骤

1. 确认 `main` 上 `npm run verify` 全绿。
2. 更新版本号：`library/oh-package.json5` 的 `version` 与根 `package.json` 保持一致。
3. 在 `CHANGELOG.md` 把 `[Unreleased]` 固化为新版本号与日期。
4. 提交并打 tag：

   ```bash
   git commit -am "release: vX.Y.Z"
   git tag vX.Y.Z
   git push origin main --tags
   ```

5. 构建并发布 HAR（在 DevEco Studio 或 hvigor 中）：

   ```bash
   # 构建 library 模块产物（.har）
   hvigorw --mode module -p module=library@default assembleHar

   # 登录并发布到 OHPM（需已配置 ohpm 凭据）
   ohpm publish library/build/default/outputs/default/library.har
   ```

   > 具体产物路径以本地 hvigor 输出为准；首次发布需在 OHPM 官网注册组织/包名。

6. 在 GitHub 基于该 tag 创建 Release，粘贴 CHANGELOG 对应段落。

## 消费方接入

```json5
// 消费方 oh-package.json5
"dependencies": {
  "@riclava/designsystem": "^X.Y.Z"   // 或本地开发用 "file:../HarmonyOSDesignSystem/library"
}
```

## 待办

CI 目前只做质量门禁，尚未自动发布。自动化发布（tag 触发构建 + OHPM publish）列入 TODO.md P4。

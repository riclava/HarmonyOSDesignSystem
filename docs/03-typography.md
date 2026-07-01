# 03 Typography · 字体规范

字体全部 Token 化。字族统一使用 **HarmonyOS Sans**（数字/等宽场景可用 `HarmonyOS Sans SC Mono`）。

## 字阶 Token

| Token | Size (fp) | Line Height | Weight | 用途 |
| --- | --- | --- | --- | --- |
| `DisplayLarge` | 48 | 56 | Bold (700) | 大标题 / 营销页 |
| `DisplayMedium` | 36 | 44 | Bold (700) | 页面主标题 |
| `HeadlineLarge` (H1) | 30 | 38 | Semibold (600) | 一级标题 |
| `HeadlineMedium` (H2) | 24 | 32 | Semibold (600) | 二级标题 |
| `TitleLarge` (H3) | 20 | 28 | Medium (500) | 卡片 / 区块标题 |
| `TitleMedium` (H4) | 18 | 26 | Medium (500) | 小节标题 |
| `Body` | 16 | 24 | Regular (400) | 正文 |
| `BodySmall` | 14 | 20 | Regular (400) | 次要正文 |
| `Label` | 14 | 20 | Medium (500) | 按钮 / 标签文字 |
| `Caption` | 12 | 16 | Regular (400) | 辅助说明 / 时间戳 |

## 字重

| Token | 值 |
| --- | --- |
| `WeightRegular` | 400 |
| `WeightMedium` | 500 |
| `WeightSemibold` | 600 |
| `WeightBold` | 700 |

## 使用规则

- 单位使用 **fp**（font pixel），随系统字体缩放而变化，禁止使用固定 `px`。
- 一个界面层级不超过 4 级（Display/Headline/Title/Body）。
- 行高与字号绑定成对使用，不单独覆盖行高。
- 长文本 `letterSpacing` 保持 0；全大写标签可加 `0.5`。
- 数字对齐场景使用等宽字体，避免跳动。

## 示例

```ts
Text('标题')
  .fontSize(Token.Font.TitleLarge.size)
  .lineHeight(Token.Font.TitleLarge.lineHeight)
  .fontWeight(Token.Font.WeightMedium)
```

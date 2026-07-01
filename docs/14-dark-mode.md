# 14 Dark Mode · 深色模式

**所有 Token 都提供 Light / Dark 两套值。禁止写死颜色。**

## 原则

- 深色模式不是简单反色，而是重新映射语义 Token。
- 背景使用近黑（`#000000` / `#1E1E1E`）而非纯灰，减少眩光。
- 主色在深色下**提亮 + 降饱和**（如 `#2979FF` → `#6EA8FF`），保证对比与舒适。
- 大面积避免纯白，正文用 `OnSurface`（`#F5F5F5`）而非 `#FFFFFF`。

## 高度表达

深色下阴影不可见，改用 **表面叠加**（越高越亮），见 [Shadow](06-shadow.md)。

| 高度 | Surface 提亮 |
| --- | --- |
| Level0 | `#000000` |
| Level1 | +5% |
| Level2 | +8% |
| Level3 | +11% |
| Level4 | +14% |

## 实现

- 使用 ArkUI 资源限定目录 `dark`（颜色资源随 `@riclava/designsystem` 分发，见 [library/src/main/resources](../library/src/main/resources)）。
- 跟随系统：监听 `ConfigurationConstant.ColorMode`。
- 提供 App 内手动切换（跟随系统 / 浅色 / 深色）。

## 检查清单

- [ ] 无任何硬编码颜色
- [ ] Light / Dark 对比度均达标
- [ ] 图片 / 插画在深色下有适配或半透明遮罩
- [ ] 阴影改为 Surface 叠加
- [ ] 切换无闪烁、状态保持

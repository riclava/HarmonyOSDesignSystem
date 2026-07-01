# 07 Icon · 图标规范

## 尺寸

| Token | 值 (vp) | 用途 |
| --- | --- | --- |
| `IconXS` | 16 | 文字内联、辅助小图标 |
| `IconSM` | 20 | 列表项、输入框内图标 |
| `IconMD` | 24 | **默认尺寸**（导航、按钮） |
| `IconLG` | 28 | 强调图标 |
| `IconXL` | 32 | 顶部大图标 |
| `Icon2XL` | 48 | 空状态 / 引导插画图标 |

## 绘制规范

- 统一 **24dp 网格** 绘制，默认导出尺寸 24。
- 线宽统一 **2dp**，端点圆角 `RadiusXS`。
- 保持 2dp 内边距（visual padding），确保光学一致。
- 描边（Outline）与填充（Filled）风格不混用；同一界面统一一种。
- 选中态用 Filled，未选中用 Outline（如底部 Tab）。

## 颜色

- 图标颜色使用文字色 Token：`OnSurface` / `OnSurfaceVariant`。
- 激活态使用 `Primary`。
- 状态图标使用对应状态色（`Success` / `Warning` / `Danger`）。
- 禁止图标写死颜色。

## 命中区域

图标按钮的可点击区域不小于 **44×44 vp**（见 [无障碍](13-accessibility.md)），即使图标本身仅 24。

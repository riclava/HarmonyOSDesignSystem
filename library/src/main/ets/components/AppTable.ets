import { Token } from '../theme/Tokens';
import { LengthMetrics } from '@kit.ArkUI';

/** 列定义：标题 + 布局权重（默认 1）+ 对齐。 */
export class AppTableColumn {
  title: ResourceStr;
  weight: number;
  align: TextAlign;
  constructor(title: ResourceStr, weight: number = 1, align: TextAlign = TextAlign.Start) {
    this.title = title;
    this.weight = weight;
    this.align = align;
  }
}

/**
 * 轻量表格：表头 + 数据行，随 compact 收紧行高/字号。非虚拟滚动，适合中小数据量。
 * rows 为二维文案数组，列数应与 columns 对齐。
 */
@Component
export struct AppTable {
  @Prop columns: AppTableColumn[] = [];
  @Prop rows: ResourceStr[][] = [];
  @StorageLink('isDark') isDark: boolean = false;
  @StorageProp('compact') compact: boolean = false;

  private rowHeight(): number {
    return Token.size.rowMin(this.compact);
  }

  private cellText(row: ResourceStr[], col: number): ResourceStr {
    return col < row.length ? row[col] : '';
  }

  build() {
    Column() {
      Row() {
        ForEach(this.columns, (col: AppTableColumn, index: number) => {
          Text(col.title)
            .fontSize(Token.font.label.sizeFor(this.compact))
            .fontWeight(Token.font.label.weight)
            .fontColor(Token.color.onSurfaceVariant())
            .textAlign(col.align)
            .layoutWeight(col.weight)
            .padding({ start: LengthMetrics.vp(Token.space.xs), end: LengthMetrics.vp(Token.space.xs) })
        }, (col: AppTableColumn, index: number): string => index.toString())
      }
      .width('100%')
      .height(this.rowHeight())
      .backgroundColor(Token.color.background())
      .alignItems(VerticalAlign.Center)
      ForEach(this.rows, (row: ResourceStr[], rowIndex: number) => {
        Column() {
          Row() {
            ForEach(this.columns, (col: AppTableColumn, colIndex: number) => {
              Text(this.cellText(row, colIndex))
                .fontSize(Token.font.bodySmall.sizeFor(this.compact))
                .fontColor(Token.color.onSurface())
                .textAlign(col.align)
                .layoutWeight(col.weight)
                .padding({ start: LengthMetrics.vp(Token.space.xs), end: LengthMetrics.vp(Token.space.xs) })
            }, (col: AppTableColumn, colIndex: number): string => colIndex.toString())
          }
          .width('100%')
          .constraintSize({ minHeight: this.rowHeight() })
          .alignItems(VerticalAlign.Center)
          Divider().color(Token.color.divider())
        }
      }, (row: ResourceStr[], rowIndex: number): string => rowIndex.toString())
    }
    .width('100%')
    .backgroundColor(Token.color.surface())
  }
}

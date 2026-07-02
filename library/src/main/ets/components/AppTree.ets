import { Token, isRTL } from '../theme/Tokens';
import { LengthMetrics } from '@kit.ArkUI';

/** 树节点：label + 子节点 + 展开态。叶子节点 children 为空。 */
export class AppTreeNode {
  label: ResourceStr;
  children: AppTreeNode[];
  expanded: boolean;
  constructor(label: ResourceStr, children: AppTreeNode[] = [], expanded: boolean = false) {
    this.label = label;
    this.children = children;
    this.expanded = expanded;
  }
}

/** 内部：拍平后的可见行（携带层级缩进）。 */
class TreeRow {
  node: AppTreeNode;
  level: number;
  constructor(node: AppTreeNode, level: number) {
    this.node = node;
    this.level = level;
  }
}

/**
 * 树形控件：可展开的层级列表。展开态存于节点自身；点击父节点切换。
 * 通过内部 revision 触发重绘（节点展开态为普通对象属性）。
 */
@Component
export struct AppTree {
  @Prop nodes: AppTreeNode[] = [];
  @StorageLink('isDark') isDark: boolean = false;
  @StorageProp('compact') compact: boolean = false;
  @State private revision: number = 0;
  onSelect?: (node: AppTreeNode) => void;

  private flatten(list: AppTreeNode[], level: number, out: TreeRow[]): void {
    for (const node of list) {
      out.push(new TreeRow(node, level));
      if (node.expanded && node.children.length > 0) {
        this.flatten(node.children, level + 1, out);
      }
    }
  }

  private rows(): TreeRow[] {
    const out: TreeRow[] = [];
    this.flatten(this.nodes, 0, out);
    return out;
  }

  private indent(level: number): number {
    return Token.space.md + level * Token.space.lg;
  }

  private caret(node: AppTreeNode): Resource {
    if (node.expanded) {
      return $r('sys.symbol.chevron_down');
    }
    return isRTL() ? $r('sys.symbol.chevron_left') : $r('sys.symbol.chevron_right');
  }

  build() {
    Column() {
      ForEach(this.rows(), (row: TreeRow) => {
        Row() {
          if (row.node.children.length > 0) {
            SymbolGlyph(this.caret(row.node))
              .fontSize(Token.icon.xs)
              .fontColor([Token.color.onSurfaceVariant()])
              .width(Token.icon.sm)
              .height(Token.icon.sm)
              .margin({ end: LengthMetrics.vp(Token.space.xs) })
          } else {
            SymbolGlyph($r('sys.symbol.circle_fill'))
              .fontSize(Token.icon.xs)
              .fontColor([Token.color.outline()])
              .width(Token.icon.sm)
              .height(Token.icon.sm)
              .margin({ end: LengthMetrics.vp(Token.space.xs) })
          }
          Text(row.node.label)
            .fontSize(Token.font.body.sizeFor(this.compact))
            .fontColor(Token.color.onSurface())
            .layoutWeight(1)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
        }
        .width('100%')
        .constraintSize({ minHeight: Token.size.menuItem(this.compact) })
        .padding({
          start: LengthMetrics.vp(this.indent(row.level)),
          end: LengthMetrics.vp(Token.space.md)
        })
        .alignItems(VerticalAlign.Center)
        .responseRegion({ x: 0, y: 0, width: '100%', height: Token.size.minTouch })
        .onClick(() => {
          if (row.node.children.length > 0) {
            row.node.expanded = !row.node.expanded;
            this.revision++;
          } else if (this.onSelect) {
            this.onSelect(row.node);
          }
        })
      }, (row: TreeRow, index: number): string => `${index}-${this.revision}`)
    }
    .width('100%')
  }
}

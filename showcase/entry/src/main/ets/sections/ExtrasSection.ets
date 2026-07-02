import {
  Token,
  AppSelect, AppStepper, AppSegmented, AppRating, AppUpload, AppFormItem, AppChipGroup,
  AppDivider, AppNavBar, AppBreadcrumb, AppPagination, AppSteps,
  AppTable, AppTableColumn, AppAccordion, AppTree, AppTreeNode, AppSwiper, AppTooltip,
  AppTextField, AppToast
} from '@riclava/designsystem';
import { LengthMetrics } from '@kit.ArkUI';
import { DemoBlock } from './Widgets';

/** P2 扩展组件演示：表单 / 导航 / 数据展示 / 通用。 */
@Component
export struct ExtrasSection {
  @StorageLink('isDark') isDark: boolean = false;
  @StorageLink('brand') brand: string = 'default';
  @StorageProp('compact') compact: boolean = false;
  @State private priority: number = -1;
  @State private qty: number = 1;
  @State private seg: number = 0;
  @State private rating: number = 3;
  @State private page: number = 1;
  @State private accExpanded: boolean = false;
  @State private chips: ResourceStr[] = [
    $r('app.string.ext_chip_design'),
    $r('app.string.ext_chip_dev'),
    $r('app.string.ext_chip_test')
  ];
  @State private files: ResourceStr[] = [];

  private priorityOptions: ResourceStr[] = [
    $r('app.string.ext_opt_high'),
    $r('app.string.ext_opt_medium'),
    $r('app.string.ext_opt_low')
  ];
  private segments: ResourceStr[] = [
    $r('app.string.ext_seg_day'),
    $r('app.string.ext_seg_week'),
    $r('app.string.ext_seg_month')
  ];
  private crumbs: ResourceStr[] = [
    $r('app.string.ext_crumb_home'),
    $r('app.string.ext_crumb_category'),
    $r('app.string.ext_crumb_detail')
  ];
  private steps: ResourceStr[] = [
    $r('app.string.ext_step_cart'),
    $r('app.string.ext_step_pay'),
    $r('app.string.ext_step_done')
  ];
  private columns: AppTableColumn[] = [
    new AppTableColumn($r('app.string.ext_col_name'), 2),
    new AppTableColumn($r('app.string.ext_col_qty'), 1, TextAlign.End),
    new AppTableColumn($r('app.string.ext_col_price'), 1, TextAlign.End)
  ];
  private rows: ResourceStr[][] = [
    [$r('app.string.ext_row_apple'), $r('app.string.ext_qty_a'), $r('app.string.ext_price_a')],
    [$r('app.string.ext_row_banana'), $r('app.string.ext_qty_b'), $r('app.string.ext_price_b')]
  ];
  private treeNodes: AppTreeNode[] = [
    new AppTreeNode($r('app.string.ext_tree_docs'), [
      new AppTreeNode($r('app.string.ext_tree_design'), [
        new AppTreeNode($r('app.string.ext_tree_color')),
        new AppTreeNode($r('app.string.ext_tree_type'))
      ], true),
      new AppTreeNode($r('app.string.ext_tree_dev'))
    ], true)
  ];

  @Builder
  private slide(label: ResourceStr, bg: ResourceColor) {
    Column() {
      Text(label)
        .fontSize(Token.font.titleMedium.sizeFor(this.compact))
        .fontColor(Token.color.onSurface())
    }
    .width('100%')
    .height(Token.size.progressRing)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(bg)
    .borderRadius(Token.radius.lg)
  }

  build() {
    Column() {
      DemoBlock({ title: $r('app.string.sec_select') }) {
        AppSelect({
          options: this.priorityOptions,
          selectedIndex: this.priority,
          placeholder: $r('app.string.ext_select_ph'),
          onSelectIndex: (i: number): void => { this.priority = i; }
        })
      }

      DemoBlock({ title: $r('app.string.sec_stepper') }) {
        AppStepper({
          value: this.qty,
          min: 1,
          max: 10,
          onChange: (v: number): void => { this.qty = v; }
        })
      }

      DemoBlock({ title: $r('app.string.sec_segmented') }) {
        AppSegmented({
          segments: this.segments,
          selectedIndex: this.seg,
          onSelect: (i: number): void => { this.seg = i; }
        })
      }

      DemoBlock({ title: $r('app.string.sec_rating') }) {
        AppRating({
          rating: this.rating,
          onRate: (v: number): void => { this.rating = v; }
        })
      }

      DemoBlock({ title: $r('app.string.sec_formitem') }) {
        AppFormItem({
          label: $r('app.string.ext_form_label'),
          required: true,
          error: $r('app.string.ext_form_error')
        }) {
          AppTextField({ placeholder: $r('app.string.ext_form_ph') })
        }
      }

      DemoBlock({ title: $r('app.string.sec_chip') }) {
        AppChipGroup({
          chips: this.chips,
          onDelete: (i: number): void => {
            this.chips = this.chips.filter((item: ResourceStr, idx: number): boolean => idx !== i);
          }
        })
      }

      DemoBlock({ title: $r('app.string.sec_upload') }) {
        AppUpload({
          files: this.files,
          onAdd: (): void => { this.files = this.files.concat([$r('app.string.ext_file_name')]); },
          onRemove: (i: number): void => {
            this.files = this.files.filter((item: ResourceStr, idx: number): boolean => idx !== i);
          }
        })
      }

      DemoBlock({ title: $r('app.string.sec_divider') }) {
        AppDivider({ text: $r('app.string.ext_divider_text') })
      }

      DemoBlock({ title: $r('app.string.sec_navbar') }) {
        AppNavBar({
          title: $r('app.string.ext_navbar_title'),
          showBack: true,
          onBack: (): void => { AppToast.show($r('app.string.ext_crumb_home')); }
        })
      }

      DemoBlock({ title: $r('app.string.sec_breadcrumb') }) {
        AppBreadcrumb({
          items: this.crumbs,
          onSelect: (i: number): void => { AppToast.show(this.crumbs[i]); }
        })
      }

      DemoBlock({ title: $r('app.string.sec_pagination') }) {
        AppPagination({
          current: this.page,
          pageCount: 5,
          onChange: (p: number): void => { this.page = p; }
        })
      }

      DemoBlock({ title: $r('app.string.sec_steps') }) {
        AppSteps({ steps: this.steps, current: 1 })
      }

      DemoBlock({ title: $r('app.string.sec_table') }) {
        AppTable({ columns: this.columns, rows: this.rows })
      }

      DemoBlock({ title: $r('app.string.sec_accordion') }) {
        AppAccordion({
          title: $r('app.string.ext_acc_title'),
          expanded: this.accExpanded,
          onToggle: (v: boolean): void => { this.accExpanded = v; }
        }) {
          Text($r('app.string.ext_acc_body'))
            .fontSize(Token.font.bodySmall.sizeFor(this.compact))
            .fontColor(Token.color.onSurfaceVariant())
        }
      }

      DemoBlock({ title: $r('app.string.sec_tree') }) {
        AppTree({
          nodes: this.treeNodes,
          onSelect: (node: AppTreeNode): void => { AppToast.show(node.label); }
        })
      }

      DemoBlock({ title: $r('app.string.sec_swiper') }) {
        AppSwiper({ autoPlay: false, loop: true }) {
          this.slide($r('app.string.ext_slide_a'), Token.color.primaryContainer())
          this.slide($r('app.string.ext_slide_b'), Token.color.secondaryContainer())
          this.slide($r('app.string.ext_slide_c'), Token.color.primaryContainer())
        }
      }

      DemoBlock({ title: $r('app.string.sec_tooltip') }) {
        AppTooltip({ message: $r('app.string.ext_tip_msg') }) {
          Text($r('app.string.ext_tip_trigger'))
            .fontSize(Token.font.body.sizeFor(this.compact))
            .fontColor(Token.color.primary())
            .padding({ top: LengthMetrics.vp(Token.space.xs), bottom: LengthMetrics.vp(Token.space.xs) })
        }
      }
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .margin({ bottom: Token.space.lg })
  }
}

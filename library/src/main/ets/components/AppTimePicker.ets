import { Token } from '../theme/Tokens';
import { LengthMetrics } from '@kit.ArkUI';

/** 时间选择器形态。 */
export enum AppTimePickerMode {
  /** 内嵌滚轮（常驻显示）。 */
  Inline = 'inline',
  /** 字段入口，点击弹出时间选择弹窗。 */
  Field = 'field'
}

/**
 * 时间选择器。
 * - Field（默认）：可点字段，展示已选时间 + 时钟图标，点击弹出 TimePickerDialog；支持 label/helper/error/disabled。
 * - Inline：常驻滚轮，选中项 Primary。
 * 支持 compact 密度；默认 24 小时制，可选显示秒。
 */
@Component
export struct AppTimePicker {
  /** 形态：Field（字段+弹窗）/ Inline（内嵌滚轮）。 */
  @Prop mode: AppTimePickerMode = AppTimePickerMode.Field;
  /** 已选时间（读取时/分/秒）。 */
  @Prop selected: Date = new Date();
  /** 字段上方标签（仅 Field）。 */
  @Prop label: ResourceStr = '';
  /** 未选择时的占位文案（仅 Field）。 */
  @Prop placeholder: ResourceStr = $r('app.string.ds_time_placeholder');
  /** 辅助说明（仅 Field）。 */
  @Prop helper: ResourceStr = '';
  /** 错误信息，非空时字段转为 Danger（仅 Field）。 */
  @Prop error: ResourceStr = '';
  /** 禁用（仅 Field）。 */
  @Prop fieldDisabled: boolean = false;
  /** 24 小时制，默认 true；false 为上午/下午制。 */
  @Prop useMilitaryTime: boolean = true;
  /** 显示秒，默认 false（仅时:分）。 */
  @Prop showSeconds: boolean = false;
  @StorageLink('isDark') isDark: boolean = false;
  @StorageProp('compact') compact: boolean = false;
  /** 是否已经选择过（Field 初始展示占位）。 */
  @State private picked: boolean = false;
  /** 当前展示的时间。 */
  @State private current: Date = new Date();
  onPick?: (value: TimePickerResult) => void;

  aboutToAppear(): void {
    this.current = this.selected;
  }

  private pickerFormat(): TimePickerFormat {
    return this.showSeconds ? TimePickerFormat.HOUR_MINUTE_SECOND : TimePickerFormat.HOUR_MINUTE;
  }

  private pad(n: number): string {
    return n < 10 ? `0${n}` : `${n}`;
  }

  /** 依据系统区域 + 24h/12h + 是否显秒，用标准 Intl 做本地化格式化（AM/PM、次序均随语言）。 */
  private displayText(): string {
    const options: Intl.DateTimeFormatOptions = {
      hour: '2-digit',
      minute: '2-digit',
      hour12: !this.useMilitaryTime
    };
    if (this.showSeconds) {
      options.second = '2-digit';
    }
    try {
      const formatter: Intl.DateTimeFormat = new Intl.DateTimeFormat(undefined, options);
      return formatter.format(this.current);
    } catch (err) {
      return this.fallbackText();
    }
  }

  /** Intl 不可用时的兜底格式（24h，零填充）。 */
  private fallbackText(): string {
    const base: string = `${this.pad(this.current.getHours())}:${this.pad(this.current.getMinutes())}`;
    return this.showSeconds ? `${base}:${this.pad(this.current.getSeconds())}` : base;
  }

  private hasText(value: ResourceStr): boolean {
    return typeof value !== 'string' || value.length > 0;
  }

  /** 无障碍朗读文案：已选朗读时间；字符串占位直接朗读，资源占位交给可见文本自身。 */
  private accessibilityLabel(): string {
    if (this.picked) {
      return this.displayText();
    }
    if (typeof this.placeholder === 'string') {
      return this.placeholder;
    }
    return '';
  }

  private fieldBorderColor(): ResourceColor {
    if (this.hasText(this.error)) {
      return Token.color.danger();
    }
    return Token.color.outline();
  }

  private fieldTouch(): number {
    return Math.max(Token.size.field(this.compact), Token.size.minTouch);
  }

  private selectedTextStyle(): PickerTextStyle {
    return {
      color: Token.color.primary(),
      font: { size: Token.font.titleMedium.sizeFor(this.compact), weight: FontWeight.Medium }
    };
  }

  private normalTextStyle(): PickerTextStyle {
    return {
      color: Token.color.onSurface(),
      font: { size: Token.font.body.sizeFor(this.compact) }
    };
  }

  private disappearTextStyle(): PickerTextStyle {
    return {
      color: Token.color.onSurfaceVariant(),
      font: { size: Token.font.bodySmall.sizeFor(this.compact) }
    };
  }

  private openDialog(): void {
    this.getUIContext().showTimePickerDialog({
      selected: this.current,
      format: this.pickerFormat(),
      useMilitaryTime: this.useMilitaryTime,
      selectedTextStyle: this.selectedTextStyle(),
      textStyle: this.normalTextStyle(),
      disappearTextStyle: this.disappearTextStyle(),
      acceptButtonStyle: { fontColor: Token.color.onPrimary(), backgroundColor: Token.color.primary() },
      cancelButtonStyle: { fontColor: Token.color.primary() },
      backgroundColor: Token.color.surface(),
      onAccept: (value: TimePickerResult) => {
        const next: Date = new Date(this.current);
        next.setHours(value.hour ?? 0, value.minute ?? 0, value.second ?? 0);
        this.current = next;
        this.picked = true;
        if (this.onPick) {
          this.onPick(value);
        }
      }
    });
  }

  @Builder
  private FieldView() {
    Column() {
      if (this.hasText(this.label)) {
        Text(this.label)
          .fontSize(Token.font.label.sizeFor(this.compact))
          .fontWeight(Token.font.label.weight)
          .fontColor(Token.color.onSurface())
          .margin({ bottom: Token.space.xxs })
      }
      Row() {
        Text(this.picked ? this.displayText() : this.placeholder)
          .fontSize(Token.font.body.sizeFor(this.compact))
          .fontColor(this.picked ? Token.color.onSurface() : Token.color.onSurfaceVariant())
          .layoutWeight(1)
        SymbolGlyph($r('sys.symbol.clock'))
          .fontSize(Token.icon.sm)
          .fontColor([Token.color.onSurfaceVariant()])
          .renderingStrategy(SymbolRenderingStrategy.MULTIPLE_OPACITY)
          .width(Token.icon.sm)
          .height(Token.icon.sm)
          .margin({ start: LengthMetrics.vp(Token.space.xs) })
      }
      .width('100%')
      .height(Token.size.field(this.compact))
      .padding({ start: LengthMetrics.vp(Token.space.md), end: LengthMetrics.vp(Token.space.md) })
      .backgroundColor(this.fieldDisabled ? Token.color.divider() : Token.color.surface())
      .borderRadius(Token.radius.sm)
      .border({ width: 1, color: this.fieldBorderColor() })
      .alignItems(VerticalAlign.Center)
      .opacity(this.fieldDisabled ? 0.38 : 1)
      .enabled(!this.fieldDisabled)
      .accessibilityText(this.accessibilityLabel())
      .responseRegion({ x: 0, y: (Token.size.field(this.compact) - this.fieldTouch()) / 2, width: '100%', height: this.fieldTouch() })
      .onClick(() => {
        if (!this.fieldDisabled) {
          this.openDialog();
        }
      })
      if (this.hasText(this.error)) {
        Text(this.error)
          .fontSize(Token.font.caption.sizeFor(this.compact))
          .fontColor(Token.color.danger())
          .margin({ top: Token.space.xxs })
      } else if (this.hasText(this.helper)) {
        Text(this.helper)
          .fontSize(Token.font.caption.sizeFor(this.compact))
          .fontColor(Token.color.onSurfaceVariant())
          .margin({ top: Token.space.xxs })
      }
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }

  @Builder
  private InlineView() {
    TimePicker({ selected: this.current, format: this.pickerFormat() })
      .useMilitaryTime(this.useMilitaryTime)
      .selectedTextStyle(this.selectedTextStyle())
      .textStyle(this.normalTextStyle())
      .disappearTextStyle(this.disappearTextStyle())
      .backgroundColor(Token.color.surface())
      .borderRadius(Token.radius.md)
      .onChange((value: TimePickerResult) => {
        const next: Date = new Date(this.current);
        next.setHours(value.hour ?? 0, value.minute ?? 0, value.second ?? 0);
        this.current = next;
        this.picked = true;
        if (this.onPick) {
          this.onPick(value);
        }
      })
  }

  build() {
    if (this.mode === AppTimePickerMode.Inline) {
      this.InlineView();
    } else {
      this.FieldView();
    }
  }
}

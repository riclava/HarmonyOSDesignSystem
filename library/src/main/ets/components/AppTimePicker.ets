import { Token } from '../theme/Tokens';

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
  @Prop label: string = '';
  /** 未选择时的占位文案（仅 Field）。 */
  @Prop placeholder: string = '选择时间';
  /** 辅助说明（仅 Field）。 */
  @Prop helper: string = '';
  /** 错误信息，非空时字段转为 Danger（仅 Field）。 */
  @Prop error: string = '';
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

  /** 依据 24h/12h 与是否显秒格式化展示文案。 */
  private displayText(): string {
    const h: number = this.current.getHours();
    const m: number = this.current.getMinutes();
    const s: number = this.current.getSeconds();
    if (this.useMilitaryTime) {
      const base: string = `${this.pad(h)}:${this.pad(m)}`;
      return this.showSeconds ? `${base}:${this.pad(s)}` : base;
    }
    const isPM: boolean = h >= 12;
    let h12: number = h % 12;
    if (h12 === 0) {
      h12 = 12;
    }
    const suffix: string = isPM ? '下午' : '上午';
    const base: string = `${suffix} ${this.pad(h12)}:${this.pad(m)}`;
    return this.showSeconds ? `${base}:${this.pad(s)}` : base;
  }

  private fieldBorderColor(): ResourceColor {
    if (this.error.length > 0) {
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
    TimePickerDialog.show({
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
      if (this.label.length > 0) {
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
        Text('🕐')
          .fontSize(Token.font.body.sizeFor(this.compact))
          .fontColor(Token.color.onSurfaceVariant())
          .margin({ left: Token.space.xs })
      }
      .width('100%')
      .height(Token.size.field(this.compact))
      .padding({ left: Token.space.md, right: Token.space.md })
      .backgroundColor(this.fieldDisabled ? Token.color.divider() : Token.color.surface())
      .borderRadius(Token.radius.sm)
      .border({ width: 1, color: this.fieldBorderColor() })
      .alignItems(VerticalAlign.Center)
      .opacity(this.fieldDisabled ? 0.38 : 1)
      .enabled(!this.fieldDisabled)
      .accessibilityText(this.picked ? this.displayText() : this.placeholder)
      .responseRegion({ x: 0, y: (Token.size.field(this.compact) - this.fieldTouch()) / 2, width: '100%', height: this.fieldTouch() })
      .onClick(() => {
        if (!this.fieldDisabled) {
          this.openDialog();
        }
      })
      if (this.error.length > 0) {
        Text(this.error)
          .fontSize(Token.font.caption.sizeFor(this.compact))
          .fontColor(Token.color.danger())
          .margin({ top: Token.space.xxs })
      } else if (this.helper.length > 0) {
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

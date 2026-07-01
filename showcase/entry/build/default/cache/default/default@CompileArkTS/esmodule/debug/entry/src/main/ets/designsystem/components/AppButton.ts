if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface AppButton_Params {
    label?: string;
    type?: AppButtonType;
    btnSize?: AppButtonSize;
    disabled?: boolean;
    isDark?: boolean;
    onClickAction?: () => void;
}
import { Token } from "@bundle:com.riclava.dsshowcase/entry/ets/designsystem/Tokens";
export enum AppButtonType {
    Primary = 0,
    Secondary = 1,
    Text = 2,
    Danger = 3
}
export enum AppButtonSize {
    Large = 0,
    Medium = 1,
    Small = 2
}
export class AppButton extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__label = new SynchedPropertySimpleOneWayPU(params.label, this, "label");
        this.__type = new SynchedPropertySimpleOneWayPU(params.type, this, "type");
        this.__btnSize = new SynchedPropertySimpleOneWayPU(params.btnSize, this, "btnSize");
        this.__disabled = new SynchedPropertySimpleOneWayPU(params.disabled, this, "disabled");
        this.__isDark = this.createStorageLink('isDark', false, "isDark");
        this.onClickAction = undefined;
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: AppButton_Params) {
        if (params.type === undefined) {
            this.__type.set(AppButtonType.Primary);
        }
        if (params.btnSize === undefined) {
            this.__btnSize.set(AppButtonSize.Medium);
        }
        if (params.disabled === undefined) {
            this.__disabled.set(false);
        }
        if (params.onClickAction !== undefined) {
            this.onClickAction = params.onClickAction;
        }
    }
    updateStateVars(params: AppButton_Params) {
        this.__label.reset(params.label);
        this.__type.reset(params.type);
        this.__btnSize.reset(params.btnSize);
        this.__disabled.reset(params.disabled);
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__label.purgeDependencyOnElmtId(rmElmtId);
        this.__type.purgeDependencyOnElmtId(rmElmtId);
        this.__btnSize.purgeDependencyOnElmtId(rmElmtId);
        this.__disabled.purgeDependencyOnElmtId(rmElmtId);
        this.__isDark.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__label.aboutToBeDeleted();
        this.__type.aboutToBeDeleted();
        this.__btnSize.aboutToBeDeleted();
        this.__disabled.aboutToBeDeleted();
        this.__isDark.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    private __label: SynchedPropertySimpleOneWayPU<string>;
    get label() {
        return this.__label.get();
    }
    set label(newValue: string) {
        this.__label.set(newValue);
    }
    private __type: SynchedPropertySimpleOneWayPU<AppButtonType>;
    get type() {
        return this.__type.get();
    }
    set type(newValue: AppButtonType) {
        this.__type.set(newValue);
    }
    private __btnSize: SynchedPropertySimpleOneWayPU<AppButtonSize>;
    get btnSize() {
        return this.__btnSize.get();
    }
    set btnSize(newValue: AppButtonSize) {
        this.__btnSize.set(newValue);
    }
    private __disabled: SynchedPropertySimpleOneWayPU<boolean>;
    get disabled() {
        return this.__disabled.get();
    }
    set disabled(newValue: boolean) {
        this.__disabled.set(newValue);
    }
    // 保证深浅色切换时重绘
    private __isDark: ObservedPropertyAbstractPU<boolean>;
    get isDark() {
        return this.__isDark.get();
    }
    set isDark(newValue: boolean) {
        this.__isDark.set(newValue);
    }
    private onClickAction?: () => void;
    private btnHeight(): number {
        switch (this.btnSize) {
            case AppButtonSize.Large: return 48;
            case AppButtonSize.Small: return 32;
            default: return 40;
        }
    }
    private hPadding(): number {
        switch (this.btnSize) {
            case AppButtonSize.Large: return Token.space.lg;
            case AppButtonSize.Small: return Token.space.sm;
            default: return Token.space.md;
        }
    }
    private bgColor(): ResourceColor {
        if (this.type === AppButtonType.Primary)
            return Token.color.primary();
        if (this.type === AppButtonType.Danger)
            return Token.color.danger();
        return Token.color.transparent();
    }
    private fgColor(): ResourceColor {
        if (this.type === AppButtonType.Primary || this.type === AppButtonType.Danger) {
            return Token.color.onPrimary();
        }
        return Token.color.primary();
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(this.label);
            Text.fontSize(Token.font.label.size);
            Text.fontWeight(Token.font.label.weight);
            Text.fontColor(this.fgColor());
            Text.textAlign(TextAlign.Center);
            Text.height(this.btnHeight());
            Text.padding({ left: this.hPadding(), right: this.hPadding() });
            Text.backgroundColor(this.bgColor());
            Text.borderRadius(Token.radius.sm);
            Text.border(this.type === AppButtonType.Secondary
                ? { width: 1, color: Token.color.outline() }
                : { width: 0 });
            Text.opacity(this.disabled ? 0.38 : 1);
            Text.enabled(!this.disabled);
            Text.onClick(() => { if (!this.disabled && this.onClickAction)
                this.onClickAction(); });
        }, Text);
        Text.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}

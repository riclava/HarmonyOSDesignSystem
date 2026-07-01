if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface AppTag_Params {
    label?: string;
    tone?: AppTagTone;
    isDark?: boolean;
}
import { Token } from "@bundle:com.riclava.dsshowcase/entry/ets/designsystem/Tokens";
export enum AppTagTone {
    Neutral = 0,
    Primary = 1,
    Success = 2,
    Warning = 3,
    Danger = 4,
    Info = 5
}
export class AppTag extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__label = new SynchedPropertySimpleOneWayPU(params.label, this, "label");
        this.__tone = new SynchedPropertySimpleOneWayPU(params.tone, this, "tone");
        this.__isDark = this.createStorageLink('isDark', false, "isDark");
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: AppTag_Params) {
        if (params.tone === undefined) {
            this.__tone.set(AppTagTone.Neutral);
        }
    }
    updateStateVars(params: AppTag_Params) {
        this.__label.reset(params.label);
        this.__tone.reset(params.tone);
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__label.purgeDependencyOnElmtId(rmElmtId);
        this.__tone.purgeDependencyOnElmtId(rmElmtId);
        this.__isDark.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__label.aboutToBeDeleted();
        this.__tone.aboutToBeDeleted();
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
    private __tone: SynchedPropertySimpleOneWayPU<AppTagTone>;
    get tone() {
        return this.__tone.get();
    }
    set tone(newValue: AppTagTone) {
        this.__tone.set(newValue);
    }
    private __isDark: ObservedPropertyAbstractPU<boolean>;
    get isDark() {
        return this.__isDark.get();
    }
    set isDark(newValue: boolean) {
        this.__isDark.set(newValue);
    }
    private fg(): ResourceColor {
        switch (this.tone) {
            case AppTagTone.Primary: return Token.color.primary();
            case AppTagTone.Success: return Token.color.success();
            case AppTagTone.Warning: return Token.color.warning();
            case AppTagTone.Danger: return Token.color.danger();
            case AppTagTone.Info: return Token.color.info();
            default: return Token.color.onSurfaceVariant();
        }
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(this.label);
            Text.fontSize(Token.font.caption.size);
            Text.fontColor(this.fg());
            Text.height(24);
            Text.padding({ left: Token.space.xs, right: Token.space.xs });
            Text.borderRadius(Token.radius.full);
            Text.border({ width: 1, color: this.fg() });
            Text.textAlign(TextAlign.Center);
        }, Text);
        Text.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
